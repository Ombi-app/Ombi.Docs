| **Jobs** | **Default Expression** | **Definition** |
|---|:--:|---|
| Sonarr Sync | `0 10 0/1 1/1 * ? *` | Every hour on the 10th minute |
| SickRage Sync | `0 35 0/1 1/1 * ? *` | Every hour on the 35th minute |
| Radarr Sync | `0 15 0/1 1/1 * ? *` | Every hour on the 15th minute |
| Lidarr Sync | `0 40 0/1 1/1 * ? *` | Every hour on the 40th minute |
| CouchPotato Sync | `0 30 0/1 1/1 * ? *` | Every hour on the 30th minute |
| Automatic Update | `0 0 0/6 1/1 * ? *` | Every 6 hours from 00:00 |
| Retry Failed Requests | `0 0 6 1/1 * ? *` | Every day at 06:00 |
| Plex Sync | `0 0 2 1/1 * ? *` | Every day at 02:00 |
| Plex Recently Added Sync | `0 0/30 * 1/1 * ? *` | Every hour on the 30th minute |
| Emby Sync | `0 5 0/1 1/1 * ? *` | Every hour on the 5th minute |
| User Importer | `0 0 0 1/1 * ? *` | Every day at 00:00 |
| Refresh Metadata | `0 0 12 1/3 * ? *` | Every 3 days at 12:00 |
| Newsletter | `0 0 12 ? * 6 *` | Every 7 days at 12:00 |
| Issue Purge/Delete | `0 0 0 1/1 * ? *` | Every day at 00:00 |
| Media Data Refresh | `0 0 12 1/5 * ? *` | Every 5 days at 12:00 |

Test expressions at http://www.cronmaker.com/