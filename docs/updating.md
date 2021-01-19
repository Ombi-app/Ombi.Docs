# Updating Ombi

## Updater Note

__*Note*__: The built-in automatic updater is broken for 'local' installations.  
The developer is aware of this, as is the support team. Current development is focused on a UI rewrite - once a viable cross-platform update method has been found, it will be implemented as a fix.<br>
Automated container updates via something like WatchTower for docker installs are unaffected - only direct installs using apt/exe deployment.<br>
If you have a suggestion for an update solution, feel free to either fork the project and submit a pull request, or submit a suggestion over on Discord.

### Manual updates
#### Windows
It is possible to update Ombi manually.<br>
To do so is fairly straightforward. <br>

1. Stop Ombi. You can't do anything if the program is running.
    * If you're running Ombi as a service, stop the service.
    * If you're running Ombi manually, kill the process.
2. Back up the database info from the Ombi directory.<br>
* SQlite<br>
There are 3 important db files (see what they do [here](https://github.com/tidusjar/Ombi/wiki/FAQ#what-are-the-dbs-for)).<br>
    ** Ombi.db<br>
    ** OmbiExternal.db<br>
    ** OmbiSettings.db<br>
If you still have a "schedules.db" file, you can delete it. This isn't used any longer, and is no longer included in newer builds.<br>
* MySQL<br>
Keep the "database.json" file. This defines how it connects to the MySQL server.
3. Delete the contents of the Ombi directory, _excluding_ the files mentioned in step 2.
4. Download the latest `windows.zip`  from the relevant link below:<br>
[Stable](https://github.com/tidusjar/Ombi/releases/latest) | [Development](https://ci.appveyor.com/project/tidusjar/requestplex/branch/develop/artifacts)
5. Extract the zip to your Ombi directory. 
6. Start Ombi again.

### Use Script

You can use your own update script here, please note that this will have to manage the termination and start of the Ombi process. You will have to terminate Ombi yourself.<br>
* Unimatrix0 has written a [good systemd update script for Ombi](https://github.com/Unimatrix0/update_ombi/blob/master/update_ombi.sh).
* carnivorouz - [v4 Linux systemd script](https://github.com/carnivorouz/updateOmbi/blob/main/updateOmbi.sh)

### Script Path

The path to your script, we will automatically pass it the following arguments in the following order:

```
YourScript {UpdateDownloadUrl} --applicationPath {CurrentInstallLocation} --processname {ProcessName} --host {Ombi Host Argument} --storage {Ombi StoragePath Argument}
```

e.g.

```
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