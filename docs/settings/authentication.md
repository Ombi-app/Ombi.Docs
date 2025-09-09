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

## Things to consider

### Exclude the API from the auth method

If you are using an auth server (authentik, authelia, etc), be sure to exclude the `/api/*` path from it.  
As a user never directly accesses the API, the header will never be passed correctly, so must be excluded from the auth provider.

### Sign-in failed for new users

By default, header authentication will fail if the user doesn't already exist.  
If you enable "SSO creates new users automatically", new users will instead be created automatically when accessed via your authentication provider.

The default roles, request limits and streaming country set in [User Management](./usermanagement) will be applied to the new user.

