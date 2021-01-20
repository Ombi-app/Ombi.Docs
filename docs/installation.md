# Installation

__Note__: After installing the system, be sure to configure your own systems to handle the requests after approval.  
Any requests made without an endpoint to receive it will not be able to be re-processed at this point.  
Whatever combination of the supported systems you use is up to you - Sonarr, Radarr, Couchpotato, Lidarr... Whatever.  

For a guide on updating, see [Update Settings](../updating)  
For considerations when migrating an existing install rather than starting fresh, see [Migrating Systems](#migrating-systems)

***

## Recommended install workflow

1. Install Ombi for your preferred OS using the steps provided below.
If you are migrating systems, rather than starting fresh, stop here and look at [Migrating Systems](#migrating-systems).
2. Configure your [install-specific settings](../settings/customization) like the application url you'll be using externally.
3. Configure external access to Ombi. We recommend using SSL and a [reverse proxy](../info/reverse-proxy).
4. Configure notification methods and system connections (Sonarr, Radarr, etc).  
Ensure you have systems to handle approved requests _before_ you give users access to the system.
5. [Import users](../settings/import-users) and [assign permissions](../info/user-roles).

## Migrating Systems

If you're migrating Ombi from an existing install to a new install, the install process itself is exactly the same as below - with one exception, regardless of what you're migrating from or to.  
If you are using sqlite, you will need to keep the following from your original installation:

* `Ombi.db`
* `OmbiExternal.db`
* `OmbiSettings.db`

If you are using an alternate database, you will need to keep `database.json`.

When it comes time to actually launch Ombi on your fresh installation, place the above files into the new Ombi directory (wherever you may have put it), and *then* launch Ombi. This way Ombi will load with all of your prior settings, customisations, users, and synced data (so it doesn't require a full re-sync with Plex).  
If you are running docker, place these files into the folder you've passed into the container as "/config" for the installation to find them.  
***

## Windows

1. Download the latest `win10-xxx.zip` (x64 or x86 depends on your system) from [Ombi Releases](https://github.com/Ombi-app/Ombi.Releases/releases)
2. Right click the file > Properties > Unblock
3. Extract the zip to your preferred directory.  
**DO NOT** place in the "Program Files" or "ProgramData" folders as the Ombi database will be locked.
4. Run Ombi.exe

### Install as a Service with NSSM

(This is the preferred method on Windows)

1. Download the latest `win10-xxx.zip` (x64 or x86 depends on your system) from [Ombi Releases](https://github.com/Ombi-app/Ombi.Releases/releases)
2. Right click > Properties > Unblock
3. Extract the zip to your preferred directory.  
**DO NOT** place in the "Program Files" or "ProgramData" folders as the Ombi database will be locked.
4. Use [NSSM](https://nssm.cc/) to manage Ombi. Extract either the 32-/64-bit version to *C:\Windows\system32*. Open command prompt as an Administrator and type *nssm install Ombi*. Use one of the following settings depending on whether you want to keep or change the default port.

#### Standard Setup

Be sure to adjust directories to your Ombi install location

**Path:** `C:\Tools\Ombi\Ombi.exe`  
**Start directory:** `C:\Tools\Ombi`

![Ombi NSSM](./assets/images/embeds/nssm_service.png)  

#### Standard Setup with different port number

Be sure to adjust directories to your Ombi install location

**Path:** `C:\Tools\Ombi\Ombi.exe`  
**Start directory:** `C:\Tools\Ombi`  
**Arguments:** `--host "http://*:PORTNUMBER"`

![Ombi NSSM with Port](./assets/images/embeds/nssm_service_with_port.png)  

### Install as a Service with Windows Task Scheduler

~~Allows automatic updating on windows:~~ updater currently broken.

As an alternative to NSSM, you can use Task Scheduler to run `Ombi.exe` as if you were double clicking it and running it like a regular executable, except it's hidden from the task bar and can only be closed by the Task Manager or the Task Scheduler.

1. Open 'Task Scheduler' either search for it in start. Or simply Run... <kbd>WIN</kbd>+<kbd>R</kbd> `%windir%\system32\taskschd.msc`
2. Click `Create task...` on the right hand side.
3. Give the task a name. _Example:_ Ombi And a description if you want. (Not necessary)
4. Check `Run with highest privileges`
5. Click `Run whether user is logged on or not` to ensure Ombi runs even when you are logged out!
6. Check `Hidden`
7. Configure for: Choose your Windows version.
8. Click the `Triggers` Tab and click `New...`
9. `Begin the task:` 'At system startup. `Click` OK`
10. Click the `Actions` Tab and Click `New...`
11. Click `Browse...` and navigate to your `Ombi.exe` Click `Open`
12. Fill `Start in (optional):` with `Ombi.exe`'s working directory. IE: `C:\Ombi\` or `C:\SERVERS\Ombi\` basically, wherever you extracted your 'Ombi' folder to and where it lives. Click `OK`
13. `Settings Tab` Untick `Stop the task if it runs longer than:` Click `OK`
14. You will be prompted for your windows user name and password. Please enter your credentials and click `OK`
15. Click `Task Scheduler Library` right click on your new task and hit run. give it a good 20-30 seconds to start.  Ombi should now be reachable at [http://localhost:3579](http://localhost:3579) !

**_Note: The next time you restart your PC, Task Scheduler will run ombi for you._**

[How to WITH PICTURES!](https://imgur.com/a/oXEWW8z)

### Windows Firewall

To allow a port through Windows Firewall, you have a few options.
Note that this is not the preferred method of access, and a [Reverse Proxy](../info/reverse-proxy) is recommended instead.  
Replace the port in the below commands with your own port if you're running a different port than the default.  

#### Command Prompt

```cmd
netsh advfirewall firewall add rule name="Ombi" dir=in action=allow protocol=TCP localport=3579
```

#### Powershell

```powershell
New-NetFirewallRule -DisplayName 'Ombi' -Direction Inbound -Action Allow -Protocol TCP -LocalPort @('3579')
```

***

## Linux systems

### Debian / APT repo

**Note:** This is the easy way, and only works with Debian-based distros.  
Also note that only systemd is supported, not upstart. That means Debian jessie and up, and Ubuntu 15.04 and up.

1. Add the apt repository to the apt sources list:  
`echo "deb https://apt.ombi.app/develop jessie main" | sudo tee /etc/apt/sources.list.d/ombi.list`  
   _For old (v3) releases, use:_  
   `echo "deb [arch=amd64,armhf,arm64] http://repo.ombi.turd.me/stable/ jessie main" | sudo tee "/etc/apt/sources.list.d/ombi.list"`  
1. This repo is signed. This means packages get validated before installation. So, to safely download and install Ombi packages, the Ombi key needs to be installed:  
`curl -sSL https://apt.ombi.app/pub.key | sudo apt-key add -`  
   _For old (v3) releases, use:_  
   `wget -qO - https://repo.ombi.turd.me/pubkey.txt | sudo apt-key add -`  
1. Update the package list and install Ombi:  
   `sudo apt update && sudo apt install ombi`

If no errors are shown, Ombi has been installed successfully and will automatically start during boot.  
Ombi should now be reachable on "http://your-ip-address:3579"

Packages in this repo use systemd.  
Use either the `systemctl` or the `service` command to start, stop, or restart Ombi.  
If an update is available for Ombi:  

* It will get installed along with all other updates if you:
 `sudo apt update && sudo apt upgrade`
* Or if you _only_ want to update Ombi:
 `sudo apt update && sudo apt install ombi`

### Fedora 29

Deps: `compat-openssl10 libcurl-devel libunwind-devel openssl-devel`

***

## macOS

1. Download the latest osx [release](https://github.com/Ombi-app/Ombi.Releases/releases) `osx-x64.tar.gz`
2. Extract the contents to the desired location (we suggest something like /opt/Ombi/)
3. Launch Terminal
4. `cd` to the path of the folder (e.g. `cd /opt/Ombi`)
5. Execute `./Ombi`. Process should load.
6. Ombi should now be reachable at localhost:3579

**Startup**  
To have Ombi run at startup, add `RunAtLoad WorkingDirectory /opt/Ombi` to the command.  
i.e.  `/opt/Ombi/Ombi RunAtLoad WorkingDirectory /opt/Ombi`

**_Note: macOS Catalina has strengthened Gatekeeper.  
As a result, allowing apps from 'unverified' sources is now a hidden option.  
It requires executing `sudo spctl --master-disable` in Terminal to allow apps from unverified sources before Ombi can be launched reliably.  
Our preferred deployment method for macOS now, as a result, has to be as a Docker container (simply to avoid this as a problem until a more secure and stable solution is discovered)._**

***

## Docker

The Ombi team do not currently maintain any Docker containers directly.  

However, there are a number of them available, maintained by various members of the community.  
linuxserver.io keep their image the most up-to-date, and they have pretty comprehensive instructions for installation. See the page for their image [here](https://hub.docker.com/r/linuxserver/ombi/).  
We currently recommended using the tag `development` until they shift v4 to the `latest` tag.

If you are considering running Ombi in a container, and are unfamiliar with how Docker works, please see [Things to consider with Docker](../info/docker-containers) to (hopefully) help clear up some things with how networking and access works with a Docker system.

***

## Helm

The Ombi team does not currently maintain a helm chart directly.  

A popular helm chart is maintained by the guys over at [k8s@home](https://github.com/k8s-at-home/charts).  
Installation, upgrade, and removal docs are all on the [artifacthub.io page](https://artifacthub.io/packages/helm/k8s-at-home/ombi)  
