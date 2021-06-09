# All the Arrs

Under Settings -> Movies / TV / Music, you'll find the configuration sections for each of the following:  

* Sonarr
* Radarr
* Lidarr

Each one does a different thing, but they're all based on the same codebase - so their configurations are similar.  
As an example address, assume we use a service behind a reverse proxy, with each service being accessible at the following addresses:  
Sonarr: `https://app.example.com/sonarr`  
Lidarr: `https://app.example.com/lidarr`  
Radarr: `https://app.example.com/radarr`  
***

## Enabled

This switch tells Ombi whether to use this service or not. Don't run the service? Don't enable it.  
***

## Scan for Availability

This option will allow Ombi to sync with the Arrs to check for availability.  
If you have set up your Plex (or Emby) sync to detect what is available you won't have to use this.  
***

## Hostname

This is the address you use to connect to the service. If it's running on the same machine as Ombi, localhost usually works.  
If you're running the services (and Ombi itself) in docker containers, you could use the [container IP](../../info/docker-containers).  
If the services are on multiple machines, IP addresses tend to be useful here.  
If, however, you use the service behind a [reverse proxy](../../info/reverse-proxy), then the 'hostname' field is the bit from __before__ the 'baseurl'.  
In the examples above, this would be `app.example.com`.
***

## Port

If you're not using a reverse proxy, this is whatever port you use to access the service (it's the number after the second ":" in the address bar). In the case of Sonarr, the default is `8989`.  
If you're using a reverse proxy *without* SSL, the port will be `80` _(pro-tip: don't do that)_.  
If you're running *with* SSL, the port will be `443`.  
***

## SSL

If you're running a reverse proxy with SSL, and are going through that address rather than the direct internal address, this needs to be enabled. Otherwise, leave it off.
***

## API key

This is the API key for each relevant service.  
You can get this by looking under `Settings -> General` in each one.
***

## Base URL

If you use a reverse proxy and have a baseurl configured in any of the services, you'll need to fill this in.  
This tends to be the thing you put in after the hostname to access the service - in the example above for Lidarr, this field would need to have `/lidarr` added to it.
***

## Quality Profiles

Depending on the service, you may have this appear several times.  
There will be a button to 'get' these from the service. Click it, wait, and select one.  
If it doesn't work, save the settings and "Test Connectivity". You may not be able to communicate with the service yet.
***

## Root Folders

Depending on the service, you may have this appear several times. There will be a button to 'get' these from the service. Click it, wait, and select one.  
If it doesn't work, save the settings and "Test Connectivity". You may not be able to communicate with the service yet.
***

## Submit

This button is used to save and activate your new settings.  
This will not work if you have not filled in _every_ option for the relevant service (folders, qualities, languages, seasons, albums, availability).  
***

## Sonarr / Radarr

### Default Minimum Availability

This tells Ombi what it should add movies to Radarr as - should it wait until they're available on disc to look for them, in theatres, announced...?  
To try to avoid picking up fakes, `Physical/Web` is your best option.
***

### Language Profile

There will be a button to 'get' these from the service. Click it, wait, and select one.  
If it doesn't work, save the settings and "Test Connectivity". You may not be able to communicate with the service yet.
***

## Lidarr Specific

### Metadata Profile

Lidarr uses these to say what it should pull in by an artist (compilations, mixtapes, albums, singles...).  
Again, 'get' the options from the service and select one.
***

### Album Folder

This tells Ombi that Lidarr wants things organised into individual subfolders per album. Usually, this should be ticked.
***

## Sonarr Specific

### Enable Season Folders

This tells Ombi that Sonarr wants things organised into Season subfolders. Usually, this should be ticked.
***

### V3

Sonarr made V3 their "stable" branch, meaning V2 is now 'legacy'.  
This option is now the default for new sites, and should only be disabled if you are running the legacy version.  
_We do not recommend this._  
***

## Advanced

Any setting behind advanced is not recommended to be altered, _unless you know what you are doing._

## Do not search

When a movie/series/album gets requested and approved, it will be added as unmonitored to the Arrs.  
This means it will not auto download.
***
