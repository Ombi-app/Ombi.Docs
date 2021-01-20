# Reverse Proxy Examples

> Note: These examples assume you are using **_/ombi_** as your **Base URL**.  
> If your **Base URL** differs, replace all instances of **_/ombi_** with **_/YourBaseURL_**.  
> If you're using a **subdomain** (ombi.example.com), replace all instances of **_/ombi_** with **_/_**, and remove the first _location_ block.
  
## Nginx

### Nginx Subdirectory

To use nginx as a reverse proxy requires no extra modules, but it does require configuring.  
In the configuration for your nginx site (nginx.conf for the default site), you'll need to add a 'block' for catching ombi as a subpath. If you wish to use a subdomain, there is an [example further down](#nginx-subdomain).  
It goes directly below the default location, which usually looks like this:  

    location / {
        root   html;
        index  index.html index.htm;
    }

The block to add looks like this (some changes can be made depending on your setup, but generally this works).  
Note that if the machine hosting your application is not the same as your web server, then you'll need to replace `127.0.0.1` with the IP of your Ombi host.  
If you are using a port other than `5000`, you'll also need to update that to match.  
Nginx is smart enough to match the "ombi" in your location to the "ombi" in your BaseURL.  

    location /ombi/ {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $server_name;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Ssl on;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_read_timeout  90;
        proxy_redirect http://127.0.0.1:5000 https://$host;
    }

### Nginx Subdomain

If you wish to use ombi.example.com rather than example.com/ombi, then you need to create a site per service.  
You will also need to ensure that ombi is not configured to use a BaseURL.  
Each site has a separate config file in the sites-available directory. By default, this is `/etc/nginx/sites-available`.  
We're going to use the site name as the file name, so in this case we need to put the following into  
`/etc/nginx/sites-available/ombi.example.com.conf`  
Note that this example does not enable SSL or generate a certificate, but that can be done afterwards using a tool like Certbot. Certbot will add the `listen 443`, generate, and apply the certificates using LetsEncrypt.  
Of course, replace 127.0.0.1:5000 with whatever IP and port combination you are using for Ombi.  
Ensure your Application Url (in Ombi) matches the `server_name` field.

    server {
    listen 80;
    listen [::]:80;

    server_name ombi.example.com;

    location / {
        proxy_pass http://127.0.0.1:5000/;
    }
    }

Disable support for Websockets. Disable these items by commenting them out:

```conf
# Allow websockets on all servers
#proxy_http_version 1.1;
#proxy_set_header Upgrade $http_upgrade;
#proxy_set_header Connection "upgrade";
```

