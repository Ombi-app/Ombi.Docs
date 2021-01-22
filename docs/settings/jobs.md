# Scheduled Tasks

Everything Ombi does runs as a scheduled task.  
All of these tasks are on timers using Quartz CRON expressions.  
[Cronmaker](http://www.cronmaker.com/) should be able to assist you in creating the expression or translate the current ones.  

## Job Descriptions

|**Jobs**|**Default Expression**|**CRON Definition**|**Description**|
|--------------------------|--------------------------|-------------------------------|-------------------------------|
|Sonarr Sync              | `0 10 0/1 1/1 * ? *`     | Every hour on the 10th minute |   Pulls in all of the monitored episodes, seasons and series into Ombi, so Ombi can have a quick lookup              |Pulls in all of the monitored episodes, seasons and series into Ombi, so Ombi can have a quick lookup
| SickRage Sync            | `0 35 0/1 1/1 * ? *`     | Every hour on the 35th minute |  Pulls in all of the monitored episodes, seasons and series into Ombi, so Ombi can have a quick lookup               |
| Radarr Sync              | `0 15 0/1 1/1 * ? *`     | Every hour on the 15th minute |  Pulls in all of the monitored Movies into Ombi, so Ombi can have a quick lookup               |
| Lidarr Sync              | `0 40 0/1 1/1 * ? *`     | Every hour on the 40th minute |    Pulls in all of the monitored Albums and Artists into Ombi, so Ombi can have a quick lookup             |
| CouchPotato Sync         | `0 30 0/1 1/1 * ? *`     | Every hour on the 30th minute |     Pulls in all of the monitored Movies into Ombi, so Ombi can have a quick lookup            |
| Automatic Update         | `0 0 0/6 1/1 * ? *`      | Every 6 hours                 |    Automatically updates             |
| Retry Failed Requests    | `0 0 6 1/1 * ? *`        | Every 1 day at 06:00          |     Retries any requests that failed to send to the DVR application            |
| Plex Sync                | `0 0 2 1/1 * ? *`        | Every 1 day at 02:00          |      Goes through Plex and Ombi keeps a local copy of what Plex has           |
| Plex Recently Added Sync | `0 0/30 * 1/1 * ? *` | Every 30 minutes                              |       Goes through the recently added items in Plex and Ombi keeps a local copy of what Plex has           |
| Emby Sync                | `0 5 0/1 1/1 * ? *`      | Every hour on the 5th minute  |   Goes through Emby and Ombi keeps a local copy of what Emby has              |
| User Importer            | `0 0 0 1/1 * ? *`        | Every 1 day at 00:00          |   Imports the users from Plex/Emby so they can log into Ombi              |
| Refresh Metadata         | `0 0 12 1/3 * ? *`       | Every 3 days at 12:00         |     Tries to find any missing metadata we might have for our cached data e.g. ImdbId            |
| Newsletter               | `0 0 12 ? * 6 *`         | Every 7 days at 12:00         |     Sends out the newsletter if enabled            |
| Issue Purge/Delete       | `0 0 0 1/1 * ? *`        | Every 1 day at 00:00          |   Deleted issues after the specified time setup in the Issue settings              |
| Media Data Refresh       | `0 0 12 1/5 * ? *`       | Every 5 days at 12:00         |     Deletes all the content we have previously cached with Plex/Emby and then re-caches that data            |
