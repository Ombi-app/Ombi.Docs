# Updating Ombi

## Automatic Updates

__*Note*__: The built-in automatic updater is broken for 'local' installations.  
The developer is aware of this, as is the support team. Current development is focused on a UI rewrite - once a viable cross-platform update method has been found, it will be implemented as a fix.  
Automated container updates via something like WatchTower for docker installs are unaffected - only direct installs using apt/exe deployment.  
If you have a suggestion for an update solution, feel free to either fork the project and submit a pull request, or submit a suggestion over on Discord.

### Watchtower (Docker)

There is an option in docker to use something called '[Watchtower](https://hub.docker.com/r/containrrr/watchtower)' to automatically update containers/images. If going this route we strongly suggest using a few extra arguments for both the Ombi container and the watchtower one.  
For the Ombi container, add a label to the container named `com.centurylinklabs.watchtower.enable`. Set it to `true`.  
For the Watchtower one, add a label to the container named `WATCHTOWER_LABEL_ENABLE`. Set it to `true`.

## Use Script (semi-automatic updates)

You can use your own update script here, please note that this will have to manage the termination and start of the Ombi process. You will have to terminate Ombi yourself.  

* carnivorouz - [v4 Linux systemd script](https://github.com/carnivorouz/updateOmbi)

### Script Path

The path to your script, we will automatically pass it the following arguments in the following order:

```bash
YourScript {UpdateDownloadUrl} --applicationPath {CurrentInstallLocation} --processname {ProcessName} --host {Ombi Host Argument} --storage {Ombi StoragePath Argument}
```

e.g.

```bash
Update.sh https://ci.appveyor.com/api/buildjobs/vxergo4kdyoaw929/artifacts/linux.tar.gz --applicationPath /opt/ombi --processname ombi --host http://*:5000 
```

This means the variables will be:  
{UpdateDownloadUrl}: $1  
{CurrentInstallLocation}: $3  
{ProcessName}: $5  
{Ombi Host Argument}: $7  
{Ombi StoragePath Argument}: $9  

The `{UpdateDownloadUrl}` is the Download that will contain either the .zip or .tar.gz file.  
`{Ombi Host Argument}` and `{Ombi StoragePath Argument}` are the args that you may have passed into Ombi e.g. `Ombi Host Argument` could be `http://*:5000` (They are optional)

## Manual Updates

It is possible to update Ombi manually.  
To do so is fairly straightforward.  

=== "SQLite"
    1. Stop Ombi. You can't do anything to it if the program is running.
        * If you're running Ombi as a service, stop the service.
        * If you're running Ombi manually, kill the process.
    2. Back up the database info from the Ombi directory.  
    There are 3 important db files (see what they do [here](../../info/faq/#database-uses)).  
        * Ombi.db
        * OmbiExternal.db
        * OmbiSettings.db  
    1. Delete the contents of the Ombi directory, _excluding_ the files mentioned in step 2.
    2. Download the latest `windows.zip`  from the link below:  
        [Stable](https://github.com/Ombi-app/Ombi/releases/latest)  
        [Develop](https://github.com/Ombi-app/Ombi/releases)
    3. Extract the zip to your Ombi directory.
    4. Start Ombi again.

=== "MySQL"
    1. Stop Ombi. You can't do anything to it if the program is running.
        * If you're running Ombi as a service, stop the service.
        * If you're running Ombi manually, kill the process.
    2. Back up the `database.json` file from the Ombi directory.  
    This defines how ombi connects to the MySQL server.
    1. Delete the contents of the Ombi directory, _excluding_ the files mentioned in step 2.
    2. Download the latest `windows.zip`  from the link below:  
        [Stable](https://github.com/Ombi-app/Ombi/releases/latest)  
        [Develop](https://github.com/Ombi-app/Ombi/releases)
    3. Extract the zip to your Ombi directory.
    4. Start Ombi again.

## External Script (windows)

Windows users who are running Ombi as a service can make use of a powershell script to update their Ombi instance. This script can be scheduled in task scheduler to run daily (or hourly), and it will check the current version of your Ombi instance against the latest release.  
Do not put it into the same folder as Ombi itself, as the script cleans out that folder and _will_ have issues if it deletes itself.  
This only works for develop releases, __*and is very beta*__.  
__*Do not use unless you know what you are doing with powershell*__.

You can download the script from [here.](../assets/scripts/Get-OmbiUpdate.ps1)  
If you would prefer a pre-compiled executable file that can be scheduled in task scheduler, you can download that [here.](../assets/scripts/Get-OmbiUpdate.exe)  

You will need to pass parameters to the script when calling it for it to work, and it will need to be run as an administrator.  
Parameters are:

* ApiKey  
This should be your API key for Ombi (found in your web interface). This is required.
* Ombidir  
This is the folder your copy of Ombi is running from. This is required.
* OmbiURL  
The address Ombi is listening on. This is required if you are using a non-standard port, IP, or baseurl. Defaults to `http://localhost:5000`
* UpdaterPath  
This is where the script will download to. It's only required if you don't want them put in your downloads folder, as it defaults to a folder in your downloads folder.
* ServiceName  
Most of us just use 'Ombi', so it's the default. If you used something different, pass in this parameter with whatever you used.
* Filename  
This is only for if you are using x86. If this is the case, pass in `Win10-x86.zip` as the parameter. Default is `Win10-x64.zip`.  
* Force  
This is a simple true/false switch - it will force the script to install the newest version, even if it's already installed. If the parameter isn't there, it's a `false`. The moment you add `-Force` to the end of the command you'd normally use to run this script, it'll be `true` and force a reinstall.

To pass parameters to a powershell script, you name them when calling the script as such:  
`script -parametername 'parametervalue' -parameter2name 'parameter2value`  
