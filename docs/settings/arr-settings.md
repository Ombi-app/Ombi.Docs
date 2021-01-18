# All the Arrs

Under Settings -> Movies / TV / Music, you'll find the configuration sections for each of the following:  

* Sonarr
* Radarr
* Lidarr

Each one does a different thing, but they're all based on the same codebase - so their configurations are similar.<br>
As an example address, assume we use a service behind a reverse proxy, with each service being accessible at the following addresses:<br>
Sonarr: `https://app.example.com/sonarr`<br>
Lidarr: `https://app.example.com/lidarr`<br>
Radarr: `https://app.example.com/radarr`<br>

## Enabled (tickbox)
This tells Ombi whether to use this service or not. Don't run the service? Don't enable it.<br>

## V3 (tickbox)
Currently Sonarr is in the process of migrating from V2 to V3, and is actively maintaining both versions.<br>
Radarr have already made V3 their 'release' version.<br>
If you're running the V3 release of either of these things, tick this (in the relevant page), otherwise leave it blank.<br>

## Scan for Availability (tickbox)
This option will allow Ombi to sync with the Arrs to check for availability. If you have set up your Plex (or Emby) sync to detect what is available you won't have to use this.<br>

## Do not search for Movies (tickbox)
When a movie/serie gets requested and approved, it will be added as unmonitored to the Arrs. So it will not auto download.

## Hostname
This is the address you use to connect to the service. If it's running on the same machine as Ombi, localhost usually works.<br>
If you're running the services (and Ombi itself) in docker containers, you could use the [container IP](https://github.com/tidusjar/Ombi/wiki/Docker-Containers).<br>
If the services are on multiple machines, IP addresses tend to be useful here.<br>
If, however, you use the service behind a [reverse proxy](https://github.com/tidusjar/Ombi/wiki/Reverse-Proxy-Examples), then the 'hostname' field is the bit from __before__ the 'baseurl' - in the examples above, this would be `app.example.com`.

## Port
If you're not using a reverse proxy, this is whatever port you use to access the service (it's the number after the second ":" in the address bar). In the case of Sonarr, the default is `8989`.<br>
If you're using a reverse proxy *without* SSL, the port will be `80` (protip: don't do that).<br>
If you're running with *with* SSL, the port will be `443`.<br>

## SSL (tickbox)
If you're running a reverse proxy with SSL, and are going through that address rather than the direct internal address, this needs to be ticked. Otherwise, leave it empty.

## API key
This is the API key for each relevant service.<br>
You can get this by looking under `Settings -> General` in each one.

## Base URL
If you use a reverse proxy and have a baseurl configured in any of the services, you'll need to fill this in.<br>
This tends to be the thing you put in after the hostname to access the service - in the example above for Lidarr, this field would need to have `/lidarr` added to it.

## Quality Profiles
Depending on the service, you may have this appear several times. There will be a button to 'get' these from the service. Click it, wait, and select one.<br>
If it doesn't work, "Test Connectivity". You may not be able to communicate with the service yet.

## Root Folders
Depending on the service, you may have this appear several times. There will be a button to 'get' these from the service. Click it, wait, and select one.<br>
If it doesn't work, "Test Connectivity". You may not be able to communicate with the service yet.

## Default Minimum Availability
This tells Ombi what it should add movies to Radarr as - should it wait until they're available on disc to look for them, in theatres, announced...?<br>
To try to avoid picking up fakes, `Physical/Web` is your best option.

## Language Profile
There will be a button to 'get' these from the service. Click it, wait, and select one.<br>
If it doesn't work, "Test Connectivity". You may not be able to communicate with the service yet.

## Enable Season Folders
This tells Ombi that Sonarr wants things organised into Season subfolders. Usually, this should be ticked.

## Metadata Profile
Lidarr uses these to say what it should pull in by an artist (compilations, mixtapes, albums, singles...).<br>
Again, 'get' the options from the service and select one.

## Album Folder
This tells Ombi that Lidarr wants things organised into individual subfolders per album. Usually, this should be ticked.