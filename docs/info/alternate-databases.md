# Alternate Database Options

Ombi supports multiple database types, not just sqlite.  
The way this works is that Ombi looks for a `database.json` file in the installation directory (or, if you specified a `Storage Path` at startup, in that location e.g. AppData).  
If the file is not found then Ombi falls back to the default, creating or using existing SQLite databases in the Ombi directory.

## database.json

The `database.json` file needs to look like the below example (replacing usernames, passwords, and server addresses to match your own mysql server as needed).

```json
{
    "OmbiDatabase": {
        "Type":"MySQL",
        "ConnectionString":"Server=192.168.1.7;Port=3306;Database=Ombi;User=ombi;Password=ombi"
    },
    "SettingsDatabase": {
        "Type":"sqlite",
        "ConnectionString":"Data Source=C:/tmp/Settings.db"
    },
    "ExternalDatabase": {
        "Type":"sqlite",
        "ConnectionString":"Data Source=C:/tmp/External.db"
    }
}
```

As you can see you can specify a database type and a connectionstring per database that Ombi has.
You can see what each database is used for [here](../../faq/#database-uses).

***

## Supported Databases

| Type | ConnectionString Example |
| ---- | -----------------|
| SQLite |    Data Source=C:/tmp/Ombi.db |
| MySQL/MariaDB  |   Server=localhost;Database=Ombi;User=root;Password=123456; |

### SQLite

The default. This requires no database.json file, and checks for the relevant db files in the application directory.  

### MySql/MariaDB

Supported versions:  
[https://github.com/PomeloFoundation/Pomelo.EntityFrameworkCore.MySql#supported-dbms-and-versions](https://github.com/PomeloFoundation/Pomelo.EntityFrameworkCore.MySql#supported-dbms-and-versions)

Please ensure that your database character set is set to `utf8mb4`.  
You can check your db charset by running the following query:  
`show variables like 'character_set_database';`  
You can use a separate database per function (like sqlite does, with the 3 db files), or point all of them at the same mysql database, as each table has a unique name regardless.  
_It is up to you whether you use separate databases for each. For people unfamiliar with mysql, it is much easier to drop a database than to drop specific tables._

#### Single Database

This example shows using a single mysql "ombi" database for all 'sub' databases (tables).  

```json
{
  "OmbiDatabase": {
    "Type": "MySQL",
    "ConnectionString": "Server=localhost;Port=3306;Database=Ombi;User=ombi;Password=ombi"
  },
  "SettingsDatabase": {
    "Type": "MySQL",
    "ConnectionString": "Server=localhost;Port=3306;Database=Ombi;User=ombi;Password=ombi"
  },
  "ExternalDatabase": {
    "Type": "MySQL",
    "ConnectionString": "Server=localhost;Port=3306;Database=Ombi;User=ombi;Password=ombi"
  }
}
```

#### Multiple Databases

This example shows using a separate mysql database for each 'sub' database (tables).  

```json
{
  "OmbiDatabase": {
    "Type": "MySQL",
    "ConnectionString": "Server=localhost;Port=3306;Database=Ombi;User=ombi;Password=ombi"
  },
  "SettingsDatabase": {
    "Type": "MySQL",
    "ConnectionString": "Server=localhost;Port=3306;Database=Ombi_Settings;User=ombi;Password=ombi"
  },
  "ExternalDatabase": {
    "Type": "MySQL",
    "ConnectionString": "Server=localhost;Port=3306;Database=Ombi_External;User=ombi;Password=ombi"
  }
}
```

#### Create database and user

On the MySQL/MariaDB server we will create the database and the user that we will use later.  
_You need to_ `GRANT ALL PRIVILEGES` _for every database you create._

This is done in the mysql console (or phpmyadmin if you have that configured).

##### Single Database permissions

```mysql
CREATE DATABASE IF NOT EXISTS `Ombi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER 'ombi'@'%' IDENTIFIED BY 'ombi';
GRANT ALL PRIVILEGES ON `Ombi`.* TO 'ombi'@'%' WITH GRANT OPTION;
```

##### Multiple Database permissions

```mysql
CREATE DATABASE IF NOT EXISTS `Ombi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE DATABASE IF NOT EXISTS `Ombi_Settings` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE DATABASE IF NOT EXISTS `Ombi_External` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER 'ombi'@'%' IDENTIFIED BY 'ombi';
GRANT ALL PRIVILEGES ON `Ombi`.* TO 'ombi'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `Ombi_Settings`.* TO 'ombi'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `Ombi_External`.* TO 'ombi'@'%' WITH GRANT OPTION;
```

***

#### Functionality

So long as:

- `database.json` exists
- The details within it are correct
- The database(s) exist
- The user(s) exist

Restarting ombi should generate the tables and start up ombi like it would normally.

_This will not migrate any existing settings._  
You effectively have a clean ombi install.

#### Migration

You can migrate the existing sqlite databses to mysql if you choose by following the [Migration Guide](https://github.com/tidusjar/Ombi/wiki/Migration-procedure-from-SQLite-to-MySQL-or-MariaDB)
