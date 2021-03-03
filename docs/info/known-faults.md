# Known Faults

Any and all common bugs that we are aware of will be added here.  
Please note that as things are being found, reported, and fixed at a colossal rate, this page will frequently be outdated.  
To see all currently unfixed issues in the github repository, please see [this search.](https://github.com/Ombi-app/Ombi/issues?q=is%3Aopen+is%3Aissue+label%3A%22bug+%2F+issue%22)

## Unauthorized access to Index.html

Ombi currently needs access to write and read the Index.html file (`ClientApp/dist/index.html`), this is to work around a unsupported scenario with Angular.  
Ombi will write and read that file every time Ombi starts up.
