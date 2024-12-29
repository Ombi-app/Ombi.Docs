# Jellyfin

## This page is a Work-In-Progress

## Enable

Do you want Ombi to communicate with your JellyFin Server?

## Add Server

This is your first step.  
Press this to get presented with a list of fields you need to fill in for your Ombi and JellyFin instances to start talking to each other.

### Fields

These are the details you'll need to fill in for Ombi and JellyFin to talk to each other.

| Field | Required data |
| --- | --- |
| Server Name | This is for you to put the _name_ of your JellyFin server in.<br>It's used in notifications to say "your requested contented is now available on **ServerName**". |
| Hostname / IP | This is the IP address of your JellyFin instance. If you have it running in a container, it's usually the IP of the machine hosting the container. <br>Either way, this should be the IP you can enter in a browser to be able to open the JellyFin UI (when combined with the port).|
| Server ID | This one will auto-fill once you actually connect properly. |
| Port | This is the port you use for JellyFin access. The default for this is 8096, so if you haven't changed it try that.<br>_Note that a container can pass through a different port - if you access the web interface through a different port, use that._ |
| SSL | If you have enabled SSL _in JellyFin_, then turn this on.<br>If SSL is handled by a reverse proxy, leave it off. |
| API Key | You will need to generate an API key in JellyFin in order for Ombi to authenticate with it. This is done in JellyFin itself.<br>JellyFin Admin Dashboard -> API Keys (under Advanced) -> ++plus++|
| Base URL | This is needed if your JellyFin is configured with a BaseURL _(i.e. is accessed by http://ip:port/jellyfin/ or similar)_.<br>If you have not configured a BaseURL, leave this blank.|
| Externally Facing Hostname | This is the address you use to access JellyFin _outside_ your network.<br>If you have a reverse proxy in place, this could be something like `https://jellyfin.example.com`|


### Load Libraries

Once you've filled in all the fields, press "Load Libraries" to query the server for available libraries.  
This will allow you to tell Ombi which libraries to monitor for when requested content becomes available.  
If no libraries are selected, Ombi will monitor all of them.

### Test Connectivity

This is a useful one if you are having issues getting things running. It will tell you if it is successful in connecting.

### Discover Server Information

This will pull the Server ID from JellyFin to ensure that sync stays reliable (in case of multiple servers).  

### Submit

This saves the server information. **_DO NOT FORGET THIS PART._**

## Manually Run Cacher

This will force Ombi to ask JellyFin what media it has, to allow Ombi to say whether something is available before it gets requested.

## Clear Data And Resync

This will clear all the information about media in JellyFin from Ombi. If you've deleted media, it's recommended to run this in order to ensure that people can search for it without it showing up as still available.
