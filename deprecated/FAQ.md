# F(requently) A(sked) Q(uestions)! <br>
If you feel like there should be something added please feel free to edit this page.<br>
Alternatively, head on over to the `#General` channel on the Ombi Discord and suggest a question to be added.

#### Contents
* [Shows disappear during searching](https://github.com/tidusjar/Ombi/wiki/FAQ#when-searching-for-a-tv-show-it-appears-and-then-disappears-straight-away-or-doesnt-appear-at-all)
* [Ombi not marking episodes as available](https://github.com/tidusjar/Ombi/wiki/FAQ#ombi-is-not-picking-up-tv-shows-and-episodes-as-available)
* [No compatible libssl (Ubuntu 19.04 error)](https://github.com/tidusjar/Ombi/wiki/FAQ#i-updated-to-ubuntu-1904-and-now-ombi-wont-start)
* [Sync Ombi & Tautulli Users](https://github.com/tidusjar/Ombi/wiki/FAQ#how-can-i-synchronise-users-between-ombi-and-tautulli)
* [Mass email works, notifications don't](https://github.com/tidusjar/Ombi/wiki/FAQ#notifications-are-not-sending-but-mass-email-works)
* [Link Ombi to Plex Cloud](https://github.com/tidusjar/Ombi/wiki/FAQ#how-to-configure-ombi-to-talk-to-plex-cloud)
* [Request notifications not being received](https://github.com/tidusjar/Ombi/wiki/FAQ#notifications-for-requests-not-being-received)
* [Language is not defaulting properly in Chrome](https://github.com/tidusjar/Ombi/wiki/FAQ#ombi-does-not-default-to-english-or-my-preferred-language)
* [Ombi and Docker Services ](https://github.com/tidusjar/Ombi/wiki/FAQ#docker-issues)
* [Ombi Databases](https://github.com/tidusjar/Ombi/wiki/FAQ#what-are-the-dbs-for)
* [Adding Ombi to Logarr](https://github.com/tidusjar/Ombi/wiki/FAQ#how-can-i-include-ombi-logs-in-logarr)
* [Set all requests to 'unapproved'](https://github.com/tidusjar/Ombi/wiki/FAQ#can-i-force-requests-to-re-add-to-client-systems)
* [Updating doesn't work!](https://github.com/tidusjar/Ombi/wiki/Update-Settings#updater-note)
***
### When searching for a TV Show, it appears and then disappears straight away! Or doesn't appear at all!

This is due to our TV Provider TV Maze not having the metadata we need to process that TV Show. We require TV Maze to supply us with a TVDBId for that show.
You can easily check this by calling the TV Maze API: http://api.tvmaze.com/search/shows?q=Dexter

You can see under the `externals` object there should be a `theTvDb` property. If that is `null` then Ombi cannot process that show.

You can request the `theTvDb` id to be added [here](https://www.tvmaze.com/threads/2677/edit-requests)

***
### Ombi is not picking up TV shows and episodes as available
So the main reason for this is that we require TVDB information and your TV library in Plex probably doesn't have this metadata information.
To fix this you need to Edit your Library > Advanced > Agent = TheTVDB

Refresh the metadata for that library and then once the Plex Sync job runs it should then pick up that the content now has TheTVDB Id's!

***
### I updated to Ubuntu 19.04 and now Ombi won't start!
.Net Core is not yet supported officially on Ubuntu 19.04<br>
Since the Ombi backend uses .Net Core, we will have to manually install the older version of libssl (from 18.10) in order to make Ombi run.<br>
To confirm this is the fault, run `journalctl -u Ombi -b` and look for the line "`no usable version of libssl found`" - this will confirm that this is the fix.<br>
We can do this using the following commands from a terminal:
````bash
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu6_amd64.deb
sudo dpkg -i libssl1.0.0_1.0.2n-1ubuntu6_amd64.deb
````
Start the Ombi service with `service Ombi start` and confirm that it's worked with `systemctl status ombi`.
***
### How can I synchronise users between Ombi and Tautulli?
This is a little more involved than some people are comfortable with, as it's not officially supported.<br>
If that doesn't worry you, and you're comfortable with running custom scripts and Python code, then you can check out the script created by DirtyCajunRice [here](https://github.com/tidusjar/Ombi/wiki/Ombi-&-Tautulli).
***
### Notifications are not sending, but mass email works
Before any notifications will work properly you'll need to ensure you have configured your application URL under Settings -> Customization. This is due to Ombi needing to know where to send users if they click the links held in notifications.

***
### How to configure Ombi to talk to Plex Cloud:
1. Go to https://plex.tv/users/cpms and at the bottom is your plex url. It will be https://something.ric.plex.services
2. Copy that URL entirely, including the https:// into the Ombi Plex Hostname or IP field
3. Change the port to 443
4. Select the SSL checkbox
5. Select Test Connectivity

***
### Notifications for requests not being received
1. Check and test if you have configured the notification(s) as per instructions in [[Discord Notification Settings |https://github.com/tidusjar/Ombi/wiki/Discord-Notification-Settings]] and [[Email Notification Settings|https://github.com/tidusjar/Ombi/wiki/Email-Notification-Settings]]
2. If testing the notification(s) work fine then make sure that the user requesting is not an auto approve or admin user

***
### Ombi does not default to English or my preferred language
This is mostly an issue with Chrome.
Ombi sets whatever is the first language your browser presents, you can run the command `navigator.languages` in the Chrome console to see the list.

To get Ombi to display the language you want, make that language appear as the first entry in the above command.

You can do this by going to the language settings in Chrome `(chrome://settings/languages)` > click the down arrow next to Language > click the 3 ellipsis by the language you want to set as default > click move to the top. Please set Chrome to use this as display language as well. 

***
### Docker Issues
If you're running all your services in containers, be mindful that sometimes NAT is a fickle mistress for those who fiddle.<br>
If you have services behind a reverse proxy, use the full external address for the service. <br>
If you have them behind Organizr as well, then use the Docker IP and port of each container instead - to avoid any routing or authentication issues that this can cause.<br>
If you use the host IP instead of the container IP, be sure to use the local port you mapped to the container, rather than simply the container port (these are not always the same).<br>
For a breakdown of docker networking (and some reasoning), see [Docker Networking](https://github.com/tidusjar/Ombi/wiki/Docker-Containers).
***
### What are the DB's for?
There are 3 databases that Ombi uses.

#### Ombi.db
This database is the main ombi database, it contains Ombi specific information e.g. Users, Requests, Issues

#### OmbiExternal.db
This database contains the information we take from external providers e.g. Plex Server Content, Radarr Content, Sonarr Content

#### OmbiSettings.db
This database contains all of the settings that you have applied to Ombi e.g. Notification Preferences, SMTP Settings, Sonarr Settings, Plex Settings

***
### How can I include Ombi logs in Logarr?
Because Ombi adds the date into the name of the logfile, you can't hardcode to the latest log file - the link will be incorrect the next day.<br>
Instead, we can use the php date() function and string concatenation (.) to build the path on the fly when we are in Logarr.<br>
The logs are named in the format `log-yyyymmdd.txt` - so January 14, 2019 would be `log-20190114.txt`. php date(Ymd) gives us the date in that format, and we can concatenate it into our ombi log path in Logarr configs like so: <br>
_(**Note**: change folder paths to match your own install directory of Ombi.)_<br>
````php
"Ombi" => 'C:\Services\Ombi\Logs\log-' . date("Ymd") . '.txt',
````
_You can also use similar code for any software which hardcodes the date into the config. It's not uncommon._

***
### Can I force requests to re-add to client systems?
Some people make the mistake of letting users request content before they configure the client systems to receive the requests (Sonarr/Radarr/CouchPotato/SickRage/Lidarr etc).<br>
Unfortunately, with the way Ombi handles passing requests along to the systems you configure, there is no way to force the software to 're-add' the requested item to the downloader/monitoring system.<br>
This would cause the system to attempt to add duplicates in some cases. Your best option is to add the request to the relevant system manually. Ombi will match the two items and notify the user as it would normally moving forward.<br><br>
If you are able to open the Ombi.db file and execute commands on it manually (Ombi will need to be stopped for this to work), you can mark the relevant requests as "needs approval" via an SQL command. This would allow you to then click "approve" and have Ombi add the request to the relevant application and continue as normal.<br>
_**Note:** this is not supported officially and carries risks._<br>
The relevant commands are:<br>
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