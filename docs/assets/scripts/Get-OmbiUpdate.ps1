# --------------------------------------------------------
# Script: Get-OmbiUpdate.ps1
# Author: Dyson Parkes, Berserkir-Net
# Contributors: Ryder, RyderTech, Ryan Joachim
# Date: 08/17/2025 14:50:00
# Keywords: Media Tools, Update Scripts, Ombi
# Comments: Enhanced reliability (mostly personal preferences), atomic operations, better error handling and logging for automation
# --------------------------------------------------------
# .\Get-OmbiUpdate.ps1 -APIKey YOURAPIKEY -OmbiURL https://ombi.example.com

[CmdletBinding()]
param(
    # The API key to be used when requesting current details from your Ombi installation
    [Parameter(Mandatory=$true, HelpMessage="Your Ombi API Key")]
    [string]$APIKey,

    # The folder Ombi is running from
    [Parameter(Mandatory=$true, HelpMessage="The folder you are running Ombi from")]
    [string]$OmbiDir,

    # The address Ombi is listening on (default is http://localhost:5000)
    [Parameter(HelpMessage="The address Ombi is listening on (default is http://localhost:5000)")]
    [string]$OmbiURL = "http://localhost:5000",

    # The folder to store downloads in temporarily
    [Parameter(HelpMessage="The folder you want Ombi to download to temporarily")]
    [string]$UpdaterPath = "$env:userprofile\Downloads\Ombi-Updates\",

    # The name of the Ombi Service (Default: Ombi, can override)
    [Parameter(HelpMessage="The name of the Ombi Service (Default: Ombi, can override)")]
    [string]$ServiceName = "Ombi",

    # The filename of the Ombi download
    [Parameter(HelpMessage="Filename of the Ombi archive to download")]
    [string]$Filename = "win-x64.zip",

    # Is this a forced reinstall?
    [Parameter(HelpMessage="Is this a forced reinstall?")]
    [Switch]$Force,

    # Service operation timeout in seconds
    [Parameter(HelpMessage="Service operation timeout in seconds")]
    [int]$ServiceTimeoutSeconds = 60,
    
    # Base directory for backups
    [Parameter(HelpMessage="Base directory for storing Ombi backups")]
    [string]$BackupPath = "C:\OMBI backups"
)

#region Helper Functions
function Write-StatusMessage {
    param(
        [string]$Message,
        [ValidateSet("Info", "Warning", "Error", "Success")]
        [string]$Level = "Info"
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] $($Level.ToUpper()): $Message"
}

