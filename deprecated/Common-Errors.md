### Error updating from Web UI
See [Update Errors](https://github.com/tidusjar/Ombi/wiki/Update-Settings#updater-note)

***
### When searching for a TV Show, it appears and then disappears straight away! Or doesn't appear at all!

This is due to our TV Provider [TVMaze](https://www.tvmaze.com/) not having the metadata we need to process that TV Show. We require TV Maze to supply us with a TVDBId for that show.
You can easily check this by calling the TV Maze API: http://api.tvmaze.com/search/shows?q=Dexter

You can see under the `externals` object there should be a `theTvDb` property. If that is `null` then Ombi cannot process that show.

You can request the `theTvDb` id to be added [here](https://www.tvmaze.com/threads/2677/edit-requests)

***
If you search for a TV show and get this error:

![sorry](https://i.imgur.com/v4NbRjL.jpg)

_This most commonly is caused by incorrect spelling._ 😃

This could also be caused by there not being enough metadata available such as `thetvdbid` and/or episiode information.

These are two checks that Ombi looks for to verify that a show exists and is available to be requested.

Most of the time, you can freely edit the listings on [TVMAZE](https://www.tvmaze.com/) and the [theTVDB](https://www.thetvdb.com/) to have the information needed to make an item available.

If you have edited the TVMAZE and/or theTVDB listings for a show, there is a time delay before the api's have the new information.  Give it a few hours before searching again.
***
### libunwind8 error
> libunwind.so.8: cannot open shared object file You may need to install libwind8.   

Run `apt install libunwind8`

***

### System.Net.Http.CurlHandler
> System.TypeInitializationException: The type initializer for 'System.Net.Http.CurlHandler' threw an exception.

Run `apt install libcurl4-openssl-dev`


***

### Proxmox LXC Containers
`set LC_ALL=en_US.UTF-8`

or

`sudo locale-gen "en_US.UTF-8"`

or 

`sudo dpkg-reconfigure locales`

 and reboot

[#1783](https://github.com/tidusjar/Ombi/issues/1783)

Taken from https://github.com/tidusjar/Ombi/issues/1783#issuecomment-351498238

***

### N: Skipping acquire of configured file 'main/binary-i386/Packages' as repository 'http://repo.ombi.turd.me/develop jessie InRelease' doesn't support architecture 'i386'

`sudo nano /etc/apt/sources.list.d/ombi.list`

`change: deb http://repo.ombi.turd.me/stable/ jessie main`

`to: deb [arch=amd64] http://repo.ombi.turd.me/stable/ jessie main`

***
### Mobile Notifications Not Working (PiHole/Adguard Users Mostly)

When testing mobile notifications you get an error similar to 

`There was an error when sending the Mobile message. Please check your settings`.

Ombi uses OneSignal to send notifications but OneSignal's domain is part of some of the PiHole/Adguard blocklists. 

Check your PiHole/Adguard immediately after hitting the "Test Notification" button and if you see "onesignal.com" being blocked, whitelist it and try again.

***
### No search Movies, SQLite Error 1: 'no such column: x.RequestId'
Source [this](https://github.com/tidusjar/Ombi/issues/3214), author Sibicle

#### Docker

Here is a oneliner to fix the issue, assuming you are running in a docker container, your container has `ombi` in the name, your image requires the config dir to be mounted at `/config`, and the host is running Debian, Ubuntu, or a related distro that uses `apt`. If any of these points aren't true, see the details below the command and modify to your needs.

```shell
sudo apt update; \
sudo apt install -y sqlite3; \
sqlite3 $( \
  docker inspect --format '{{ range .Mounts }}{{if eq .Destination "/config"}}{{ .Source }}{{end}}{{end}}'  \
  $(docker ps --filter name=ombi --format '{{.ID}}') \
)/app/OmbiExternal.db 'ALTER TABLE PlexServerContent ADD COLUMN RequestId INTEGER NULL'
```

Explanation of parts:

Update `apt` & install `sqlite3`

```shell
sudo apt update; \
sudo apt install -y sqlite3;
```

Inspect container `$CONTAINER_ID`, list mounts, and if the mount destination is `/config`, print the source

```shell
docker inspect --format \
  '{{ range .Mounts }}{{if eq .Destination "/config"}}{{ .Source }}{{end}}{{end}}'  \
  $CONTAINER_ID
```

List containers, filtering on `ombi`. Format output to only include the container id.

```shell
docker ps --filter name=ombi --format '{{.ID}}'
```

Concatenate the inspected directory path with the path to the `.db` file within the `/config` dir

```shell
$( ... )/app/OmbiExternal.db
```

Tell `sqlite3` to run the actual query

```shell
 sqlite3 /opt/ombi/app/OmbiExternal.db 'ALTER TABLE PlexServerContent ADD COLUMN RequestId INTEGER NULL'
```

After you are done, you can remove `sqlite3`

```shell
sudo apt remove --purge sqlite3
```

#### Unraid
RUN:
```shell
cd ~
wget https://www.sqlite.org/2019/sqlite-tools-linux-x86-3300100.zip
unzip sqlite-tools-linux-x86-3300100.zip
cd sqlite-tools-linux-x86-3300100
chmod a+x sqlite3
./sqlite3 $(find / -name OmbiExternal.db -print0 -quit 2>/dev/null) 'ALTER TABLE PlexServerContent ADD COLUMN RequestId INTEGER NULL'
```

#### Debian/Ubuntu
If "sqlite3" is not installed:
```shell
$ sudo apt update
$ sudo apt install -y sqlite3
```

Fix Database:
- Replace "**/app**" with the location of the databases of our Ombi installation.
> If we have installed ombi with apt-get the location will be "**/etc/Ombi**".
```shell
$ sqlite3 /app/OmbiExternal.db 'ALTER TABLE PlexServerContent ADD COLUMN RequestId INTEGER NULL'
```

If we want to uninstall "sqlite3" to clean the system.
```shell
$ sudo apt remove --purge sqlite3
```