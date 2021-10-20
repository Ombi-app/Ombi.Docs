# Known Faults

Any and all common bugs that we are aware of will be added here.  
Please note that as things are being found, reported, and fixed at a colossal rate, this page will frequently be outdated.  
To see all currently unfixed issues in the github repository, please see [this search.](https://github.com/Ombi-app/Ombi/issues?q=is%3Aopen+is%3Aissue+label%3A%22bug+%2F+issue%22)
***

## Error updating from Web UI

See [Update Errors](../../guides/updating/#automatic-updates)
***

## Repo Errors

Using the v4 repo, I get "missing release file".  

We are currently migrating the repositories. Bear with us, it will be resolved soon.  
***

## Error "apt-key is Deprecated"

Ubuntu 21.xx and onwards has moved to a new method of signing repositories, where keys are trusted per repository instead of per key.  
Unfortunately, this will require further testing of our key deployment method to identify a solution.  
***

## Cannot start Ombi on Ubuntu 19.04

.Net Core 5.0 is not supported officially on Ubuntu 19.04 (see [Supported Distributions](https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#supported-distributions) to confirm).  
Since the Ombi backend uses .Net Core, we will have to manually install the older version of libssl (from 18.10) in order to make Ombi run.  
To confirm this is the fault, run `journalctl -u Ombi -b` and look for the line "`no usable version of libssl found`" - this will confirm that this is the fix.  
We can do this using the following commands from a terminal:

````bash
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu6_amd64.deb
sudo dpkg -i libssl1.0.0_1.0.2n-1ubuntu6_amd64.deb
````

Start the Ombi service with `service Ombi start` and confirm that it's worked with `systemctl status ombi`.
***

## Mobile Notifications & PiHole

Numerous PiHole and AdGuard lists block OneSignal by default, causing Ombi to be unable to push a notification to it and your mobile device to be unable to retrieve one from it.  
The error will be similar to:  
`There was an error when sending the Mobile message. Please check your settings`.

Check your PiHole/Adguard immediately after hitting the "Test Notification" button.  
If you see "onesignal.com" being blocked, whitelist it and try again.
***

## libunwind8 error

> libunwind.so.8: cannot open shared object file You may need to install libwind8.  

Run `apt install libunwind8`

***

## System.Net.Http.CurlHandler

> System.TypeInitializationException: The type initializer for 'System.Net.Http.CurlHandler' threw an exception.

Run `apt install libcurl4-openssl-dev`

***