function Test-Administrator {
    $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-UpdatePreconditions {
    param(
        [string]$OmbiDir,
        [string]$UpdaterPath,
        [string]$ServiceName
    )
    
    # Check if service exists
    try {
        Get-Service -Name $ServiceName -ErrorAction Stop | Out-Null
    }
    catch {
        throw "Service '$ServiceName' not found. Please verify the service name."
    }
    
    # Check write permissions for Ombi directory
    try {
        $testFile = Join-Path $OmbiDir "write_test_$(Get-Random).tmp"
        New-Item -Path $testFile -ItemType File -Force | Out-Null
        Remove-Item $testFile -Force
    }
    catch {
        throw "Insufficient write permissions for Ombi directory: $OmbiDir"
    }
    
}

function Wait-ServiceState {
    param(
        [string]$ServiceName,
        [ValidateSet("Running", "Stopped")]
        [string]$TargetState,
        [int]$TimeoutSeconds = 60
    )
    
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    
    do {
        try {
            $service = Get-Service -Name $ServiceName -ErrorAction Stop
            if ($service.Status -eq $TargetState) {
                Write-StatusMessage "Service '$ServiceName' reached state: $TargetState"
                return $true
            }
            Start-Sleep -Seconds 2
        }
        catch {
            Write-StatusMessage "Error checking service state: $_" "Warning"
            return $false
        }
    } while ($stopwatch.Elapsed.TotalSeconds -lt $TimeoutSeconds)
    
    Write-StatusMessage "Timeout waiting for service '$ServiceName' to reach state: $TargetState" "Warning"
    return $false
}

function Manage-OmbiService {
    param(
        [string]$ServiceName,
        [ValidateSet("Start", "Stop")]
        [string]$Action,
        [int]$TimeoutSeconds = 60
    )
    
    try {
        $service = Get-Service -Name $ServiceName -ErrorAction Stop
        $targetState = if ($Action -eq "Start") { "Running" } else { "Stopped" }
        
        if ($service.Status -eq $targetState) {
            Write-StatusMessage "Service '$ServiceName' is already $($targetState.ToLower())"
            return $true
        }
        
        Write-StatusMessage "$($Action)ing service: $ServiceName"
        if ($Action -eq "Start") {
            Start-Service -Name $ServiceName -ErrorAction Stop
        }
        else {
            Stop-Service -Name $ServiceName -Force -ErrorAction Stop
        }
        
        if (Wait-ServiceState -ServiceName $ServiceName -TargetState $targetState -TimeoutSeconds $TimeoutSeconds) {
            return $true
        }
        else {
            throw "Service failed to $($Action.ToLower()) within timeout period"
        }
    }
    catch {
        Write-StatusMessage "Failed to $($Action.ToLower()) service '$ServiceName': $_" "Error"
        throw
    }
}

function Preserve-OmbiConfiguration {
    param(
        [string]$SourceDir,
        [string]$BackupDir
    )
    
    # Files that must be preserved based on manual update instructions
    $criticalFiles = @(
        "database.json",        # Required by manual instructions
        "Ombi.db",             # Database file
        "OmbiExternal.db",     # External database file  
        "OmbiSettings.db"      # Settings database file
    )
    
    $preservedFiles = @()
    $sourceFiles = @()
    
    # Create backup directory
    New-Item -Path $BackupDir -ItemType Directory -Force -ErrorAction Stop | Out-Null
    
    # First, identify which critical files exist in the source
    foreach ($file in $criticalFiles) {
        $sourcePath = Join-Path $SourceDir $file
        if (Test-Path $sourcePath) {
            $sourceFiles += $file
        }
    }
    
    if ($sourceFiles.Count -eq 0) {
        Write-StatusMessage "No configuration files found to preserve" "Warning"
        return $preservedFiles
    }
    
    Write-StatusMessage "Creating backup at: $BackupDir"
    
    # Copy files to backup directory
    foreach ($file in $sourceFiles) {
        $sourcePath = Join-Path $SourceDir $file
        $backupPath = Join-Path $BackupDir $file
        
        try {
            Copy-Item $sourcePath $backupPath -Force
            $preservedFiles += $file
            Write-StatusMessage "Backed up: $file"
        }
        catch {
            throw "Failed to backup $file. Original error: $_"
        }
    }
    
    # Verify backup completeness
    Write-StatusMessage "Verifying backup completeness"
    foreach ($file in $sourceFiles) {
        $backupPath = Join-Path $BackupDir $file
        if (-not (Test-Path $backupPath)) {
            throw "Backup verification failed: $file is missing from backup directory"
        }
    }
    
    Write-StatusMessage "Backup verification completed - all $($sourceFiles.Count) files successfully backed up" "Success"
    return $preservedFiles
}

function Get-ValidatedUpdate {
    param(
        [string]$DownloadUrl,
        [string]$OutputPath
    )
    
    try {
        Write-StatusMessage "Downloading from: $DownloadUrl"
        
        # Add GitHub-friendly headers to avoid rate limiting
        $headers = @{
            'User-Agent' = 'Ombi-Updater-PowerShell/1.0'
            'Accept' = 'application/octet-stream'
        }
        
        # Download with extended timeout for large files
        Invoke-WebRequest -Uri $DownloadUrl -OutFile $OutputPath -Headers $headers -TimeoutSec 600
        
        if (-not (Test-Path $OutputPath)) {
            throw "Download failed - file not found: $OutputPath"
        }
        
        # Validate ZIP file integrity
        try {
            Add-Type -AssemblyName System.IO.Compression.FileSystem
            $zip = [System.IO.Compression.ZipFile]::OpenRead($OutputPath)
            $entryCount = $zip.Entries.Count
            $zip.Dispose()
            
            if ($entryCount -eq 0) {
                throw "ZIP file appears to be empty"
            }
            
            Write-StatusMessage "Download validated - ZIP contains $entryCount entries"
        }
        catch {
            throw "Downloaded file is not a valid ZIP archive: $_"
        }
        
        return $OutputPath
    }
    catch {
        Write-StatusMessage "Download failed: $_" "Error"
        throw
    }
}

function Install-UpdateAtomic {
    param(
        [string]$ZipFile,
        [string]$OmbiDir,
        [string]$StagingDir,
        [string[]]$PreservedFiles,
        [string]$PreservationDir
    )
    
    try {
        # Step 1: Extract to staging directory
        Write-StatusMessage "Extracting release files to staging area"
        New-Item -Path $StagingDir -ItemType Directory -Force -ErrorAction Stop | Out-Null
        Expand-Archive $ZipFile -DestinationPath $StagingDir -Force
        
        # Step 2: Validate extraction
        $extractedFiles = Get-ChildItem $StagingDir -Recurse -File
        if ($extractedFiles.Count -eq 0) {
            throw "No files were extracted from the archive"
        }
        Write-StatusMessage "Extracted $($extractedFiles.Count) files to staging area"
        
        # Step 3: Restore preserved configuration files INTO the staging directory
        if ($PreservedFiles.Count -gt 0) {
            Write-StatusMessage "Copying preserved configuration files to staging area"
            foreach ($file in $PreservedFiles) {
                $sourcePath = Join-Path $PreservationDir $file
                $destinationPath = Join-Path $StagingDir $file
                if (Test-Path $sourcePath) {
                    Copy-Item $sourcePath $destinationPath -Force
                    Write-StatusMessage "Staged for restoration: $file"
                }
            }
        }
        
        # Step 4: Perform the atomic swap
        $oldOmbiDir = "$OmbiDir-old-$(Get-Date -Format 'yyyyMMddHHmmss')"
        Write-StatusMessage "Performing atomic swap: Renaming '$OmbiDir' to '$oldOmbiDir'"
        Rename-Item -Path $OmbiDir -NewName $oldOmbiDir -Force

        try {
            Write-StatusMessage "Moving staged version to '$OmbiDir'"
            Move-Item -Path $StagingDir -Destination $OmbiDir -Force
        }
        catch {
            # Rollback on failure
            Write-StatusMessage "Failed to move staged version. Rolling back..." "Error"
            Rename-Item -Path $oldOmbiDir -NewName $OmbiDir -Force
            throw "Installation failed during move. Rolled back to previous version."
        }

        # Step 5: Cleanup the old directory
        Write-StatusMessage "Installation successful. Cleaning up old version at '$oldOmbiDir'"
        Remove-Item -Path $oldOmbiDir -Recurse -Force -ErrorAction SilentlyContinue

        Write-StatusMessage "Installation completed successfully"
    }
    catch {
        Write-StatusMessage "Installation failed: $_" "Error"
        throw
    }
}
#endregion

#region Version Functions
function Get-CurrentDetails {
    param([string]$URL, [hashtable]$HeaderValues)
    
    try {
        $uri = "$URL/api/v1/Settings/about/"
        Write-StatusMessage "Checking current Ombi version at: $uri"
        $result = Invoke-RestMethod -Uri $uri -Headers $HeaderValues -TimeoutSec 30
        
        if (-not $result.version) {
            throw "Invalid response: version property not found"
        }
        
        return $result
    }
    catch {
        Write-StatusMessage "Failed to get current Ombi details: $_" "Error"
        throw
    }
}

function Get-LatestReleaseInfo {
    param(
        [string]$Filename
    )
    try {
        Write-StatusMessage "Checking for latest Ombi release on GitHub"
        
        $headers = @{
            'User-Agent' = 'Ombi-Updater-PowerShell/1.0'
            'Accept' = 'application/vnd.github.v3+json'
        }
        
        $releases = Invoke-RestMethod -Uri "https://api.github.com/repos/Ombi-app/Ombi/releases" -Headers $headers -TimeoutSec 30
        
        if (-not $releases -or $releases.Count -eq 0) {
            throw "No releases found"
        }
        
        $latestRelease = $releases[0]
        $latestTag = $latestRelease.tag_name
        if (-not $latestTag) {
            throw "Latest release has no tag name"
        }
        
        $version = $latestTag -replace '^v', ''
        
        # Find the correct asset by filename
        $asset = $latestRelease.assets | Where-Object { $_.name -eq $Filename }
        if (-not $asset) {
            throw "Could not find asset '$Filename' in latest release '$latestTag'. Available assets: $($latestRelease.assets.name -join ', ')"
        }
        
        Write-StatusMessage "Latest version found: $version"
        return @{
            Version = $version
            DownloadUrl = $asset.browser_download_url
        }
    }
    catch {
        Write-StatusMessage "Failed to get latest release info: $_" "Error"
        throw
    }
}

#endregion

#region Main Script Logic
try {
    # Check for Administrator privileges first
    if (-not (Test-Administrator)) {
        throw "This script must be run with Administrator privileges to manage Windows services."
    }

    Write-StatusMessage "Starting Ombi update process"
    
    # Validate preconditions
    Test-UpdatePreconditions -OmbiDir $OmbiDir -UpdaterPath $UpdaterPath -ServiceName $ServiceName
    
    # API headers
    $headers = @{
        'Apikey' = $APIKey
        'accept' = 'application/json'
    }
    
    # Get version information
    $OmbiCurrent = $null
    $LatestRelease = $null
    $OmbiUpdate = $null
    $UpdateNeeded = $false

    try {
        Write-StatusMessage "Checking current and latest versions"
        $OmbiCurrent = Get-CurrentDetails -URL $OmbiURL -HeaderValues $headers
        $LatestRelease = Get-LatestReleaseInfo -Filename $Filename
        $OmbiUpdate = $LatestRelease.Version
        if ($OmbiCurrent.version -ne $OmbiUpdate) { $UpdateNeeded = $true }
        Write-StatusMessage "Current version: $($OmbiCurrent.version)"
        Write-StatusMessage "Latest version: $OmbiUpdate"
    }
    catch {
        if (-not $Force) {
            throw "Failed to get version information. Use -Force to update regardless of the current version. Original error: $_"
        }
        Write-StatusMessage "Could not get current version, but -Force was specified. Proceeding with update." "Warning"
        try {
            if (-not $LatestRelease) {
                $LatestRelease = Get-LatestReleaseInfo -Filename $Filename
                $OmbiUpdate = $LatestRelease.Version
            }
        }
        catch {
            throw "FATAL: Could not determine latest release info from GitHub. Cannot proceed. Original error: $_"
        }
    }
    
    if ($UpdateNeeded -or $Force) {
        Write-StatusMessage "Update required. Starting update process..." "Warning"
        
        # Create necessary directories
        New-Item -Path $UpdaterPath -ItemType Directory -Force -ErrorAction Stop | Out-Null
        
        # Generate paths
        $name = $Filename.Split(".")[0]
        $zip = Join-Path $UpdaterPath "$name-v$OmbiUpdate.zip"
        $stagingDir = Join-Path $UpdaterPath "Staging-v$OmbiUpdate"
        $backupVersion = if ($OmbiCurrent) { $OmbiCurrent.version } else { "unknown-$(Get-Date -Format 'yyyyMMdd-HHmmss')" }
        $versionedBackupDir = Join-Path $BackupPath "Ombi-v$backupVersion"
        $download = $LatestRelease.DownloadUrl
        
        try {
            # Step 1: Download and validate update package
            $zipPath = Get-ValidatedUpdate -DownloadUrl $download -OutputPath $zip
            
            # Step 2: Stop Ombi service
            Manage-OmbiService -ServiceName $ServiceName -Action "Stop" -TimeoutSeconds $ServiceTimeoutSeconds
            
            # Step 3: Create backup of critical configuration files
            $preservedFiles = Preserve-OmbiConfiguration -SourceDir $OmbiDir -BackupDir $versionedBackupDir
            
            # Step 4: Perform atomic installation
            Install-UpdateAtomic -ZipFile $zipPath -OmbiDir $OmbiDir -StagingDir $stagingDir -PreservedFiles $preservedFiles -PreservationDir $versionedBackupDir
            
            # Step 5: Start Ombi service
            Manage-OmbiService -ServiceName $ServiceName -Action "Start" -TimeoutSeconds $ServiceTimeoutSeconds
            
            Write-StatusMessage "Ombi successfully updated from $($OmbiCurrent.version) to $OmbiUpdate" "Success"
            
        }
        catch {
            Write-StatusMessage "Update failed: $_" "Error"
            
            # Attempt emergency service restart
            try {
                Write-StatusMessage "Attempting to restart Ombi service" "Warning"
                Manage-OmbiService -ServiceName $ServiceName -Action "Start" -TimeoutSeconds $ServiceTimeoutSeconds
                Write-StatusMessage "Service restarted, but update may have failed" "Warning"
            }
            catch {
                Write-StatusMessage "Failed to restart service: $_" "Error"
                Write-StatusMessage "Manual intervention may be required" "Error"
            }
            
            throw
        }
        finally {
            # Cleanup temporary files (but preserve the preservation directory for manual recovery if needed)
            Write-StatusMessage "Cleaning up temporary files"
            @($zip, $stagingDir) | ForEach-Object {
                if (Test-Path $_) {
                    Remove-Item -Path $_ -Recurse -Force -ErrorAction SilentlyContinue
                }
            }
            
            # Note: Backup files are retained in the versioned backup directory
            if (Test-Path $versionedBackupDir) {
                Write-StatusMessage "Backup files retained at: $versionedBackupDir" "Info"
            }
        }
    }
    else {
        Write-StatusMessage "$($OmbiCurrent.version) is the latest version - no update needed" "Success"
    }
}
catch {
    Write-StatusMessage "Script execution failed: $_" "Error"
    Write-StatusMessage "Check the error message above for details" "Error"
    exit 1
}
finally {
    Write-StatusMessage "Update process completed"
    Start-Sleep -Seconds 3
}
#endregion
