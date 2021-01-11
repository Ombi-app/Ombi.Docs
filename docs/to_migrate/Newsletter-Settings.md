The newsletter will send out an email to all users with the `Recieves Newsletter` permission with a list of the movies and tv shows/episodes that have been added recently. The newsletter will never show duplicates, so once it's been sent out then it will only show new content in the next email. By default this is scheduled to run every Friday at 12GMT.


## Update Database (PLEASE READ)
This is very important. If you do not update the database then the first run of the newsletter will go through **EVERY** movie and show/episodes in your Plex/Emby library and compose an email. This can be **very** time consuming if you have large libraries. I would always recommend updating the database before enabling the newsletter.


## Test
When testing the newsletter, it will grab the latest 10 movies and 10 shows that Ombi has found and send it to all users with the Admin permission. So if the users with the Admin permission do not have email addresses associated with their account then they will not recieve the email.
