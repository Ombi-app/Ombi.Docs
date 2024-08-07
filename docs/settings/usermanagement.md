# Importing Users

This page is slightly dynamic depending on what Media Server you have enabled.  
Per-user settings can be applied under [User Management](/guides/usermanagement).  

## Import Plex Users

!!! note ""

    Only Plex users you have _shared_ your library with can be imported. Managed user accounts are tied to your admin account and cannot be imported separately.

This will run a scheduled job every day that will import Plex users and give them the default permissions you have setup.  
It will also look at the existing users that have been imported and update their email if it has changed.

## Import Plex Admin

This will allow the scheduled job to also import your user from Plex (as an admin).  
This will allow you to use Plex SSO as the admin as well.

## Cleanup Plex Users

This will allow the scheduled job to remove old Plex users from your Ombi instance.  
This will prevent anyone who no longer has access to your Plex from requesting content.  

## Plex Users excluded from import

This is an autocomplete field where you can type in the users username and select users that you DO NOT want to be imported if the above option is enabled.

## Default Roles

Choose the default roles that the imported users will take when the import job runs.
You can view what the different roles mean [here](/info/user-roles)

## Default Request Limit

_Note - this option behaves differently as of `v4.0.1499`._  

These are the default request limits for the users, based on the behaviour in the version in use.  
If the user reaches their request limit they will no longer be able to request. If you do not want your user to have a request limit, set it to 0.

**NOTE:** For TV Shows, 1 episode counts as 1 request

=== "New Behaviour"
    Request limits reset at the start of the day/week/month depending on the setting of that user.  
    This is set per user and request type (so for each user you can have a different setting for music/movies/TV shows if you want).  
    Coming soon:

    * Applying the setting via bulk edit in user management.
    * Setting a default for importing as.

=== "Versions older than 4.0.1499"
    Older versions of Ombi employed a 'rolling' 7 day count.  
    _This is still the default for existing installs, for backwards compatibility. New installs will use the new behaviour by default._
    When we state a rolling 7 days, this is how it works:

    * Request Limit is set to 10
    * Day 1 - Request 3 things
    * Day 6 - Request 7 things
    * Day 7 - Cannot Request
    * Day 8 - We can now request 3 more times

## Streaming Country

Defines what the default country imported users will be set as.  

## Run Importer button

Clicking this button will run the Emby/Plex user import jobs on-demand.
