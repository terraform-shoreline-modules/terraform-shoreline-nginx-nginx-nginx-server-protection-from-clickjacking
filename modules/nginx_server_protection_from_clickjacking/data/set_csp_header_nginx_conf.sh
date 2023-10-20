

#!/bin/bash



# Set the CSP header value

CSP_VALUE="default-src 'self'"



# Backup the original nginx configuration file

cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak



# Add the CSP header to the nginx configuration file

sed -i "/http {/a add_header Content-Security-Policy \"$CSP_VALUE\";" /etc/nginx/nginx.conf



# Test the configuration and reload nginx if it passes

nginx -t && systemctl reload nginx