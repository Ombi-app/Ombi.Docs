# Changing Plex Password

If you are needing the change your Plex.tv password for any reason there are a few things you need to do in Ombi to re-authenticate.

Please note that the below instructions assume that you have 'Claimed' your Plex Server after changing your credentials.

1. Navigate to your Plex Settings in Ombi
1. Remove the server, don't worry all of your data is still safe.
1. Add a new server in, make sure to check the configuration to ensure it is correct e.g. Hostname or IP, Port (Not if using the Plex Credentials to fill in your server information, if you use 2FA then the 2FA code needs to be appended onto the end of your password)
1. Save

After following the above steps, Ombi will re-connect to your Plex server and start a new sync that will re-scan the media.