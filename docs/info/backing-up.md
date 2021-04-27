# Backing Up Ombi

## Stop Ombi

Stop Ombi with the relevant command for your system (stop-process ombi, net stop ombi, service ombi stop, docker stop ombi...), and...

## Back up the databases

=== "SQLite"
Back up the sqlite db files.

- ombi.db
- ombisettings.db
- ombiexternal.db

=== "MySQL"
Back up database.json.  
Export your mysql databases.
