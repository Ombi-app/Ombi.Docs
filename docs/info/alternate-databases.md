# Alternate Database Options

Ombi supports multiple database types, not just SQLite.  
The way this works is that Ombi looks for a `database.json` file in the installation directory (or, if you specified a `Storage Path` at startup, in that location e.g. AppData).  
If the file is not found then Ombi falls back to the default, creating or using existing SQLite databases in the Ombi directory.

## database.json

The `database.json` file needs to look like the below example (replacing usernames, passwords, and server addresses to match your own MySQL server as needed).

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
You can see what each database is used for [here](../faq/#database-uses).

***

## Supported Databases

| Type | ConnectionString Example |
| ---- | -----------------|
| SQLite |    Data Source=C:/tmp/Ombi.db |
| MySQL  |   Server=localhost;Database=Ombi;User=root;Password=123456; |
| MariaDB  |   Server=localhost;Database=Ombi;User=root;Password=123456; |

**Note that MariaDB will need to be configured as `"Type":"MySQL"` in the `database.json` file.*

### SQLite

The default. This requires no database.json file, and checks for the relevant db files in the application directory.  
It's used for pure simplicity - it can be deployed by Ombi itself, and relies on nothing external to make it work. It's also slow when it starts expanding.  

### MySql/MariaDB

#### Why MySQL

MySQL requires more user configuration to run - so it tends to be for more advanced users. That's why SQLite is the default - Ombi can deploy it itself.  
MySQL is, however, measurably better once it's configured. It handles multiple users signing in at once, and isn't subject to the same database locks that SQLite is.  
It is also drastically more efficient at handling data - and thus is *much* faster than SQLite is. How much faster depends a lot on the hardware you're running it on and the database size, of course, but we've seen improvements anywhere from 25% up to 200% (and potentially higher, depending on the system).  
If you are experiencing slowdowns with an SQLite setup, we strongly recommend using MySQL instead.

#### Supported Versions

Supported versions:  
[https://github.com/PomeloFoundation/Pomelo.EntityFrameworkCore.MySql#supported-dbms-and-versions](https://github.com/PomeloFoundation/Pomelo.EntityFrameworkCore.MySql#supported-dbms-and-versions)  
*We currently recommend version 8.x and upwards - v5.7 is now end-of-life.*

#### Database Character Set

Please ensure that your database character set is set to `utf8mb4`.  
You can check your db charset by running the following query:  
`show variables like 'character_set_database';`  

#### Database Structure Options

You can use a separate database per function (like SQLite does, with the 3 db files), or point all of them at the same MySQL database, as each table has a unique name regardless.  
*It is up to you whether you use separate databases for each. For people unfamiliar with mysql, it is much easier to drop a database than to drop specific tables.*

=== "Single Database"

    This example shows using a single MySQL (ombi) database for all 'sub' databases (tables).  

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

=== "Multiple Databases"

    This example shows using a separate MySQL database for each 'sub' database (tables).  

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
*You need to* `GRANT ALL PRIVILEGES` *for every database you create.*

This is done in the MySQL console (or phpmyadmin if you have that configured).  

__Note: MySQL 8+ does authentication a little differently to how 5.7 used to. If Ombi fails to connect to a MySQL 8+ instance, the first thing to try is recreating the user with the `mysql_native_password` auth method attached to it (as below).__

=== "MySQL 8.x (recommended)"

    === "Single Database"

        ```mysql
        CREATE DATABASE IF NOT EXISTS `Ombi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
        CREATE USER 'ombi'@'%' IDENTIFIED WITH mysql_native_password BY 'USE_A_SECURE_PASSWORD_HERE';
        GRANT ALL PRIVILEGES ON `Ombi`.* TO 'ombi'@'%' WITH GRANT OPTION;
        ```

    === "Multiple Databases"

        ```mysql
        CREATE DATABASE IF NOT EXISTS `Ombi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
        CREATE DATABASE IF NOT EXISTS `Ombi_Settings` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
        CREATE DATABASE IF NOT EXISTS `Ombi_External` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
        CREATE USER 'ombi'@'%' IDENTIFIED WITH mysql_native_password BY 'USE_A_SECURE_PASSWORD_HERE';
        GRANT ALL PRIVILEGES ON `Ombi`.* TO 'ombi'@'%' WITH GRANT OPTION;
        GRANT ALL PRIVILEGES ON `Ombi_Settings`.* TO 'ombi'@'%' WITH GRANT OPTION;
        GRANT ALL PRIVILEGES ON `Ombi_External`.* TO 'ombi'@'%' WITH GRANT OPTION;
        ```

=== "MariaDB"

    === "Single Database"

        ```mysql
        CREATE DATABASE IF NOT EXISTS `Ombi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
        CREATE USER 'ombi'@'%' IDENTIFIED WITH mysql_native_password USING PASSWORD('USE_A_SECURE_PASSWORD_HERE');
        GRANT ALL PRIVILEGES ON `Ombi`.* TO 'ombi'@'%' WITH GRANT OPTION;
        ```
    === "Multiple Databases"

        ```mysql
        CREATE DATABASE IF NOT EXISTS `Ombi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
        CREATE DATABASE IF NOT EXISTS `Ombi_Settings` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
        CREATE DATABASE IF NOT EXISTS `Ombi_External` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
        CREATE USER 'ombi'@'%' IDENTIFIED WITH mysql_native_password USING PASSWORD('USE_A_SECURE_PASSWORD_HERE');
        GRANT ALL PRIVILEGES ON `Ombi`.* TO 'ombi'@'%' WITH GRANT OPTION;
        GRANT ALL PRIVILEGES ON `Ombi_Settings`.* TO 'ombi'@'%' WITH GRANT OPTION;
        GRANT ALL PRIVILEGES ON `Ombi_External`.* TO 'ombi'@'%' WITH GRANT OPTION;
        ```
=== "MySQL 5.7 (deprecated)"

    === "Single Database"

        ```mysql
        CREATE DATABASE IF NOT EXISTS `Ombi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
        CREATE USER 'ombi'@'%' IDENTIFIED BY 'ombi';
        GRANT ALL PRIVILEGES ON `Ombi`.* TO 'ombi'@'%' WITH GRANT OPTION;
        ```

    === "Multiple Databases"

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

*This will not migrate any existing settings.*  
You effectively have a clean ombi install.

## Installation Guides

The method for installing MySQL differs depending on your OS - guides will be added here as we write them, but the best/most up-to-date documentation for installation and configuration of MySQL will always be provided by their own website.  

[Installation on Windows](../../guides/mysql-installation-windows)

## Data Migration

You can migrate the existing SQLite databases to MySQL if you choose by following the [Migration Guide](../../guides/migrating-databases)  
