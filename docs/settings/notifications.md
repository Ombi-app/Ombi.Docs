# Notification Types

There are several different methods Ombi can use to notify users about the status of their requests (approved, denied, available...).  
If you enable a notification type at the server level, it will be used to notify any user that has a value under that notification type in their user details.  
Note that this will run for _every_ type they have enabled - so if they have Discord, Pushbullet, and WhatsApp, then Ombi will attempt to use __all__ of the methods active.  
_They will be told via all of the methods they have details for._  
_This will duplicate notifications._  
_You have been warned._

Available methods include:

* [Mobile](./cloudmobile)
* [Legacy Mobile](./mobile)
* [Email](./email)
* [MassEmail](./massemail)
* [Newsletter](./newsletter)
* [Discord](./discord)
* [Slack](./slack)
* [Pushbullet](./pushbullet)
* [Pushover](./pushover)
* [Mattermost](./mattermost)
* [Telegram](./telegram)
* [Gotify](./gotify)
* [Twilio](./twilio)
* [Webhook](./webhook)
