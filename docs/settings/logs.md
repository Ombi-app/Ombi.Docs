# Logs

Ombi itself doesn't really have any logging settings available from the UI.  
Log preferences are set at application startup, and configured via `appsettings.json`.

The logs themselves are generally located in the same folder as Ombi itself (which varies depending on where you have Ombi installed).  
If you need to find the logs, check the application directory first, followed by the settings directory if they aren't there (for example, if Ombi is running from `/opt/ombi`, it's possible the logs are under `/etc/ombi` or `\var\log\ombi`, depending on how the service has been deployed).

## How do I enable debug logging?

In order to enable debug logging in Ombi, you'll need to edit a file called `appsettings.json`.  
In most cases, this is in the application directory. In a docker container, this is in /app/ombi _inside the container_.  

Change the `Default` entry under `LogLevel` from "Warning" to "Debug".  
You will need to restart Ombi after changing the file for the changes to apply.  

_Do not forget to disable debug logging once you are done - it is for troubleshooting, and should not be left enabled full-time._

=== "Default Logging"
    ```json
    "Logging": {
        "IncludeScopes": false,
        "LogLevel": {
        "Default": "Warning",
        "System": "Warning",
        "Microsoft": "Warning",
        "Hangfire": "None",
        "System.Net.Http.HttpClient.health-checks": "Warning",
        "HealthChecks": "Warning"
        }
    },
    "Serilog": {
        "MinimumLevel": "Warning"
    },
    ```

=== "Debug Logging"
    ```json
    "Logging": {
        "IncludeScopes": false,
        "LogLevel": {
        "Default": "Debug",
        "System": "Debug",
        "Microsoft": "Warning",
        "Hangfire": "None",
        "System.Net.Http.HttpClient.health-checks": "Warning",
        "HealthChecks": "Warning"
        }
    },
    "Serilog": {
        "MinimumLevel": "Debug"
    },
    ```

=== "Trace Logging"
    ```json
    "Logging": {
        "IncludeScopes": false,
        "LogLevel": {
        "Default": "Trace",
        "System": "Trace",
        "Microsoft": "Trace",
        "Hangfire": "None",
        "System.Net.Http.HttpClient.health-checks": "Warning",
        "HealthChecks": "Warning"
        }
    },
    "Serilog": {
        "MinimumLevel": "Trace"
    },
    ```

