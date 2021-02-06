# Importing Users

 --8<-- "assets/glossary.md"

This page is slightly dynamic depending on what Media Server you have enabled.

## Import Plex/Emby Users

This will run a scheduled job every day that will import Plex/Emby users and give them the default permissions you have setup.  
It will also look at the existing users that have been imported and update any details if it has changed.

## Plex/Emby Users to exclude from import

This is an autocomplete field where you can type in the users username and select users that you DO NOT want to be imported if the above option is enabled.

## Default Roles

Choose the default roles that the imported users will take when the import job runs.
You can view what the different roles mean [Here](../info/user-roles.md)

## Default Request Limit

These are the default request limits for the users, based on a rolling 7 day count.  
If the user reaches their request limit they will no longer be able to request. If you do not want your user to have a request limit, set it to 0.

**NOTE:** For TV Shows, 1 episode counts as 1 request

When we state a rolling 7 days, this is how it works:

* Request Limit is set to 10
* Day 1 - Request 3 things
* Day 6 - Request 7 things
* Day 7 - Cannot Request
* Day 8 - We can now request 3 more times

## Run Importer button

Clicking this button will run the Emby/Plex user import jobs on-demand.
