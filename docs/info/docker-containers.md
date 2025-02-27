# Docker Intro

If you're running Ombi in a Docker container, then chances are you're running other services in one as well.  
There are things to consider when doing this - primarily, how are your containers going to communicate with each other/other machines?  

## Installation

### Direct Command

If you just want Ombi to run, it's entirely possible to do this without having to do much actual configuration.  
You'll (ideally) need a location mounted for Ombi to put config files (`/opt/ombi/config/` tends to be a good option on linux based systems).  
To create the folder and run Ombi on port 3579 (the default for v4), run the following from the terminal/shell:  

```bash
mkdir -p /opt/ombi/config/
docker run -d --name=ombi -p 5000:5000 --restart=unless-stopped -v /opt/ombi/config:/config linuxserver/ombi:latest
```

This will create the folder and a container named "ombi" that you can then manage like any other docker container.  
If you wish to use MySQL as a database for ombi, then you'll need to create a "database.json" file in the config folder created before.  
Details for the file can be found [here](../alternate-databases).  

### Docker Compose

Here an example of a docker-compose stack with Ombi, MySQL and phpMyAdmin.  
Please bear in mind that this is just an example and can/should be changed to your needs:  

1. Create a folder for your "/config"-volume and for the MySQL-container

    ```bash
    mkdir -p /opt/ombi/config/
    mkdir -p /opt/ombi/mysql/
    ```

1. Create a "database.json"-file in the folder from step 1 with this content --> [see here](../alternate-databases):

    ```json
    {
      "OmbiDatabase": {
        "Type": "MySQL",
        "ConnectionString": "Server=mysql_db;Port=3306;Database=Ombi;User=ombi;Password=ombi"
      },
      "SettingsDatabase": {
        "Type": "MySQL",
        "ConnectionString": "Server=mysql_db;Port=3306;Database=Ombi_Settings;User=ombi;Password=ombi"
      },
      "ExternalDatabase": {
        "Type": "MySQL",
        "ConnectionString": "Server=mysql_db;Port=3306;Database=Ombi_External;User=ombi;Password=ombi"
      }
    }
    ```

1. Create a "docker-compose.yml" file in the folder from step 1 with this content:  
(replace the `TZ` value with your timezone)

    ```yml
    ---
    version: "3"
    services:
      ombi:
        image: ghcr.io/linuxserver/ombi:latest
                container_name: ombi
        restart: unless-stopped
        environment:
          - PUID=1000
          - PGID=1000
          - TZ=Europe/Zurich
        volumes:
          - /opt/ombi/config:/config
        ports:
          - "5000:3579"
        depends_on:
        - "mysql_db"

      mysql_db:
        image: "mysql:lts"
        container_name: ombi_mysql
        restart: unless-stopped
        environment:
          MYSQL_ROOT_PASSWORD: 123 #change your root password here
        volumes:
          -  /opt/ombi/mysql:/var/lib/mysql

      phpmyadmin:
          image: phpmyadmin/phpmyadmin
          container_name: ombi_phpmyadmin
          restart: unless-stopped
          environment:
            PMA_HOST: mysql_db
          ports:
            - '8080:80'
          depends_on:
            - "mysql_db"
    ```

1. Run docker-compose to start this stack

    ```bash
    cd /opt/ombi/config
    docker-compose up -d
    ```

1. Open the phpMyadmin website "http://docker-host-ip:8080/server_sql.php".  
Login with root and your chosen password, then run the following commands:

    ```mysql
    CREATE DATABASE IF NOT EXISTS `Ombi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
    CREATE DATABASE IF NOT EXISTS `Ombi_Settings` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
    CREATE DATABASE IF NOT EXISTS `Ombi_External` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
    CREATE USER 'ombi'@'%' IDENTIFIED BY 'ombi';
    GRANT ALL PRIVILEGES ON `Ombi`.* TO 'ombi'@'%' WITH GRANT OPTION;
    GRANT ALL PRIVILEGES ON `Ombi_Settings`.* TO 'ombi'@'%' WITH GRANT OPTION;
    GRANT ALL PRIVILEGES ON `Ombi_External`.* TO 'ombi'@'%' WITH GRANT OPTION;
    ```

1. Stop the stack and start it again

    ```bash
    cd /opt/ombi/config
    docker-compose down 
    docker-compose up -d
    ```

1. Open Ombi "http://docker-host-ip:5000" and setup your ombi installation.

## Considerations

## Host vs Bridge Networking

### Host

Host networking gives the *__container__* direct access to the network adapter of the *__host__* machine (the one running Docker).  
This means that the container runs like any other network application, with complete freedom to discover other devices/services on your network. It is appropriate for some systems (like Home Assistant), but one of the benefits of Docker is the 'isolation' of services (so nothing depends on anything else).  

### Bridge

Bridge networking makes the Docker Host behave like a VM Host *and* a router, with a whole separate virtual network behind its own LAN IP.  
Each *__container__* then gets an IP in a whole different IP range than your LAN itself. Usually, Docker uses 172.17.0.x for these. If the Ombi container was given 172.17.0.3, then it would listen on 172.17.0.3:5000 (for example).  
This means that you map ports from the *__host__* to the *__container__*, much like port forwarding for access from outside your network (as you would for passing ports 80 and 443 to your web server, for instance). The two ports do not have to be the same - you could map 3589 on your *__host__* to point to 3579 on your *__container__*.  
To access the service from outside of the Docker *__host__*, you'd browse to the LAN IP of said host and the port you mapped - 3589 in the example above. Docker would see the traffic hit the *__host__* on 3589 and pass it through (via Network Address Translation, or 'NAT') to the *__container__* on 172.17.0.3:5000

## Talking to Other Services

If you have an Ombi container, and a Sonarr container (or Radarr/Lidarr/CouchPotato etc), then these services will all need to talk to each other.  
If you've configured your containers to use __host__ networking, then all you'll need to do is use the LAN IP of the Docker *__host__* as the IP of the service.  
However, if you've used __bridge__, then you can use either the *__container__* IP or the *__container__* name instead (as this stays inside the virtual network that the *__host__* created for all the containers to communicate via).  
For example, if you have a Sonarr *__container__* named "sonarr" that has an IP of 172.17.0.17, then you could either enter "sonarr" or "172.17.0.17" as the address for Ombi to reach Sonarr.  

## Finding Container IP addresses

If you want to get the container IP, then you'll need to query docker for it.  
Most GUI options for Docker will report it (Portainer is a good one).  
If you prefer the CLI/console/bash/shell, then you can inspect the container that way with the below command:

``` bash
docker inspect <container name> | grep "IPAddress"
```

If you don't recall what name you used for the container, then you can find out your container names with:

``` bash
docker container ps
```
