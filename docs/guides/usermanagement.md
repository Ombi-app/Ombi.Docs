# User Management (WIP)

This section allows you to adjust per-user settings for Ombi.  

## Alias

This is mostly for your own ease - it lets you see who is who (in reality), instead of having to remember that the user "YoMamaSoFat" is actually your brother Joe (who forgets that she's his mama too - Joe is not clever). Be careful though - this is able to be used in notifications, so if you aren't careful this field _can_ be sent to the user.

## Streaming Country

This is for if you have a user who is outside of your local area. It sets their availability date displays to their local area.  

## Request Limits

This is also where you can override request limits for each user.  
These are separated out based on the type of content requested (Movie, Episode, Music).  

### Request Limit Types

These define how a users quota is calculated.  
The default for this is a weekly quota, resetting at the start of each week.
If someone should have a monthly quota of requests, while others should have monthly, setting this for their individual user is the way to achieve this.

## Roles

Each individual user can have additional roles above and beyond the defaults they're imported with.  
For example, if your users aren't able to request music by default, but two or three people should be allowed to - you set the default to not, under [User Management](../../settings/usermanagement), and then set their specific user to have the "Request Music" role.  
The reverse is also true - if someone abuses their ability to request things, you can revoke specific types for them in particular. Or set limits on their user.  

See [User Management](../../settings/usermanagement)
