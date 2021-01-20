For installing MySQL we need to install the MySQL Community Server. You can download it [here](https://dev.mysql.com/downloads/mysql/). <br>

***

### Download
Hit the "Go to Download Page" button and click on the **bottom** "Download" button. This is the offline installer, the top one is the web installer. After clicking you will be represented with a new page asking you to login or sign up. Do whatever you like but make sure you've also seen the "No thanks, just start my download." on the bottom left. <br>

***

### Install and Configure
When the download is complete, run the installer and follow the steps below:
#### Choosing a Setup Type
Make sure Custom is selected and click Next.<br>
![](https://i.imgur.com/FP5SV7F.png)

#### Select Products and Features
Select the following products to install:<br>
* MySQL Server
* MySQL Workbench 
<br>
Click on next to continue.<br>

![](https://i.imgur.com/vdLQR1g.png)

#### Installation
It could give you a message that some requirements are missing. This is fine since it will install those requirements. Click Execute. When the installation is finished, click on next.<br>
![](https://i.imgur.com/SjXq1yk.png)

#### Product Configuration
Click Next. <br>
![](https://i.imgur.com/0rPtjG3.png)

#### High Availability
Make sure the Standalone MySQL Server is selected and click Next.<br>
![](https://i.imgur.com/QwMpTk2.png)

#### Type and Networking
You now see the default settings. **Nothing needs to be changed** but you can change the Port if needed. Make sure that you don't forget the port number in the database.json when you are going to migrate!<br>
Click Next.<br>
![](https://i.imgur.com/5A7ZXB3.png)

#### Authentication Method
We need to change the default setting to "Use Legacy Authentication Method". Since this is a security risk I would advise to close the port (3306 default) in your modem. <br>
![](https://i.imgur.com/saJwwBd.png)

#### Account and Roles
We need to set a root password which allows us to connect to MySQL Server. This password is important because we need it for creating databases and perhaps do maintenance on it. So make sure you don't forget the password! We don't need to create users here because we will do it once we have created the database in a further step.
![](https://i.imgur.com/fC6R32c.png)

#### Windows Service
You can keep the default settings here and click on Next.<br>
![](https://i.imgur.com/pznYnIN.png)

#### Apply Configuration
Now it is time to actually apply all the configuration we just set. Hit Execute. Once it is done, hit Finish.<br>
![](https://i.imgur.com/MbLzElI.png)

#### Apply Configuration 2
For now we are done. Hit Finish and confirm you want to finish.<br>
![](https://i.imgur.com/jmrUcAO.png)

***

### Create the database and database user.
We have set up the MySQL server and now it is time to create the Ombi Database and Ombi Database User. We will do this with the MySQL Workbench 8.0 CE. Hit start and type MySQL Workbench. Run the application.

![](https://i.imgur.com/N6QSYVI.png)

Click on the grey block which is named: Local Instance MySQL80. It will pop-up a box to enter your Root password which you set in the installation of MySQL Server. Once you have entered the root password it will ask if you wanna store your password in the vault. I would recommend to do so, so you don't need to enter your root password again when you connect.

![](https://i.imgur.com/b4nIj4q.png)

You can now see the workbench which is displaying your MySQL server. It is now time to run some code!
Enter the following code in the Query 1 text section:

```mysql
CREATE DATABASE IF NOT EXISTS `Ombi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE DATABASE IF NOT EXISTS `Ombi_Settings` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE DATABASE IF NOT EXISTS `Ombi_External` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER 'ombi'@'%' IDENTIFIED BY 'ombi';
GRANT ALL PRIVILEGES ON `Ombi`.* TO 'ombi'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `Ombi_Settings`.* TO 'ombi'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `Ombi_External`.* TO 'ombi'@'%' WITH GRANT OPTION;
```
Now we need to run that code! Click on the Lightning Bolt above the code.

![](https://i.imgur.com/i8Hg3s0.png)

We have created 3 Databases: Ombi, OmbiSettings and OmbiExternal.
We have created 1 user: Ombi.
We have given the user Ombi all privileges on 3 databases: Ombi, OmbiSettings and OmbiExternal.

Now we need to configure the password for the user Ombi. On the left side of the Workbench under Management, click on Users and Privileges. The Users and Privileges window will open where you had your query window. Click on the user ombi and change his password. In this example we will be changing the password to "ombi". Remember the password if you use a different password than "ombi".

![](https://i.imgur.com/VQWnOjU.png)

We are done with MySQL Server and the MySQL workbench. One quick tip is that on the left side (where you found Users and Privileges) there is a Dashboard. This will show you what kind of activity is running on your MySQL Server. I find this handy to check if Ombi has a connection or not.

***

### Configuring Ombi to use MySQL.
Ombi is configured by default to use the SQLite databases. You can see this databases in the Ombi Directory (where you have the ombi files). They are called: Ombi.db, OmbiSettings.db, OmbiExternal.db. We have made those databases on the MySQL server so it is time to tell Ombi that it needs to use the new databases.

First we need to stop the Ombi process or service. Then we need to create a file in the Ombi directory and name it "database.json". But it also needs code to know how to connect to it. So lets go step by step.

#### Open Notepad++
If you don't have Notepad++ installed you can get it [here](https://notepad-plus-plus.org/downloads/).
Once you have opened Notepad++ make a new file and we are gonna copy the following code in it:"

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
If you have made changes previously with the Port number or the Database User password, change accordingly in the code above.<br>
When you are finished click on File (top left) and click on Save As...<br>
Save the file in your Ombi directory as `database.json`.

#### Restart Ombi & test
We need to close Ombi (if it wasn't closed) and start Ombi. It depends on how you have configured Ombi how to do that. If you just run Ombi.exe, close the cmd and start Ombi again. If you have configured it as a service, you need to restart the service.

When Ombi is restarted go to Ombi via the webbrowser (normally http://localhost:5000). Check if Ombi is running and showing a clean install of Ombi. Yes this is a clean install because your old configuration is stored in the SQLite databases which isn't being used by Ombi. We told it to connect to the MySQL databases. If you encounter problems, look in the log files what errors are shown. If you aren't able to fix it yourself, you can always ask in the Support channel of the [Ombi Discord](https://discord.gg/Sa7wNWb). There is no need to configure the wizard! Just check if the ombi site comes up. If it does you can close it again and stop Ombi.

***

### Migrating to MySQL
Now we want the data and configuration stored in the SQLite databases, to be migrated to the MySQL databases.

#### Python
There is a migration script available but you'll need Python to run the migration script. The version used in this guide is Python V3.8.2. _Download [here](https://www.python.org/downloads/windows/)._ Make sure you download the correct version for your OS. So take the 64-bit if you run a 64-bit OS (this is the most likely one). Same goes for 32-bit.

Whenever you already have an older version of Python installed, please uninstall it first before you install the new one. If you are unable to uninstall it (apps still use V2). Make sure that you configure your PATH environment variables correct. More information can be found [here](https://docs.python.org/3/using/windows.html#excursus-setting-environment-variables).

When you open the installer, check the checkbox "Add Python 3.8 to PATH".
![Python Installer](https://i.imgur.com/ioSBPwn.png)<br>
You can choose to "Customize the installation" or "Install Now". If you choose "Customize the installation", don't forget to check the checkbox which sets your environmental variables.

You can check if Python is installed correctly by opening Command Prompt from the start menu and type: `python`.
That should return: `Python 3.8.2 (tags/v3.8.2:7b3ab59, Feb 25 2020, 22:45:29) [MSC v.1916 32 bit (Intel)] on win32
Type "help", "copyright", "credits" or "license" for more information.`

If it returns something else, please check your environmental variable PATH.

Time to check if it is working. Close your previous cmd (command prompt) and open a new one. Run the following code: `pip install mysqlclient`.
If it installs successfully you will get `Successfully installed mysqlclient-1.4.6`. If it is successfull skip the instructions below and continue with Migration Script.

**If you run into errors** about Microsoft Visual C++ 14.0, follow the instructions below:
> We need to install the Microsoft Visual Building tools to make sure we can download and install dependencies for Python. This can be downloaded [here](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=16).

> Make sure you use the following config:
> ![](https://i.imgur.com/Zh6Jw50.png)

> Once installed you probably need to reboot your system for the changes to take effect.

> After you have rebooted, try the code again in command prompt:
> `pip install mysqlclient`

#### Migration Script
Now it is time to start migrating!
Download the migration script [here](https://github.com/vsc55/ombi_sqlite_mysql).
Click on the `ombi_sqlite2mysql.py` and copy the contents in a new Notepad++ file. Save the file in your Ombi directory as `ombi_sqlite2mysql.py`. Do the same for `ombi_sqlite2mysql_multi.py`.

Now we'll need to create a one more file which also needs to saved in the Ombi directory:

##### database_multi.json
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

Now open CMD (command prompt) and browse to your Ombi directory using CD.

**Example**
If your Ombi location is C:\Ombi type the following in your cmd window:
`cd c:\Ombi`
If your Ombi location is on a different drive you need to change the drive first. So let's say it located on E:\Ombi:
`E:`
`CD E:\Ombi`

Once you have done that we are going to run the migration script.
Type the following:
`python ombi_sqlite2mysql_multi.py -c ./ --force`

The Migration script will run and should end with: 
```MySQL > Disconnecting... [✓]

----------------------------------------------------------------
----------------------------------------------------------------

> Updating database.json...
- Saving in (./database.json)... [✓]`
```

We are finally done! Now run Ombi to check if everything is working!

If you run into any problems, let us know on Discord and we'll do our best to help you!