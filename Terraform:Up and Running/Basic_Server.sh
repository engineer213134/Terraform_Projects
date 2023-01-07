#Basic script to that configures a web server by installing dependencies, checking out some code from a Git repo, and firing up an Apache web server
#!/bin/bash 
# Update the apt-get cache
sudo apt-get update
# Install PHP and Apache
sudo apt-get install -y php apache2
# Copy the code from the repository
sudo git clone https://github.com/brikis98/php-app.git /var/www/html/app
# Start Apache
sudo service apache2 start
