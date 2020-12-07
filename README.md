# Script-Amdocs


Installing Nginx on Ubuntu

1. Cloning repository 'dox' with the html file to Ubuntu.

	-- Git clone to /usr/share/nginx/.
		$ git clone https://github.com/uknbr/dox.git /usr/share/nginx/
		--- the file 'amdocs.html' is now in /usr/share/nginx/


2. Make deploy of amdocs.html with NGINX

	- Direct Nginx to HTML file, configuring its path on Nginx.

		-- Removing configuration files 'Default' and creating a new one.
			$ vim /etc/nginx/sites-available/infratest.com
		-- Assigning the following text to it, configuring the site on port 8080:


"server {
    listen 8080 default_server;

    root /usr/share/nginx/example.com;
    index index.php index.html index.htm amdocs.html;

    server_name infratest.com www.infratest.com;
    location / {
        try_files $uri $uri/ /index.php;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/run/php/php7.2-fpm.sock;
        include snippets/fastcgi-php.conf;
    }
}"
		


	-- Testing on browser: ip address:port (8080)!

Automating this whole proccess in a script. 
