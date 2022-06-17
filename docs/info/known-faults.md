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

We are currently migrating the repositories. Bear with us, it will be resolved soon™.  
***

## Error "apt-key is Deprecated"

Ubuntu 21.xx and onwards has moved to a new method of signing repositories, where keys are trusted per repository instead of per key.  
Apt-Key still works, but an updated method for 21.xx has been added to the installation page. You may have to remove the old apt repository in order to update to the new method moving forward.  
***

## Unauthorized access to Index.html

Ombi currently needs access to write and read the Index.html file (`ClientApp/dist/index.html`), this is to work around a unsupported scenario with Angular.  
Ombi will write and read that file every time Ombi starts up.
***

## System.Net.Http.CurlHandler

> System.TypeInitializationException: The type initializer for 'System.Net.Http.CurlHandler' threw an exception.

Run `apt install libcurl4-openssl-dev`

***

