# Generic Settings

This page contains some of the basic settings to configure Ombi.  
It is a _stub_, and only holds settings that aren't big enough for their own full pages.  

## Base URL

This is for Reverse Proxy setups. Put the base url you want in e.g. if the `/location` block is like the following (Nginx) `/location ombi` then put in `/ombi` as a Base Url

## Api Key

This is to use the API that Ombi provides. See [here](../../info/api-information)

## Auto Delete Available Requests

This will auto delete requests which have been marked available for 'x' days.  
If the days are set to `0` then it will delete all requests after the job runs. If it's set to `1` then it will delete available requests after they have been available in the system for a day.  
