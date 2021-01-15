This is an NGINX subdomain reverse proxy that **DOES NOT** use baseurl.  I'm running Ombi v4 on "Docker for Windows" (sic) with NGINX running natively on Windows 10 via [OrganizrInstaller](https://github.com/elmerfdz/OrganizrInstaller).

```conf
# Ombi v4 Subdomain
# Replace DOMAIN.TLD with your domain
server {
    listen 80;
    server_name ombi.*;
    return 301 https://$server_name$request_uri;
}
server {
    listen 443 ssl http2;
    server_name ombi.*;
        server_name ombi.DOMAIN.TLD;
        ssl_certificate /nginx/ssl/DOMAIN.TLD-chain.pem;
        ssl_certificate_key /nginx/ssl/DOMAIN.TLD-key.pem;
        ssl_session_cache builtin:1000;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_prefer_server_ciphers on;
        ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:ECDHE-RSA-DES-CBC3-SHA:ECDHE-ECDSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA';
        ssl_session_tickets off;
        ssl_ecdh_curve secp384r1;
        resolver 1.1.1.1 1.0.0.1 valid=300s;
        resolver_timeout 10s;
		gzip on;
		gzip_vary on;
		gzip_min_length 1000;
		gzip_proxied any;
		gzip_types text/plain text/css text/xml application/xml text/javascript application/x-javascript image/svg+xml;
		gzip_disable "MSIE [1-6]\.";
    
    location / {
        proxy_pass http://127.0.0.1:5000;
	proxy_http_version 1.1;
	proxy_set_header Upgrade $http_upgrade;
	proxy_set_header Connection "upgrade";
    }
# This allows access to the actual api
location /api {
        proxy_pass http://127.0.0.1:5000;
}
# This allows access to the documentation for the api
location /swagger {
        proxy_pass http://127.0.0.1:5000;
}
}
```
***
## Subdirectory Configuration
This is an NGINX reverse proxy configuration that **DOES** use baseurl. This has been tested both from a localhost redirect as well as through a router from a DMZ machine on Unbuntu 18.04.

The advantage of this configuration is that it allows for a single certificate to provide ssl services for many different web apps.

    e.g.
    www.somedomain.com/ombi
    www.somedomain.com/sonarr
    www.somedomain.com/radarr

You would only need to install/support a certificate for **www.somedomain.com**.

**Important note that you should use extreme care when exposing services to the internet**

This configuration is if you want to run a subdirectory configuration. Note, Ombi must be started with the `--baseurl /ombi` option

### Location Block
    location /ombi {
       proxy_pass http://<ip addr or hostname>:5000;
       include /etc/nginx/proxy.conf;
    }

    # This allows access to the actual api
    location /ombi/api {
       proxy_pass http://<ip addr or hostname>:5000;
    }
    # This allows access to the documentation for the api
    location /ombi/swagger {
        proxy_pass http://<ip addr or hostname>:5000;
    }

### proxy.conf
    client_max_body_size 10m;
    client_body_buffer_size 128k;

    #Timeout if the real server is dead
    proxy_next_upstream error timeout invalid_header http_500 http_502 http_503;

    # Advanced Proxy Config
    send_timeout 5m;
    proxy_read_timeout 240;
    proxy_send_timeout 240;
    proxy_connect_timeout 240;

    # Basic Proxy Config
    proxy_set_header Host $host:$server_port;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-Host $server_name;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto https;
    proxy_redirect  http://  $scheme://;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_cache_bypass $cookie_session;
    proxy_no_cache $cookie_session;
    proxy_buffers 32 4k;
    proxy_redirect http://<ip addr or hostname>:5000 https://$host;
