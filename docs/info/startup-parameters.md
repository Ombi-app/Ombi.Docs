# Startup Parameters

Certain parameters (or _arguments_) can be passed to the ombi application to enforce specific settings.

## --host

This should be a semicolon-separated (;) list of URL prefixes to which the server should respond.  
For example, `--host http://localhost:123`.  
Use "*" to indicate that the server should listen for requests on any IP address or hostname using the specified port and protocol.  
For example, `--host http://*:5000`.
The protocol (http:// or https://) must be included with each URL. Supported formats vary between servers.  
Default = "http://*:3579"

## --storage

Storage path, where we save the logs and database.  
By default, this is the application directory.

## --baseurl

The base URL for reverse proxy scenarios. See [reverse proxying](../../info/reverse-proxy).
