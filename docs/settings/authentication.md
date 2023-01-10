# Authentication Settings

## Allow users to login without a password

This does exactly what it says on the tin.  
It will allow a user to login with their username, and only their username.
The user must still exist in Ombi.  
If the user has PowerUser or Admin permissions then they also require a password

## Enable Plex OAuth

This allows the user to login using their Plex account.  
A new popup will appear going to Plex.tv asking them to login. Once logged in they will then be able to access Ombi.

## Enable Authentication with Header Variable

This option allows the user to select a HTTP header value that contains the desired login username. 
> Note that if the header value is present and matches an existing user, default authentication is bypassed - use with caution.  

This is most commonly utilized when Ombi is behind a reverse proxy which handles authentication.
For example, if using Authentik, the `X-authentik-username` HTTP header which contains the logged in user's username is set by Authentik's proxy outpost.

### SSO creates new users automatically

By default, header authentication will fail if the user doesn't already exist.
If this option is enabled, new users will instead be created automatically.

The default roles, request limits and streaming country set in [User Management](./usermanagement.md) will be applied to the new user.
