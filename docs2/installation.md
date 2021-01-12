# Installation Instructions
<b>Note</b>: After installing the system, be sure to configure your own systems to handle the requests after approval.<br>
Any requests made without an endpoint to receive it will not be able to be re-processed at this point.<br>
Whatever combination of the supported systems you use is up to you - Sonarr, Radarr, Couchpotato, Lidarr... Whatever.<br>
<br>
For a guide on updating, see [Update Settings](https://github.com/tidusjar/Ombi/wiki/Update-Settings)<br>
For notes to consider when migrating an existing install rather than starting fresh, see [Migrating Systems](https://github.com/tidusjar/Ombi/wiki/Installation#migrating-systems)

* [**Windows**](https://github.com/tidusjar/Ombi/wiki/Installation#windows)
    * [NSSM Service](https://github.com/tidusjar/Ombi/wiki/Installation#install-as-a-service-with-nssm)
    * [Windows Task Scheduler Service](https://github.com/tidusjar/Ombi/wiki/Installation#install-as-a-service-with-windows-task-scheduler)
    * [Allowing Ombi through your firewall](https://github.com/tidusjar/Ombi/wiki/Installation#windows-firewall)
* [**Linux**](https://github.com/tidusjar/Ombi/wiki/Installation#linux-systems)
    * [Apt Repo](https://github.com/tidusjar/Ombi/wiki/Installation#apt-repo-the-easy-way-only-debian-based-distros)
    * [Manual Install (all distro's)](https://github.com/tidusjar/Ombi/wiki/Installation#linux-systems)
        * [systemd service](https://github.com/tidusjar/Ombi/wiki/Installation#run-as-systemd-service-ubuntu-1504)
        * [upstart service (ubuntu pre 15.04)](https://github.com/tidusjar/Ombi/wiki/Installation#run-as-upstart-service-ubuntu-pre-1504)
* [**MacOS**](https://github.com/tidusjar/Ombi/wiki/Installation#macos)
* [**Docker**](https://github.com/tidusjar/Ombi/wiki/Installation#docker)
* [**Helm**](https://github.com/tidusjar/Ombi/wiki/Installation#helm)

***

[Prerequisites](https://github.com/tidusjar/Ombi/wiki/Prerequisites)

**Default port is 5000**

## Recommended install workflow
1. Install Ombi for your preferred OS using the steps provided below.<br>
If you are migrating systems, rather than starting fresh, stop here and look at [Migrating Systems](https://github.com/tidusjar/Ombi/wiki/Installation#migrating-systems).
2. Configure your [install-specific settings](https://github.com/tidusjar/Ombi/wiki/Customization-Settings) like the application url you'll be using externally.
3. Configure external access to Ombi. We recommend using SSL and a [reverse proxy](https://github.com/tidusjar/Ombi/wiki/Reverse-Proxy-Examples).
4. Configure notification methods and system connections (Sonarr, Radarr, etc). <br>Ensure you have systems to handle approved requests _before_ you give users access to the system.
5. [Import users](https://github.com/tidusjar/Ombi/wiki/User-Importer-Settings) and [assign permissions](https://github.com/tidusjar/Ombi/wiki/User-Roles-Explained).

## Migrating Systems
If you're migrating Ombi from an existing install to a new install, the install process itself is exactly the same as below - with one exception, regardless of what you're migrating from or to.<br>
From your original Ombi installation you will need:
* Ombi.db
* OmbiExternal.db
* OmbiSettings.db

When it comes time to actually launch Ombi on your fresh installation, place the above files into the new Ombi directory (wherever you may have put it), and *then* launch Ombi. This way Ombi will load with all of your prior settings, customisations, users, and synced data (so it doesn't require a full re-sync with Plex).<br>
If you are running docker, place these files into the folder you've passed into the container as "/config" for the installation to find them.
***

# Windows

1. Download the latest `win10-xxx.zip` (x64 or x86 depends on your system) from https://github.com/tidusjar/ombi.releases/releases
2. Right click > Properties > Unblock
3. Extract the zip to your preferred directory. **DO NOT** place in the "Program Files" or "ProgramData" folders as the Ombi database will be locked.
4. Run Ombi.exe

### Install as a Service with NSSM
(This is the preferred method on Windows)

1. Download the latest `win10-xxx.zip` (x64 or x86 depends on your system) from https://github.com/tidusjar/ombi.releases/releases
2. Right click > Properties > Unblock
3. Extract the zip to your preferred directory. **DO NOT** place in the "Program Files" or "ProgramData" folders as the Ombi database will be locked.
4. Use [NSSM](https://nssm.cc/) to manage Ombi. Extract either the 32-/64-bit version to *C:\Windows\system32*. Open command prompt as an Administrator and type *nssm install Ombi*. Use one of the following settings depending on whether you want to keep or change the default port.

### Standard Setup
Be sure to adjust directories to your Ombi install location

**Path:** `C:\Tools\Ombi\Ombi.exe`  
**Start directory:** `C:\Tools\Ombi` 
 
![Ombi NSSM with Port](https://imgur.com/qyABZrf.jpg)  

### Standard Setup with different port number
Be sure to adjust directories to your Ombi install location

**Path:** `C:\Tools\Ombi\Ombi.exe`  
**Start directory:** `C:\Tools\Ombi`  
**Arguments:** `--host "http://*:PORTNUMBER"` 
 
![Ombi NSSM with Port](https://imgur.com/T8xEvv1.jpg)  

### Install as a Service with Windows Task Scheduler

~~Allows automatic updating on windows:~~ updater currently broken.

As an alternative to NSSM, you can use Task Scheduler to run `Ombi.exe` as if you were double clicking it and running it like a regular executable, except it's hidden from the task bar and can only be closed by the Task Manager or the Task Scheduler.

1. Open 'Task Scheduler' either search for it in start. Or simply Run... <kbd>WIN</kbd></kbd>+<kbd>R</kbd> `%windir%\system32\taskschd.msc`
2. Click `Create task...` on the right hand side.
3. Give the task a name. _Example:_ Ombi And a description if you want. (Not necessary)
4. Check `Run with highest privileges`
5. Click `Run whether user is logged on or not` to ensure Ombi runs even when you are logged out!
5. Check `Hidden`
6. Configure for: Choose your Windows version.
7. Click the `Triggers` Tab and click `New...`
8. `Begin the task:` 'At system startup`. Click `OK`
9. Click the `Actions` Tab and Click `New...`
10. Click `Browse...` and navigate to your `Ombi.exe` Click `Open`
11. Fill `Start in (optional):` with `Ombi.exe`'s working directory. IE: `C:\Ombi\` or `C:\SERVERS\Ombi\` basically, wherever you extracted your 'Ombi' folder to and where it lives. Click `OK`
12. `Settings Tab` Untick `Stop the task if it runs longer than:` Click `OK`
13. You will be prompted for your windows user name and password. Please enter your credentials and click `OK`
13. Click `Task Scheduler Library` right click on your new task and hit run. give it a good 20-30 seconds to start.  Ombi should now be reachable at http://localhost:5000 !

**_Note: The next time you restart your PC, Task Scheduler will run ombi for you._**

[How to WITH PICTURES!](https://imgur.com/a/oXEWW8z)

### Windows Firewall
To add a port forward in Windows Firewall, you have a few options.<br>
Note that this is not the preferred method of access, and a [Reverse Proxy](https://github.com/tidusjar/Ombi/wiki/Reverse-Proxy-Examples) is recommended instead.<br>
Replace the port in the below commands with your own port if you're running a different port than the default.<br>

**Command Prompt**<br>
`netsh advfirewall firewall add rule name="Ombi" dir=in action=allow protocol=TCP localport=5000`  

**Powershell**<br>
`New-NetFirewallRule -DisplayName 'Ombi' -Direction Inbound -Action Allow -Protocol TCP -LocalPort @('5000')`
***

# Linux systems

### APT repo (The easy way, only Debian-based distros)
>  * **This repo is maintained by [@louis-lau](https://github.com/louis-lau).** Go bug him on discord if you have problems specifically with the repo. Don't open an issue here.
>  * Note that as of now only systemd is supported, not upstart. That means Debian jessie and up, and Ubuntu 15.04 and up.
>  * Builds should be in the repo within 15 minutes after releasing on GitHub (stable) or AppVeyor (develop).
>  * Yes, I used a funny domain.

1. Add the apt repository to the apt sources list:
   * _If you would like stable releases, execute:_  
   ```
   echo "deb [arch=amd64,armhf,arm64] http://repo.ombi.turd.me/stable/ jessie main" | sudo tee "/etc/apt/sources.list.d/ombi.list"
   ```  
   * _If you would like development releases, execute this instead:_  
   ```
   echo "deb [arch=amd64,armhf,arm64] http://repo.ombi.turd.me/develop/ jessie main" | sudo tee "/etc/apt/sources.list.d/ombi.list"
   ```

1. This repo is signed. This means packages get validated before installation. So, to safely download and install Ombi packages, the Ombi key needs to be installed:  
   ```
   wget -qO - https://repo.ombi.turd.me/pubkey.txt | sudo apt-key add -
   ```

1. Update the package list and install Ombi:  
   ```
   sudo apt update && sudo apt install ombi
   ```

 * If no errors are shown, Ombi has been installed successfully and will automatically start during boot. 
 
   Ombi should now be reachable on http://your-ip-address:5000

 * Packages in this repo use systemd, you can use the `systemctl` or the `service` command to start, stop, or restart Ombi.

 * If an update is available for Ombi: 
   * It will get installed along with all other updates if you:
   ```
   sudo apt update && sudo apt upgrade
   ```
   * Or if you _only_ want to update Ombi:
   ```
   sudo apt update && sudo apt install ombi
   ```

 * If you want to switch branches, you can edit `/etc/apt/sources.list.d/ombi.list`. Replace `stable` with `develop`, or the other way around.

### Fedora 29 ####
Deps: `compat-openssl10 libcurl-devel libunwind-devel openssl-devel`

### Ubuntu ###

1. `mkdir /opt/Ombi`
1. cd into that directory `cd /opt/Ombi`
1. Download the latest `linux.tar.gz` @ https://github.com/tidusjar/Ombi/releases/latest for stable and use 
  https://ci.appveyor.com/project/tidusjar/requestplex/branch/develop/artifacts for develop.
1. With the newly downloaded linux.tar.gz file in /opt/Ombi run `tar xzf linux.tar.gz`
1. In the /opt/Ombi directory make the Ombi file an executable: `chmod +x Ombi`
1. Install `libicu-dev` if it isn't already installed: `sudo apt install libicu-dev`
1. Install `libunwind8` if it isn't already installed: `sudo apt install libunwind8`
1. Install `libcurl4-openssl-dev` if it isn't already installed: `sudo apt install libcurl4-openssl-dev`
1. In the `/opt/Ombi` directory run Ombi `./Ombi`
1. Verify correct Locale settings as this can prevent Ombi from talking to Plex in some LXC container installs:
``` env | grep LANG ``` should return ```LANG=en_US.UTF-8```. ``` env | grep LC_ALL``` should return ```LC_ALL=en_US.UTF-8```. 

You can also try the ```locale``` command. In some systems, setting LC_ALL is all that is necessary.
If you need to update your locale, you can do so as follows:
```
$ sudo locale-gen "en_US.UTF-8"
Generating locales...
  en_US.UTF-8... done
Generation complete.

$ sudo dpkg-reconfigure locales
Generating locales...
  en_US.UTF-8... up-to-date
Generation complete.
```
> If you decide to run Ombi as a different user, other than root, in accordance with the below warning;
> you need to chown the Ombi folder to the user you change the systemd service to.
> `sudo chown -R ombi:nogroup /opt/Ombi`

#### Run as systemd service (Ubuntu 15.04+)
> Warning: you should create your own user to run Ombi. Using root is not ideal.
> Recommended settings are:
> * User: **ombi**
> * Group: **nogroup** (built-in non-privileged group)
1. `sudo nano /etc/systemd/system/ombi.service`
1. Paste the following:
   ```
   [Unit]
   Description=Ombi - PMS Requests System
   After=network-online.target
   
   [Service]
   User=root
   Group=root
   WorkingDirectory=/opt/Ombi/
   ExecStart=/opt/Ombi/Ombi
   Type=simple
   TimeoutStopSec=30
   Restart=on-failure
   RestartSec=5
   
   [Install]
   WantedBy=multi-user.target
   ```
1. Press <kbd>Ctrl</kbd>+<kbd>x</kbd> then <kbd>y</kbd> to save (assuming you're using nano).
1. `sudo systemctl daemon-reload`
1. `sudo systemctl start ombi`
1. To enable Ombi to run on startup: `sudo systemctl enable ombi.service`
1. To ensure the service is running: `systemctl status ombi`

#### Run as upstart service (Ubuntu Pre-15.04)
> Warning: you should create your own user to run Ombi. Using root is not ideal.
> Recommended settings are:
> * User: **ombi**

1. `sudo nano /etc/init.d/ombi`
1. Paste the following:
   ```bash
   #!/bin/sh
   ### BEGIN INIT INFO
   # Provides:          ombi
   # Required-Start:    $local_fs $remote_fs $network
   # Required-Stop:     $local_fs $remote_fs $network
   # Default-Start:     2 3 4 5
   # Default-Stop:      0 1 6
   # Short-Description: Ombi
   # Description:       A personal media assitant. A simple way for shared media users to request and download content
   ### END INIT INFO
   
   . /lib/lsb/init-functions
   ################################################################################
   # Update these variables to reflect your system
   ################################################################################
   DAEMON_PWD="/opt/Ombi"
   DAEMON_USER="root"
   DAEMON_NAME="ombi"
   DAEMON_LOG="/var/log/${DAEMON_NAME}.log"
   DAEMON_PATH="${DAEMON_PWD}/Ombi"
   DAEMON_OPTS="--host http://*:5000 --storage ${DAEMON_PWD}"
   DAEMON_DESC=$(get_lsb_header_val $0 "Short-Description")
   DAEMON_PID="/var/run/${DAEMON_NAME}.pid"
   DAEMON_NICE=0
   
   [ -r "/etc/default/${DAEMON_NAME}" ] && . "/etc/default/${DAEMON_NAME}"
   
   do_start() {
     local result
   
     pidofproc -p "${DAEMON_PID}" "${DAEMON_PATH}" > /dev/null
     if [ $? -eq 0 ]; then
       log_warning_msg "${DAEMON_NAME} is already started"
       result=0
     else
       log_daemon_msg "Starting ${DAEMON_NAME}"
       touch "${DAEMON_LOG}"
       chown $DAEMON_USER "${DAEMON_LOG}"
       chmod u+rw "${DAEMON_LOG}"
       if [ -z "${DAEMON_USER}" ]; then
         start-stop-daemon --start --quiet --oknodo --background \
           --nicelevel $DAEMON_NICE \
           --chdir "${DAEMON_PWD}" \
           --pidfile "${DAEMON_PID}" --make-pidfile \
           --startas /bin/bash -- -c "exec ${DAEMON_PATH} ${DAEMON_OPTS} >> ${DAEMON_LOG} 2>&1"
         result=$?
       else
         start-stop-daemon --start --quiet --oknodo --background \
           --nicelevel $DAEMON_NICE \
           --chdir "${DAEMON_PWD}" \
           --pidfile "${DAEMON_PID}" --make-pidfile \
           --chuid "${DAEMON_USER}" \
           --startas /bin/bash -- -c "exec ${DAEMON_PATH} ${DAEMON_OPTS} >> ${DAEMON_LOG} 2>&1"
         result=$?
       fi
       log_end_msg $result
     fi
     return $result
   }
   
   do_stop() {
     local result
   
     pidofproc -p "${DAEMON_PID}" "${DAEMON_PATH}" > /dev/null
     if [ $? -ne 0 ]; then
       log_warning_msg "${DAEMON_NAME} is not started"
       result=0
     else
       log_daemon_msg "Stopping ${DAEMON_NAME}"
       killproc -p "${DAEMON_PID}" "${DAEMON_PATH}"
       result=$?
       log_end_msg $result
       rm "${DAEMON_PID}"
     fi
     return $result
   }
   
   do_restart() {
     local result
     do_stop
     result=$?
     if [ $result = 0 ]; then
       do_start
       result=$?
     fi
     return $result
   }
   
   do_status() {
     local result
     status_of_proc -p "${DAEMON_PID}" "${DAEMON_PATH}" "${DAEMON_NAME}"
     result=$?
     return $result
   }
   
   do_usage() {
     echo $"Usage: $0 {start | stop | restart | status}"
     exit 1
   }
   
   case "$1" in
   start)   do_start;   exit $? ;;
   stop)    do_stop;    exit $? ;;
   restart) do_restart; exit $? ;;
   status)  do_status;  exit $? ;;
   *)       do_usage;   exit  1 ;;
   esac
   ```
1. Press <kbd>Ctrl</kbd>+<kbd>X</kbd> then <kbd>y</kbd> to save (assuming you're using nano).
1. `sudo chmod +x /etc/init.d/ombi` (this makes the above script executable)
1. `sudo update-rc.d ombi defaults` (this tells the system when to start the service based on run-level)
1. `sudo service ombi start` (this starts the service)
1. to ensure service is running: `sudo service ombi status`

***

# macOS

1. Download the latest osx [release](https://github.com/tidusjar/ombi.releases/releases) `osx-x64.tar.gz`
1. Extract the contents to the desired location (we suggest something like /opt/Ombi/)
1. Launch Terminal
1. `cd` to the path of the folder (e.g. `cd /opt/Ombi`)
1. Execute `./Ombi`. Process should load. 
1. Ombi should now be reachable at localhost:5000

**Startup**<br>
To have Ombi run at startup, add `RunAtLoad WorkingDirectory /opt/Ombi` to the command.<br>
i.e.  `/opt/Ombi/Ombi RunAtLoad WorkingDirectory /opt/Ombi`

**_Note: macOS Catalina has strengthened Gatekeeper. <br>
As a result, allowing apps from 'unverified' sources is now a hidden option. <br>
It requires executing `sudo spctl --master-disable` in Terminal to allow apps from unverified sources before Ombi can be launched reliably.<br>
Our preferred deployment method for macOS now, as a result, has to be as a Docker container (simply to avoid this as a problem until a more secure and stable solution is discovered)._**

***

# Docker
The Ombi team do not currently maintain any Docker containers directly.<br>

However, there are a number of them available, maintained by various members of the community.<br>
linuxserver.io update their image the most up-to-date, and they have pretty comprehensive instructions for installation. See the page for their image [here](https://hub.docker.com/r/linuxserver/ombi/).<br>
We currently recommended using the tag `v4-preview` until they shift v4 to the `latest` tag.

If you are considering running Ombi in a container, and are unfamiliar with how Docker works, please see [Things to consider with Docker](https://github.com/tidusjar/Ombi/wiki/Docker-Containers) to (hopefully) help clear up some things with how networking and access works with a Docker system.

***

# Helm
The Ombi team does not currently maintain a helm chart directly.<br>

A popular helm chart is maintained by the guys over at [k8s@home](https://github.com/k8s-at-home/charts).<br>
Installation, upgrade, and removal docs are all on the [artifacthub.io page](https://artifacthub.io/packages/helm/k8s-at-home/ombi)<br>
