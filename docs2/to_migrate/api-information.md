You can find the documentation on the API via swagger, http://localhost:5000/swagger

This will provide you all the documentation about the available API's and how to use it.

There are two different ways to interact with the API

* Using JWT Bearer authentication
    * This means you need to authenticate with a username and password and you will get a unique token that the application can use to identity that user including all roles.
    * You use this by setting an `Authorization` header with the value being `Bearer YOUR_TOKEN`.
* Using the API Key
    * You can use the API key that is found in the Ombi settings page of the application. Using the API key provides admin access to the whole system, so keep this a secret.
    * You can use this by setting an `ApiKey` header with the value being the API key from the settings page
    * NOTE when using the API Key then everything is assumed as admin and there is no user associated with it, If you want it to be associated with a user you need to pass an additional header "UserName" with the value being the username of the user. If the username does not exist then the API call will not work.


If you want to use any username (User does not have to exist on Ombi) then pass in a `ApiAlias` header and Ombi will use that.