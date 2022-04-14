# Plex

# Work in progress docs


## Enable User Watchlist Requests 

This will enable Ombi to import requests from users watchlists. If a user is using a Plex account in Ombi, when they add something either Movie or TV Show to their watchlist, it will appear in Ombi just like they imported it. For this feature to work, the user needs make sure they have logged out and back into Ombi after version `v4.16.x`.

If a TV Show is requested, it will request the *latest* season.

If the user has Request Limits, auto approve etc, all of that will be taken into account just like the user is requesting it via Ombi.
