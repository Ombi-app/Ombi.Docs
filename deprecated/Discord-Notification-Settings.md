###
**Discord Notifications:**

You must have a webhook set up for your chosen discord server or channel. [Follow this guide](https://support.discordapp.com/hc/en-us/articles/228383668-Intro-to-Webhooks)

**Setting up mentions:**
1. Set the user's 'Notification Preferences' to the person's discord user ID. This can be found by right clicking their name in Discord and selecting "Copy ID". (Option is only visible while in Developer Mode - this can be enabled under "Settings > Appearance".)

![](https://i.imgur.com/0F9QcB4.png)

2. Add `<@{UserPreference}>` where you want to mention in your notification template.

Refer to the [Notification Template Variables](https://github.com/tidusjar/Ombi/wiki/Notification-Template-Variables) for information on formatting your notifications.

Extra tip: 

You can disable posting of everyone to make it a bot only channel, and the webhook can still post.

You can @ people by using: `<@{Alias}>`. Be sure their Discord alias is known in the user profile of Ombi under Alias.