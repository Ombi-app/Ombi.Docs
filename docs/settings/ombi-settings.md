This page contains all the settings to configure Ombi

## Base URL
This is for Reverse Proxy setups. Put the base url you want in e.g. if the `/location` block is like the following (Nginx) `/location ombi` then put in `/ombi` as a Base Url

## Api Key
This is to use the API that Ombi provides. See [here](https://github.com/tidusjar/Ombi/wiki/Api-Information)

## Auto Delete Available Requests
This will auto delete requests which have become available, if the days is left to `0` then it will delete all requests after the job runs. If it's set to `1` then it will delete available requests after they have been available in the system for a day.