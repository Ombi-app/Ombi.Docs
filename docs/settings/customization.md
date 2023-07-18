# Customization Settings

## Application Name

This will replace most references to the word `Ombi` with a new name.  
This includes in notifications and on the website (need to refresh the browser to see the change).  

## Application Url

This is for any external links Ombi sends out (this link should be the externally accessible URL) through any of the notification methods.  
e.g. Password reset email - we use the Application URL to take them to a page where they can reset their password.  
This is also used to generate the QR code for mobile app connections.  
It should look like a full web address, complete with what connection type needs to be used - `http://` or `https://`.  
If you're not using a reverse proxy, it should also include the port needed near the end (for example, `:5000`).  

### Application URL Format

=== "Reverse proxy with SSL"
    With a subdomain: `https://ombi.example.com`  
    With a baseurl: `https://site.example.com/ombi`
    This would be if you have Ombi configured behind a reverse proxy, with SSL enabled.

=== "Reverse proxy without SSL"
    With a subdomain: `http://ombi.example.com`  
    With a baseurl: `http://site.example.com/ombi`  
    This would be if you have Ombi configured behind a reverse proxy, with SSL enabled.  
    _This is not recommended._  
    _If you have a reverse proxy in play, put SSL on it with something like [Let'sEncrypt](https://letsencrypt.org/)._

=== "Naked"
    `http://ombi.example.com:5000`  
    _We REALLY do not recommend this option. While we endeavour to make the application itself as secure as possible, leaving traffic to go in and out of your network unencrypted is not a good thing to do, nor is simply punching a hole in your firewall through a forwarded port._

## Custom Logo

This is used for the Login Page, Landing Page and also any notifications that we send a logo e.g. Email Notifications.

**Format:** `http://url.to.picture/`

## Custom Favicon

This will default to the Ombi logo, but you can have your own favicon load if you wish to.  
This should point to an externally accessible URL.  

## Hide Available Content on the Discover Page

Does what it says on the tin.  
Anything that you have in your media server(s) already (that Ombi is aware of) will be hidden from the discover page.

## Custom Donation

We have the ability to set a custom donation url and message, this will be displayed to all users unlike the ombi donation message.

## Use Custom Page

This allows you to add a blank page to the Nav bar that you are able to fully customise the HTML with a WYSIWYG editor.  
Once you enable this setting, just refresh the page and you will see the new option in the navigation bar, from there you can edit your page.  

**Note:** You must add the _Edit Custom Page_ Role to your user account before you are able to edit the Custom Page.  
This can be done via the `User Management` page.  

**Disclaimer**: The _Custom Page_ is public and can be accessed without authorization, there are plans to add an authorization toggle to this page.  
Use the custom page with caution.  

## Custom CSS

There are two ways we officially support custom CSS.
They are by import or direct entry.
For some ideas, you can find some common customisations under [Common Themes](../../info/common-themes/)  
Any CSS you wish to use should be put into the Custom CSS box. It could be a reference to a CSS file (via an import reference) or could be raw CSS itself.

**Note:** For CSS import to work, it requires a MIME type of `text/css` or the browser will not load it as a stylesheet.  

## Landing/Login Page Backgrounds

We do have the ability to change what backgrounds are used on the landing and login pages.

This is not done via the Ombi UI, but done in the `appsettings.json` file in the Ombi directory [Example.](https://github.com/Ombi-app/Ombi/blob/master/src/Ombi/appsettings.json)  
If you look at that file you can see the following sections:

```json
"LandingPageBackground": {
    "Movies": [
      278,
      244786,
      680,
      155,
      13,
      1891,
      399106
    ],
    "TvShows": [
      121361,
      74205,
      81189,
      79126,
      79349,
      275274
    ]
  }
```

The numbers are TheMovieDbId's for Movies and TvDbId's for Tv Shows.  
You are able to add/remove the Id's for the sections to change the background images.  
If you do not want any TV shows or Movies then leave that section as an empty array e.g.  

```json
"LandingPageBackground": {
    "Movies": [
      278,
      244786,
      680,
      155,
      13,
      1891,
      399106
    ],
    "TvShows": []
  }
```

The above will only show movie backgrounds.
