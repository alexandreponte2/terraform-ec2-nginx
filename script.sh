#!/bin/bash
sudo apt-get update
sudo apt install -y nginx
sudo echo "<h1>Hello World from the other side, i am at $(hostname -f)</h1>" > /var/www/html/index.nginx-debian.html
sudo systemctl restart nginx
sudo systemctl status nginx
sudo nginx -t