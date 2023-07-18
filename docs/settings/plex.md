# Plex

## This page is a Work-In-Progress

## Enable

Do you want Ombi to communicate with your Plex Server?

## Enable User Watchlist Requests

This will enable Ombi to import requests from users watchlists.  
If a user is using a Plex account in Ombi, when they add something (either a Movie or a TV Show) to their watchlist, it will appear in Ombi just like they requested it. For this feature to work, the user needs to make sure they have logged out of and back into Ombi after version `v4.16.x`.

If the user has Request Limits, auto approve etc, all of that will be taken into account - just like the user is requesting it via the Ombi UI.

### Watchlist - Request Whole Show

If this is enabled, then Ombi will request the whole show for any show that a user adds to their Plex watchlist.  
If not enabled, it will only request the latest season.  

## Watchlist User Errors

This shows the status of watchlist sync for your users.

## Servers

This will show any server(s) you have Ombi configured to talk to, as well as allow you to manually add a server.  

### Plex Credentials

These fields are optional to automatically fill in your Plex server settings.  
This will pass your username and password to the Plex.tv API to grab the servers associated with this user.  

#### Username

The username for your account with plex.tv

#### Password

The password for your account with plex.tv  
If you have 2FA enabled on your account, you need to append the 2FA code to the end of your password.

#### Load Servers

This triggers the actual query to the Plex.tv API.  
Once it succeeds, it will fill your servers into the list to be selected from.  
Select your server from the list, edit any details as required/applicable, select the libraries you want Ombi to watch for content, the save the entry.  

### Manually Add Server

NB: _Coming Soon_

## Full Sync

This will trigger a full sync of content from the libraries configured to be watched by Ombi in your configured Plex Server(s).  

## Partial Sync

This will trigger a partial sync of content from the libraries configured to be watched by Ombi in your configured Plex Server(s).  

## Clear Data and Resync

This will clear all content from the OmbiExternal database and run a full sync.  
This is useful if you've removed content recently, or if a corrupt entry occurs.  

## Run Watchlist Import

This will trigger an import of the watchlist for all your Plex users.  
