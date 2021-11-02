# Startup Parameters

Certain parameters (or _arguments_) can be passed to the ombi application to enforce specific settings.  
The available options are the same across all platforms (Mac, Windows, Linux etc), but in some instances actually using them differs.  
This page is intended to help with some rough information on how to use them on different platforms.  

## --host

This should be a semicolon-separated (;) list of URL prefixes to which the server should respond.  
For example, `--host http://localhost:123`.  
Use "*" to indicate that the server should listen for requests on any IP address or hostname of the system it's installed on using the specified port and protocol.  
For example, `--host http://*:5000` would listen on localhost, the machine IPv4 address, and the IPv6 address.  
The protocol (http:// or https://) must be included with each URL. Supported formats vary between servers. Note that if behind a reverse proxy Ombi should use `http://` as the proxy will handle the "s" part. 
Default = "http://*:5000"

## --storage

Storage path, where we save the logs and database.  
The default for this differs slightly by OS. On Windows, this is the application directory. On Linux, this is `/opt/ombi`.  

## --baseurl

The base URL for reverse proxy scenarios. See [reverse proxying](../../info/reverse-proxy) for more info.

## --demo

Demo mode. You will _never_ need to use this, and we don't like that fruit company...

## --migrate

Will run any database migrations that have not been run on your database and then exit the application.  

## --help

Display a help screen listing these startup options.

## --version

Display version information.
