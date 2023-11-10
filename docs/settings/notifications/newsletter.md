# Newsletters

The newsletter will send out an email to each user with the `Receives Newsletter` role with a list of the movies and tv shows/episodes that have been added recently.  
The newsletter will never show duplicates, so once it's been sent out then it will only show new content in the next email.  
By default this is scheduled to run every Friday at 12GMT.

!!! warning "Newsletter links"

    For the newsletter to work correctly, ensure you have filled out the [Application URL](../../customization/#application-url)  
    This will allow the logo at the top of the newsletter to be a link back to your Ombi instance.

Please be sure you [Update Database](#update-database) before enabling newsletters.

## Enable

Exactly what it says. Enable this for the newsletter task to be scheduled.

## Disable TV

Enable this to exclude TV shows from the newsletter.

## Disable Movies

Enable this to exclude movies from the newsletter.

## Disable Music

Enable this to exclude music from the newsletter.

## Subject

Set the subject you'd like your newsletter email to use.

## Message

The message that will go above the new content in the email body.

## Submit

Save the settings as they appear.

## Test

When testing the newsletter, Ombi will grab the latest 10 movies and 10 shows that Ombi has found and send it to all users with the Admin permission.  
If the users with the Admin permission do not have email addresses associated with their account then they will (of course) not receive an email.

## Update Database

**This is very important.**  
If you do not update the database then the first run of the newsletter will go through **EVERY** movie and show/episodes in your Plex/Emby library and compose an email.  
This can be *very* time consuming if you have large libraries. We strongly recommend updating the database before enabling the newsletter.

## Trigger now

This will force the system to generate and send a newsletter outside of the regular schedule.
