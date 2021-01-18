# F(requently) A(sked) Q(uestions)

If you feel like a question should be added please reach out via the Ombi Discord (link at bottom of page).  
***

## TV shows and episodes not showing as available

The most common reason for this is that we require TVDB information to match against, and your TV library in Plex probably doesn't have this metadata information.
To fix this you need to ensure your TV Library in Plex is using an agent that provides this ID. We suggest "TheTVDB".  
Edit Library > Advanced > Agent = TheTVDB

Refresh the metadata for that library, and next time the Plex Sync job runs it should pick up that the content now has TheTVDB Id's!
***

## Ombi won't start after updating to Ubuntu 19.04

.Net Core is not yet supported officially on Ubuntu 19.04 (see [Supported Distributions](https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#supported-distributions) to confirm).  
Since the Ombi backend uses .Net Core, we will have to manually install the older version of libssl (from 18.10) in order to make Ombi run.  
To confirm this is the fault, run `journalctl -u Ombi -b` and look for the line "`no usable version of libssl found`" - this will confirm that this is the fix.  
We can do this using the following commands from a terminal:

````bash
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu6_amd64.deb
sudo dpkg -i libssl1.0.0_1.0.2n-1ubuntu6_amd64.deb
````

Start the Ombi service with `service Ombi start` and confirm that it's worked with `systemctl status ombi`.
***

## Can I synchronise users between Ombi and Tautulli?

Yes, you can.  
This is a little more involved than some people are comfortable with, as it's not officially supported.  
If that doesn't worry you, and you're comfortable with running custom scripts and Python code, then you can check out the script created by DirtyCajunRice [here](scripting/ombi-tautulli.md).
***

## Notifications are not sending, but mass email works

Before any notifications will work properly you'll need to ensure you have configured your application URL under Settings -> Customization.  
This is due to Ombi needing to know where to send users if they click any links within the notifications.
***

## Notifications for requests not being received

1. Check and test if you have configured the notification(s) as per instructions in [Discord Notification Settings](https://github.com/tidusjar/Ombi/wiki/Discord-Notification-Settings) and [Email Notification Settings](https://github.com/tidusjar/Ombi/wiki/Email-Notification-Settings)
2. If testing the notification(s) work fine then make sure that the user requesting is not an auto approve or admin user

***

## Ombi does not default to English or my preferred language

Once you have set your preferred language in the user preferences area of Ombi, then it's attached to your user profile. When Ombi loads up, it checks what was set and will use that. If nothing has been set then Ombi sets whatever is the first language your browser presents to it.  
If this does not get presented properly, this is mostly an issue with Chrome.  
You can run the command `navigator.languages` in the Chrome console to see the list.  
To get Ombi to display the language you want, make that language appear as the first entry in the above command.

You can do this by:

- Open the Chrome Language Settings page  
`chrome://settings/languages`
- Click the down arrow next to Language
- Click the 3 ellipses by the language you want to set as default
- Click move to the top.

Please set Chrome to use this as display language as well.
***

## Docker Issues

If you're running all your services in containers, be mindful that sometimes NAT is a fickle mistress for those who fiddle.  
If you have services behind a reverse proxy, use the full external address for the service.  
If you have them behind Organizr as well, then use the Docker IP and port of each container instead - to avoid any routing or authentication issues that this can cause.  
If you use the host IP instead of the container IP, be sure to use the local port you mapped to the container, rather than simply the container port (these are not always the same).  
For a breakdown of docker networking (and some reasoning), see [Docker Networking](https://github.com/tidusjar/Ombi/wiki/Docker-Containers).
***

## Database uses

There are 3 databases that Ombi uses.

### Ombi.db

This database is the main ombi database.  
It contains Ombi specific information e.g. Users, Requests, Issues

### OmbiExternal.db

This database contains the information we take from external providers e.g. Plex Server Content, Radarr Content, Sonarr Content

### OmbiSettings.db

This database contains all of the settings that you have applied to Ombi e.g. Notification Preferences, SMTP Settings, Sonarr Settings, Plex Settings

***

## How can I include Ombi logs in Logarr?

Because Ombi adds the date into the name of the logfile, you can't hardcode to the latest log file - the link will be incorrect the next day.  
Instead, we can use the php date() function and string concatenation (.) to build the path on the fly when we are in Logarr.  
The logs are named in the format `log-yyyymmdd.txt` - so January 14, 2019 would be `log-20190114.txt`. php date(Ymd) gives us the date in that format, and we can concatenate it into our ombi log path in Logarr configs like so:  
_(**Note**: change folder paths to match your own install directory of Ombi.)_  

````php
"Ombi" => 'C:\Services\Ombi\Logs\log-' . date("Ymd") . '.txt',
````

_You can also use similar code for any software which hardcodes the date into the config. It's not uncommon._

***

## Can I force requests to re-add to client systems?

Some people make the mistake of letting users request content before they configure the client systems to receive the requests (Sonarr/Radarr/CouchPotato/SickRage/Lidarr etc).  
Unfortunately, with the way Ombi handles passing requests along to the systems you configure, there is no way to force the software to 're-add' the requested item to the downloader/monitoring system.  
This would cause the system to attempt to add duplicates in some cases. Your best option is to add the request to the relevant system manually. Ombi will match the two items and notify the user as it would normally moving forward.  
  
If you are able to open the Ombi.db file and execute commands on it manually (Ombi will need to be stopped for this to work), you can mark the relevant requests as "needs approval" via an SQL command. This would allow you to then click "approve" and have Ombi add the request to the relevant application and continue as normal.  

_**Note:** this is not supported officially and carries risks._  
The relevant commands are:  

```sql
UPDATE AlbumRequests
SET Approved = 0
WHERE Approved = 1 AND Available = 0;

UPDATE ChildRequests
SET Approved = 0
WHERE Approved = 1 AND Available = 0;
UPDATE EpisodeRequests
SET Approved = 0
WHERE Approved = 1 AND Available = 0;

UPDATE MovieRequests
SET Approved = 0 
WHERE Approved = 1 AND Available = 0;
```

***
