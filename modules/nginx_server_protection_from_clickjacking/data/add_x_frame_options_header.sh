

#!/bin/bash



# Set the configuration file path

CONFIG_FILE=${NGINX_CONFIG_FILE_PATH}



# Set the X-Frame-Options header value

X_FRAME_OPTIONS=${X_FRAME_OPTIONS_VALUE}



# Backup the original configuration file

cp $CONFIG_FILE $CONFIG_FILE.bak



# Add the X-Frame-Options header to the configuration file

sed -i "/^http {/a add_header X-Frame-Options $X_FRAME_OPTIONS;" $CONFIG_FILE



# Test the configuration file for syntax errors

nginx -t



# If the configuration file passes the syntax test, restart the Nginx server

if [ $? -eq 0 ]; then

    systemctl restart nginx

fi