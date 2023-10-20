
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Nginx server protection from clickjacking.
---

Clickjacking is a type of attack where a user is tricked into clicking on a malicious link or button that is disguised as a legitimate one. This can allow an attacker to take control of a user's session and perform unauthorized actions. In the context of software engineering, this incident type refers to protecting an Nginx server from clickjacking attacks. This may involve implementing measures such as X-Frame-Options headers to prevent the server from being embedded in malicious web pages.

### Parameters
```shell
export SERVER_ADDRESS="PLACEHOLDER"

export X_FRAME_OPTIONS_VALUE="PLACEHOLDER"

export NGINX_CONFIG_FILE_PATH="PLACEHOLDER"
```

## Debug

### Check if Nginx server is running
```shell
systemctl status nginx
```

### Check Nginx server headers
```shell
curl -I ${SERVER_ADDRESS}
```

### Check Nginx configuration file syntax
```shell
nginx -t
```

### Check if X-Frame-Options header is present
```shell
curl -s -D - ${SERVER_ADDRESS} | grep -i X-Frame-Options
```

## Repair

### Implement X-Frame-Options headers in the Nginx server configuration to prevent the server from being embedded in malicious web pages.
```shell


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


```

### Use Content Security Policy (CSP) to restrict the types of content that can be loaded on the server, and to prevent the execution of malicious scripts.
```shell


#!/bin/bash



# Set the CSP header value

CSP_VALUE="default-src 'self'"



# Backup the original nginx configuration file

cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak



# Add the CSP header to the nginx configuration file

sed -i "/http {/a add_header Content-Security-Policy \"$CSP_VALUE\";" /etc/nginx/nginx.conf



# Test the configuration and reload nginx if it passes

nginx -t && systemctl reload nginx


```