Once the config file has been created (_and saved_), we need to enable the site. This is done by symlinking the config file into the sites-enabled directory. The below commands will achieve this (obviously, replace the `ombi.example.com` sections with whatever names you used for your setup.  
__Linux:__  
`ln -s /etc/nginx/sites-available/ombi.example.com.conf /etc/nginx/sites-enabled/ombi.example.com.conf`  
__Windows:__  
`mklink C:\nginx\conf\sites-enabled\ombi.example.com.conf C:\nginx\conf\sites-available\ombi.example.com.conf`  
We then restart nginx to load the new config file, at which point your system will be listening on [http://ombi.example.com](http://ombi.example.com) for traffic (after you set up certbot, it will change to [https://ombi.example.com](http://ombi.example.com)).  
__Linux:__  
`service nginx restart`  
__Windows:__  
`nginx -s reload`  

***

## Apache2

To run Apache with a reverse proxy setup, you'll need to activate certain modules.  
(assume all commands require sudo):  

```bash
apt-get install -y libapache2-mod-proxy-html libxml2-dev
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_ajp
a2enmod rewrite
a2enmod deflate
a2enmod headers
a2enmod proxy_balancer
a2enmod proxy_connect
a2enmod proxy_html
```

In your Virtualhost configuration file you'll need to add a few things.  
_**Note:** VirtualHost configurations are usually under /etc/apache2/sites-enabled/_  

Just below the `DocumentRoot` entry:  
`ProxyPreserveHost On`  

You can then add the configuration for each item you wish to proxy.  
There are two methods for doing this.  
One is with a 'Location' section, the other is simply a direct mapping (the dirty way).  
The mapping goes just before the `</VirtualHost>` closing tag, regardless of the method.  
If you want to run ombi.example.com instead of site.example.com/ombi, then replace `/ombi` with `/` and drop the `/ombi` from the end of the internal addresses, as well as removing the BaseURL from Ombi itself.

### Apache2 Subdirectory

    <Location /ombi>
    Allow from 0.0.0.0 
    ProxyPass "http://ip.of.ombi.host:5000/ombi" connectiontimeout=5 timeout=30 keepalive=on 
    ProxyPassReverse "http://ip.of.ombi.host:5000/ombi" 
    </Location>

### Apache2 Subdomain

    ProxyPass /ombi http://ip.of.ombi.host:5000/ombi
    ProxyPassReverse /ombi http://ip.of.ombi.host:5000/ombi

Once all your changes are done, you'll need to run `service apache2 restart` to make the changes go live.

***

## IIS

- _(Below rules DO WORK with OMBI v3 - Edited 22 APR 18 by @seanvree)_

NOTE: There are some extra steps involved with getting IIS to proxy things.  
Install these two modules:

- [URL Rewrite](http://www.iis.net/downloads/microsoft/url-rewrite)
- [Application Request Routing](https://www.iis.net/downloads/microsoft/application-request-routing)

After installing the above, enable the proxy function via:  
IIS admin -> Application Request Routing Cache -> Server Proxy Settings, tick "Enable proxy"

### IIS Subdirectory

- _NOTE1:  Below rules assume you have a "virtual directory" named "OMBI" under your default website in IIS.  That VD should target a physical directory that resides at `c:\inetpub\wwwroot\ombi`.  
Within this directory you would place the below rules in a web.config file. There should be no other files in this directory.  
(This should NOT be your OMBI install directory)_
- _NOTE2:  Change `yourdomain.com`_

```xml
<configuration>
    <system.webServer>
        <defaultDocument>
            <files>
            </files>
        </defaultDocument>
        <rewrite>
            <rules>
                <clear />
                <rule name="ReverseProxyInboundOMBI" stopProcessing="true">
                    <match url="(.*)" />
                    <action type="Rewrite" url="http://localhost:5000/ombi/{R:1}" />
                    <serverVariables>
                        <set name="host" value="$host" />
                        <set name="HTTP_X_FORWARDED_HOST" value="$server_name" />
                        <set name="HTTP_X_REAL_IP" value="$remote_addr" />
                        <set name="HTTP_X_FORWARDED_FOR" value="$proxy_add_x_forwarded_for" />
                        <set name="HTTP_X_FORWARDED_PROTO" value="$scheme" />
                        <set name="HTTP_X_FORWARDED_SSL" value="on" />
                    </serverVariables>
                    <conditions trackAllCaptures="true">
                    </conditions>
                </rule>
            </rules>
            <outboundRules>
                <clear />
                <rule name="Restore Encoding" preCondition="Restore HTTP_ACCEPT_ENCODING}" enabled="true">
                    <match serverVariable="HTTP_ACCEPT_ENCODING" pattern="^(.+)" />
                    <conditions logicalGrouping="MatchAll" trackAllCaptures="true" />
                    <action type="Rewrite" value="{HTTP_X_ORIGINAL_ACCEPT_ENCODING}" />
                </rule>
                <rule name="ReverseProxyOutboundOMBI" preCondition="ResponseIsHtml1" enabled="true" stopProcessing="false">
                    <match filterByTags="A, Area, Base, Form, Frame, Head, IFrame, Img, Input, Link, Script" pattern="^http(s)?://localhost:5000/ombi/(.*)" />
                    <conditions logicalGrouping="MatchAll" trackAllCaptures="true">
                        <add input="{HTTP_REFERER}" pattern="/ombi" />
                    </conditions>
                    <action type="Rewrite" value="http{R:1}://YOURDOMAIN.com/ombi/{R:2}" />
                </rule>
        <preConditions>
            <preCondition name="ResponseIsHtml1">
                <add input="{RESPONSE_CONTENT_TYPE}" pattern="^text/html" />
            </preCondition>
            <preCondition name="Restore HTTP_ACCEPT_ENCODING}">
                <add input="{RESPONSE_CONTENT_TYPE}" pattern=".+" />
            </preCondition>
        </preConditions>
            </outboundRules>
        </rewrite>
        <security>
            <authentication>
            </authentication>
        </security>
        <urlCompression doStaticCompression="true" doDynamicCompression="false" />
    </system.webServer>
</configuration>
```

### IIS Subdomain

- _NOTE1:  Below rules assume you have a dedicated site to run Ombi under in IIS.  
The address for this needs to match your application URL in Ombi, and should target a physical directory that resides at c:\inetpub\ombi.  
Within this directory you would place the below rules in a web.config file. There should be no other files in this directory.  
(This should NOT be your OMBI install directory)_

- _NOTE2:  Change "yourdomain.com"_
- _NOTE 3: Change "ombi_ip:port" to whatever your local address for Ombi is._
- _NOTE 4: Be sure you set your application URL in Ombi to whatever your site in IIS is listening to._

```xml
<configuration>
    <system.webServer>
        <rewrite>
            <rules>
                <rule name="HTTP to HTTPS redirect" stopProcessing="true" enabled="false">
                    <match url="(.*)" />
                    <conditions>
                        <add input="{HTTPS}" pattern="off" ignoreCase="true" />
                    </conditions>
                    <action type="Redirect" redirectType="Found" url="https://{HTTP_HOST}/{R:1}" />
                </rule>

                <rule name="RP_Ombi" enabled="true" stopProcessing="true">
                    <match url="(.*)" />
                    <action type="Rewrite" url="http://localhost:5000/{R:1}" />
                    <serverVariables>
                    </serverVariables>
                </rule>
            </rules>
            <outboundRules>
                <clear />
                <preConditions>
                    <preCondition name="Restore HTTP_ACCEPT_ENCODING}">
                        <add input="{RESPONSE_CONTENT_TYPE}" pattern=".+" />
                    </preCondition>
                </preConditions>
            </outboundRules>
        </rewrite>
    </system.webServer>
</configuration> 
```

***

## Caddy

Caddy 2 is a powerful, enterprise-ready, open source web server with automatic HTTPS written in Go.  
You can find Caddy [here](https://caddyserver.com/), and their docs can be found [here](https://caddyserver.com/docs/).  
An official docker image can be found [here](https://hub.docker.com/r/abiosoft/caddy/).  
Otherwise you can direct install using a binary found [here](https://github.com/caddyserver/caddy/releases).

_**Note:** The official binaries and Docker image do not include any of the DNS plugins required for wildcard certificates or DNS verification instead of port 80 verification. If your connection blocks port 80, you will need to build your own binary or image to include these._

### Caddy Subdirectory

```conf
your.domain.tld {
    route /ombi* {
        reverse_proxy 127.0.0.1:5000
    }
}
```

### Caddy Subdomain

```conf
ombi.yourdomain.tld {
    reverse_proxy 127.0.0.1:5000
  }
```

## Traefik

Traefik is the a great reverse proxy option if you are using a container-based setup such as docker compose.  
You can find Traefik [here](https://docs.traefik.io/), and their getting started guide [here](https://docs.traefik.io/getting-started/quick-start/).  
For more information and examples on the usage of labels in docker compose (specific to traefik) go [here](https://docs.traefik.io/user-guides/docker-compose/basic-example/).  
_**Note:** The following configuration examples only apply to traefik version 2 and later._  
_**Note 2:** All examples contain additional labels not necessarily required for your setup such as wildcard SSL certificates via Let's Encrypt and SSL related headers._

Adjust the values of `traefik.docker.network=traefik_proxy`, `traefik.http.routers.ombi.entrypoints=https` and ``traefik.http.routers.ombi.rule=Host(`ombi.example.com`)`` to match your specific setup.

### Traefik Subdirectory

The following configuration would make Ombi available at "https://example.com/ombi".  
_**Note:** When using a subdirectory it is essential to use `PathPrefix` instead of `Path`. More information [here](https://docs.traefik.io/routing/routers/#rule), specifically `Path Vs PathPrefix`._

```yaml
    labels:
      - traefik.enable=true
      - traefik.http.services.ombi.loadbalancer.server.port=3579
      - traefik.docker.network=traefik_proxy
      - traefik.http.routers.ombi.rule=PathPrefix(`/ombi`)
      - traefik.http.routers.ombi.entrypoints=https
      - traefik.http.routers.ombi.tls.certresolver=letsencrypt
      - traefik.http.routers.ombi.tls.domains[0].main=*.example.com
      - traefik.http.routers.ombi.tls.domains[0].sans=example.com
      - traefik.http.middlewares.ombi.headers.SSLRedirect=true
      - traefik.http.middlewares.ombi.headers.STSSeconds=315360000
      - traefik.http.middlewares.ombi.headers.browserXSSFilter=true
      - traefik.http.middlewares.ombi.headers.contentTypeNosniff=true
      - traefik.http.middlewares.ombi.headers.forceSTSHeader=true
      - traefik.http.middlewares.ombi.headers.SSLHost=
      - traefik.http.middlewares.ombi.headers.STSIncludeSubdomains=true
      - traefik.http.middlewares.ombi.headers.STSPreload=true
      - traefik.http.middlewares.ombi.headers.frameDeny=true
```

### Traefik Subdomain

The following configuration would make Ombi available at [https://ombi.example.com](https://ombi.example.com).  

```yaml
    labels:
      - traefik.enable=true
      - traefik.http.services.ombi.loadbalancer.server.port=3579
      - traefik.docker.network=traefik_proxy
      - traefik.http.routers.ombi.rule=Host(`ombi.example.com`)
      - traefik.http.routers.ombi.entrypoints=https
      - traefik.http.routers.ombi.tls.certresolver=letsencrypt
      - traefik.http.routers.ombi.tls.domains[0].main=*.example.com
      - traefik.http.routers.ombi.tls.domains[0].sans=example.com
      - traefik.http.middlewares.ombi.headers.SSLRedirect=true
      - traefik.http.middlewares.ombi.headers.STSSeconds=315360000
      - traefik.http.middlewares.ombi.headers.browserXSSFilter=true
      - traefik.http.middlewares.ombi.headers.contentTypeNosniff=true
      - traefik.http.middlewares.ombi.headers.forceSTSHeader=true
      - traefik.http.middlewares.ombi.headers.SSLHost=
      - traefik.http.middlewares.ombi.headers.STSIncludeSubdomains=true
      - traefik.http.middlewares.ombi.headers.STSPreload=true
      - traefik.http.middlewares.ombi.headers.frameDeny=true
```

### Traefik Subdomain and Subdirectory

The following configuration would make Ombi available at [https://media.example.com/request](https://media.example.com/request).  
_**Note:** When using a subdirectory it is essential to use `PathPrefix` instead of `Path`. More information [here](https://docs.traefik.io/routing/routers/#rule), specifically `Path Vs PathPrefix`._

```yaml
    labels:
      - traefik.enable=true
      - traefik.http.services.ombi.loadbalancer.server.port=3579
      - traefik.docker.network=traefik_proxy
      - traefik.http.routers.ombi.rule=Host(`media.example.com`) && PathPrefix(`/request`)
      - traefik.http.routers.ombi.entrypoints=https
      - traefik.http.routers.ombi.tls.certresolver=letsencrypt
      - traefik.http.routers.ombi.tls.domains[0].main=*.example.com
      - traefik.http.routers.ombi.tls.domains[0].sans=example.com
      - traefik.http.middlewares.ombi.headers.SSLRedirect=true
      - traefik.http.middlewares.ombi.headers.STSSeconds=315360000
      - traefik.http.middlewares.ombi.headers.browserXSSFilter=true
      - traefik.http.middlewares.ombi.headers.contentTypeNosniff=true
      - traefik.http.middlewares.ombi.headers.forceSTSHeader=true
      - traefik.http.middlewares.ombi.headers.SSLHost=
      - traefik.http.middlewares.ombi.headers.STSIncludeSubdomains=true
      - traefik.http.middlewares.ombi.headers.STSPreload=true
      - traefik.http.middlewares.ombi.headers.frameDeny=true
```
