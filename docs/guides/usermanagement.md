# User Management

This section allows you to adjust per-user settings for Ombi.  

## Alias

This is mostly for your own ease - it lets you see who is who (in reality), instead of having to remember that the user "YoMamaSoFat" is actually your brother Joe (who forgets that she's his mama too - Joe is not clever).  
Be careful though - this is used to set the `{Alias}` variable for notifications, so if you aren't careful this field _can_ be sent to the user.

## Email Address

Please note, this is mostly only relevant for a local user. If it's someone imported from Plex, editing this is likely to break their sign-in.

## Streaming Country

This is for if you have a user who is outside of your local area. It sets their availability date displays to their local area.  

## Password

Again, really only useful for local users. If they use Plex Auth, this doesn't make a difference.  
If they're a local user, then... this is to help you be able to reset a password for a user who has forgotten theirs.  

## Request Limits

This is also where you can override request limits for each user.  
These are separated out based on the type of content requested (Movie, Episode, Music).  

### Request Limit Types

These define how a users quota is calculated.  
The default for this is a weekly quota, resetting at the start of each week.
If someone should have a monthly quota of requests, while others should have monthly, setting this for their individual user is the way to achieve this.

## Quality & Root Path Preferences

This lets you set an override on the defaults for a specific user. If they have their own library (tied to a specific root folder in the arr and Plex), then you can tie their user to it here.  
Likewise, you can set a specific quality profile for a user here. Like someone a little more than the rest? Let their requests default to a higher quality. Your idiot brother Joe annoyed you recently? Set him to SD only (if you're evil).

## Roles

Each individual user can have additional roles above and beyond the defaults they're imported with.  
You can view what the different roles mean [here](/info/user-roles)

For example, if your users aren't able to request music by default, but two or three people should be allowed to - you set the default to not, under [User Management](../../settings/usermanagement), and then set their specific user to have the "Request Music" role.  
The reverse is also true - if someone abuses their ability to request things, you can revoke specific types for them in particular. Or set limits on their user.  

If one or two users have free reign on requests, everything is a 'yes' for them - set them to be auto approved.  

## Notification Preferences

These let you enable alternative notification methods for a user (provided they're enabled at the server level).  
Refer to the [notifications](/settings/notifications) section for configuration of each relevant type (and a clarification about what happens when you enable multiple options at once for a user).

## Additional Info

See also [User Management](/settings/usermanagement) for how to set the defaults that users can be imported with.
