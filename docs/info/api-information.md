# API Details

As the API is an evolving entity, documenting it here becomes impossible.  
To get around this, the API documents itself, live.  
You can find the documentation on the API via the 'swagger' URL,  
`http://your.ombi.ip:5000/swagger`

This will provide you all the documentation about the available API endpoints and how to use them.

## Interacting with the API

There are two different ways to interact with the API

### JWT Bearer Authentication  

* This means you need to authenticate with a username and password and you will get a unique token that the application can use to identity that user including all roles.  
* You use this by setting an `Authorization` header with the value being `Bearer YOUR_TOKEN`.  

### API Key

* You can use the API key that is found in the Ombi settings page of the application.  
Using the API key provides admin access to the whole system, so keep this a secret.
* You can use this by setting an `ApiKey` header, with the value being the API key from the settings page
* NOTE: when using the API Key everything is assumed to be admin, and thus has no user associated with it.  
If you want it to be associated with a user you need to pass in an _additional_ header ("UserName"), with the value being the username of the user you would like to associate it with.  
If the username does not exist then the API call will fail.

If you want to use any username (including ones that do not exist in Ombi), then pass in an `ApiAlias` header and Ombi will use that.
