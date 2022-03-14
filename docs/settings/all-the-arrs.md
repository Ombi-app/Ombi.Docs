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

## Configuring Connections

There are a number of options that the *arr suites use. These are almost all required for it to work.  
They should be filled in in the following order:  

1. Enable.  
Toggle this to "on".
1. V3.  
Unless you are running a horrifically old version of Sonarr/Radarr/Lidarr, this should be enabled.
1. Hostname/IP  
The IP address or hostname your Sonarr/Radarr/Lidarr is running on.
1. Port  
Whatever port your instance is on. If you're behind an SSL proxy, this is likely `443`, and `SSL` should be enabled.
1. SSL  
Unless you have SSL enabled in your *arr, leave this off.
1. API Key  
Whatever your API key is for whichever particular *arr you're trying to configure. This varies from site to site, we don't know what your API key is.
1. Base URL  
Mostly only relevant if you've got a reverse proxy in play and have subdirectory proxies (i.e. `domain.example.com/sonarr` would have a baseurl of `sonarr`).
1. Qualities/Profiles  
You will need to hit the button to load these from your *arr, and select what quality profile you want requests from Ombi to use in the dropdowns once they've been retrieved.  
Admins get a prompt to override these when making requests, and they can have different ones set per-user if you so choose. Here is where the default selection is.
1. Folders/Root Folders  
These also need to be loaded from the relevant *arr. Hit the button, then once they've been retrieved you'll need to select them from the relevant dropdowns.  
Admins get a prompt to override these when making requests, and they can have different ones set per-user if you so choose. Here is where the default selection is.
1. Sonarr
    1. Languages
    This is mostly to account for things like Anime vs TV, but it does need setting. Load them with the button, select from the dropdown.
    1. Enable Season Folders (Sonarr)  
    This is just for Sonarr, and we recommend this being "On" for keeping files organised nicely.
1. Radarr
    1. Minimum Availability
    Defines when your Radarr should look for this particular item. Setting this correctly can help reduce the chances of fakes and bad copies.
1. Lidarr
    1. Album Folder  
    Tells Lidarr to use individual folders for albums. This helps keep folders tidy.
1. Submit  
Hit the button to save settings. If at any point one of the "Load" buttons didn't work, use the "Test Connectivity" button to see what message you get - it helps to confirm if the *arr is not responding at all, or is not authenticating (bad host/port vs bad API key).

***

## Specific Settings

Below here are details for each setting specifically. The above should get your going - the below is for troubleshooting or advanced configs.  
_Coming soon to the docs: configuring multiple instances of Radarr._

***

### Enabled

This switch tells Ombi whether to use this service or not. Don't run the service? Don't enable it.  
***

### Scan for Availability

This option tells Ombi to use the Arrs to check for availability (instead of a media server).  
If you have set up a Plex/Emby/Jellyfin connection in Ombi, then Ombi will use that to detect what is available (and this should be disabled).  
_We recommend using the media server rather than this option - it's mainly for people who use things like XBMC and local players._
***

### Hostname

This is the address you use to connect to the service. If it's running on the same machine as Ombi, localhost usually works.  
If you're running the services (and Ombi itself) in docker containers, you could use the [container IP](../../info/docker-containers).  
If the services are on multiple machines, IP addresses tend to be useful here.  
If, however, you use the service behind a [reverse proxy](../../info/reverse-proxy), then the 'hostname' field is the bit from __before__ the 'baseurl'.  
In the examples above, this would be `app.example.com`.
***

### Port

If you're not using a reverse proxy, this is whatever port you use to access the service (it's the number after the second ":" in the address bar). In the case of Sonarr, the default is `8989`.  
If you're using a reverse proxy *without* SSL, the port will be `80` _(pro-tip: don't do that)_.  
If you're running *with* SSL, the port will be `443`.  
***

### SSL

If you're running a reverse proxy with SSL, and are going through that address rather than the direct internal address, this needs to be enabled. Otherwise, leave it off.
***

### API key

This is the API key for each relevant service.  
You can get this by looking under `Settings -> General` in each one.
***

### Base URL

If you use a reverse proxy and have a baseurl configured in any of the services, you'll need to fill this in.  
This tends to be the thing you put in after the hostname to access the service - in the example above for Lidarr, this field would need to have `/lidarr` added to it.
***

### Quality Profiles

Depending on the service, you may have this appear several times.  
There will be a button to 'get' these from the service. Click it, wait, and select one.  
If it doesn't work, save the settings and "Test Connectivity". You may not be able to communicate with the service yet.
***

### Root Folders

Depending on the service, you may have this appear several times. There will be a button to 'get' these from the service. Click it, wait, and select one.  
If it doesn't work, save the settings and "Test Connectivity". You may not be able to communicate with the service yet.
***

### Submit

This button is used to save and activate your new settings.  
This will not work if you have not filled in _every_ option for the relevant service (folders, qualities, languages, seasons, albums, availability).  
***

### Sonarr / Radarr

#### Default Minimum Availability

This tells Ombi what it should add movies to Radarr as - should it wait until they're available on disc to look for them, in theatres, announced...?  
To try to avoid picking up fakes, `Physical/Web` is your best option.
***

#### Language Profile

There will be a button to 'get' these from the service. Click it, wait, and select one.  
If it doesn't work, save the settings and "Test Connectivity". You may not be able to communicate with the service yet.
***

### Lidarr Specific

#### Metadata Profile

Lidarr uses these to say what it should pull in by an artist (compilations, mixtapes, albums, singles...).  
Again, 'get' the options from the service and select one.
***

#### Album Folder

This tells Ombi that Lidarr wants things organised into individual subfolders per album. Usually, this should be ticked.
***

### Radarr Specific

#### Radarr 4K

_This option only appears when  [Movie4KRequests](../features/#movie4krequests) is turned on._  

This is where you configure a second (additional) copy of Radarr for Ombi to send requests to, with its own root paths and quality profiles.  
This is designed for people to be able to request a movie in multiple resolutions at once (usually SD or HD along with 4K), but could be set up to do SD and HD or any combination you want.  
Note that Ombi is unaware of the resolution of the item in Plex/Emby/Jellyfin - it uses the media ID for matching to see if it's available. As a result, if someone requests 4K and HD, Ombi will say the content is available _when either resolution is available, not both_.
***

### Sonarr Specific

#### Enable Season Folders

This tells Ombi that Sonarr wants things organised into Season subfolders. Usually, this should be ticked.
***

#### V3

Sonarr made V3 their "stable" branch, meaning V2 is now 'legacy'.  
This option is now the default for new sites, and should only be disabled if you are running the legacy version.  
_We do not recommend this._  
***

### Advanced

Any setting behind advanced is not recommended to be altered, _unless you know what you are doing._

### Do not search

When a movie/series/album gets requested and approved, it will be added as unmonitored to the Arrs.  
This means it will not auto download.
***
