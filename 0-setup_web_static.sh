#!/usr/bin/env bash
# a Bash script that sets up your web servers

# Update and install Nginx if it's not already installed
sudo apt-get update
sudo apt-get install -y nginx

# Create necessary directories
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/

# Create a test HTML file
echo "<!DOCTYPE html>
<html>
    <head>
        <title>Home - AirBnB clone</title>
    </head>
    <body>
        <h1>Welcome to AirBnB clone - Deploy static!</h1>
    </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Ensure the symbolic link is correct, removing if necessary
sudo ln -fs /data/web_static/releases/test/ /data/web_static/current

# Change ownership to the 'ubuntu' user and group
sudo chown -R ubuntu:ubuntu /data/

# Safely add Nginx server block configuration for serving the static content
sudo sed -i '/server_name _;/a \\n\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}' /etc/nginx/sites-enabled/default

# Restart Nginx to apply changes
sudo service nginx restart
