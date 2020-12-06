#!/bin/bash

# Installing Nginx on Ubuntu:

if ls /etc/nginx > /dev/null

        then
                echo "_________________________________________________________\n\nNGINX is already installed."
                
        else
        
                sudo apt install nginx -y &&
                echo "_________________________________________________________\n\nNGINX installed successfully.\n_________________________________________________________\n"
                
fi                


#Command to validate if the repository already exists. If it has not been cloned, that is done.

if ls /usr/share/nginx/dox > /dev/null

        then
                echo "_________________________________________________________\n\nThe repository 'dox' already exists in /usr/share/nginx.\n______________________________________________________\n"
        else
                git clone https://github.com/uknbr/dox.git /usr/share/nginx/dox && echo "_________________________________________________________\n_________________________________________________________\nThe repository 'dox' has been successfully cloned!\n______________________________________________________\n"
fi

# !!! DEPLOY WITH NGINX !!!

# If the configuration file is found...
if ls /etc/nginx/sites-available/infratest.com > /dev/null

# ...so display that it is already in the directory...
        then
                echo "\n'infratest.com' is already in the directory.\n______________________________________________________\n"

# ...otherwise check for the existence of the "infratest" repository. If it exists, just move it to the correct directory, otherwise make a git clone of it and move the file to the correct directory. After that create an identical file in /etc/nginx/sites-enabled/ and establish a link between the two.

        elif ls /root/project/infratest > /dev/null

        then
                mv /root/project/infratest/infratest.com /etc/nginx/sites-available/ &&
                ln -s /etc/nginx/sites-available/infratest.com /etc/nginx/sites-enabled/infratest.com &&
                echo "Configuration file moved successfully."

        else

                git clone https://github.com/luannabarrete/infratest.git /root/project/infratest &&
                mv /root/project/infratest/infratest.com /etc/nginx/sites-available/ &&
                ln -s /etc/nginx/sites-available/infratest.com /etc/nginx/sites-enabled/infratest.com &&
                echo "Configuration file cloned and moved successfully."
fi

# Delete default files:
if ls /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

        then rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
        
        else echo ""
        
fi
#Validate the existence of nginx.conf file:
if ls /root/project/nginx.conf/nginx.conf

        then mv /root/project/nginx.conf/nginx.conf /etc/nginx/nginx.conf
        
        else
                git clone https://github.com/luannabarrete/config-file-nginx.git /root/project/config-file-nginx/
                mv -f /root/project/config-file-nginx/nginx.conf /etc/nginx/
fi

echo "______________________________________________________\n"

# Restart the Nginx service and display its status right after.
sudo systemctl restart nginx;
sudo systemctl status nginx;

if curl localhost:8080 > /dev/null

        then
                echo "\n

 █████╗ ███╗   ███╗██████╗  ██████╗  ██████╗███████╗
██╔══██╗████╗ ████║██╔══██╗██╔═══██╗██╔════╝██╔════╝
███████║██╔████╔██║██║  ██║██║   ██║██║     ███████╗
██╔══██║██║╚██╔╝██║██║  ██║██║   ██║██║     ╚════██║
██║  ██║██║ ╚═╝ ██║██████╔╝╚██████╔╝╚██████╗███████║
╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝  ╚═════╝  ╚═════╝╚══════╝\n_________________________\n\nTHE SITE IS UP!!! :D\n_________________________"
        else
                echo "\n_________________________\n\nTHE SITE IS DOWN!!! D:\n_________________________"

fi
        
