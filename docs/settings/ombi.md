# Generic Settings

This page contains some of the basic settings to configure Ombi.  
It is a _stub_, and only holds settings that aren't big enough for their own full pages.  

## Base URL

This is for [Reverse Proxy](../../info/reverse-proxy) setups. Put the base url you want in e.g. if the `/location` block is like the following (Nginx) `/location ombi` then put in `/ombi` as a Base Url.  
If you are running Ombi on startup (so it launches when the system boots up), see [startup parameters](../../info/startup-parameters) for how to set the `--baseurl` startup parameter on your method.  

## Api Key

This is to use the API that Ombi provides. See [here](../../info/api-information)

## Branch

This controls whether Ombi checks for Stable or Develop releases in the update checker.  
_This does not auto update Ombi - it is only for notifications._

## Do not send Notifications if a User has the Auto Approve permission

This will not send the admin any "New Request" notifications if the user making them has auto approve.

## Hide requests from other users

This will not show any existing requests to any "normal" user (non-admin or power user).

## Auto Delete Available Requests

This will auto delete requests which have been marked available for 'x' days.  
If it's set to `1` then it will delete available requests after they have been available in the system for a day.  

## Allow us to collect anonymous analytical data

This one is pretty simple - allows Ombi to give us stats regarding what browsers are being used to access it most, what platform it is deployed on etc.  
This helps us to target dev time - better support on the most used platforms makes sense.  

## Language

Self-explanatory - what language do you want as default for your instance of Ombi?  
This can be overridden per-user in their [preferences](../user-preferences), should they wish to view Ombi in their own language.  
