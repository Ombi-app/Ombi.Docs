# Updating Ombi

## Automatic Updates

__*Note*__: The built-in automatic updater is broken for 'local' installations.  
The developer is aware of this, as is the support team. Current development is focused on a UI rewrite - once a viable cross-platform update method has been found, it will be implemented as a fix.  
Automated container updates via something like WatchTower for docker installs are unaffected - only direct installs using apt/exe deployment.  
If you have a suggestion for an update solution, feel free to either fork the project and submit a pull request, or submit a suggestion over on Discord.

## Manual updates

### Windows

It is possible to update Ombi manually.  
To do so is fairly straightforward.  

1. Stop Ombi. You can't do anything to it if the program is running.
    * If you're running Ombi as a service, stop the service.
    * If you're running Ombi manually, kill the process.
2. Back up the database info from the Ombi directory.
    * SQlite  
      There are 3 important db files (see what they do [here](../../info/faq/#database-uses)).  
        * Ombi.db
        * OmbiExternal.db
        * OmbiSettings.db  
    * MySQL  
      Keep the "database.json" file. This defines how ombi connects to the MySQL server.
3. Delete the contents of the Ombi directory, _excluding_ the files mentioned in step 2.
4. Download the latest `windows.zip`  from the link below:
[Stable](https://github.com/Ombi-app/Ombi.Releases/releases)
5. Extract the zip to your Ombi directory.
6. Start Ombi again.

### Use Script

You can use your own update script here, please note that this will have to manage the termination and start of the Ombi process. You will have to terminate Ombi yourself.  

* Unimatrix0 has written a [good systemd update script for Ombi](https://github.com/Unimatrix0/update_ombi/blob/master/update_ombi.sh).

* carnivorouz - [v4 Linux systemd script](https://github.com/carnivorouz/updateOmbi/blob/main/updateOmbi.sh)

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
{Ombi StoragePath Argument}: $8  

The `{UpdateDownloadUrl}` is the Download that will contain either the .zip or .tar.gz file.  
`{Ombi Host Argument}` and `{Ombi StoragePath Argument}` are the args that you may have passed into Ombi e.g. `Ombi Host Argument` could be `http://*:5000` (They are optional)
