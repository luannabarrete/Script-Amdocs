#!/bin/bash

# Installing Nginx on Ubuntu:

if ls /etc/nginx > /dev/null 2>&1

    then
        echo "_________________________________________________________\n\nNGINX is already installed."
            
    else
        apt install nginx -y &&
        echo "_________________________________________________________\n\nNGINX installed successfully.\n_________________________________________________________\n"
                
fi                


#To validate if the repository already exists. If it has not been cloned, that is done.

if ls /usr/share/nginx/dox > /dev/null 2>&1

    then
        echo "_________________________________________________________\n\nThe repository 'dox' already exists in /usr/share/nginx.\n_________________________________________________________\n"
    
    else
        git clone https://github.com/uknbr/dox.git /usr/share/nginx/dox && echo "_________________________________________________________\nThe repository 'dox' has been successfully cloned to /usr/share/nginx!\n______________________________________________________\n"

fi

# !!! DEPLOY WITH NGINX !!!

# If the configuration file is found...
if ls /etc/nginx/sites-available/infratest.com > /dev/null 2>&1

    # ...so display that it is already in the directory...
    then
        echo "The configuration file 'infratest.com' is already in /etc/nginx/sites-available/ and /etc/nginx/sites-enabled/.\n________________________________________________________________________________________________________________"

    # ...otherwise check for the existence of the "infratest" repository. If it exists, just move it to the correct directory, otherwise make a git clone of it and move the file to the correct directory. After that create an identical file in /etc/nginx/sites-enabled/ and establish a link between the two.
    elif ls /root/project/infratest/infratest.com ; cat /etc/nginx/sites-available/infratest.com | grep "amdocs.html" > /dev/null 2>&1

        then
            mv -f /root/project/infratest/infratest.com /etc/nginx/sites-available/ &&
            ln -s /etc/nginx/sites-available/infratest.com /etc/nginx/sites-enabled/infratest.com &&
            echo "Configuration file is already configured in /etc/nginx/sites-available/ and /etc/nginx/sites-enabled/."

        else
            rm -fr /root/project/infratest/
            git clone https://github.com/luannabarrete/infratest.git /root/project/infratest &&
            mv -f /root/project/infratest/infratest.com /etc/nginx/sites-available/ &&
            ln -s /etc/nginx/sites-available/infratest.com /etc/nginx/sites-enabled/infratest.com &&
            echo "Configuration file cloned and moved successfully to /etc/nginx/sites-available/. Symbolic link has been established in /etc/nginx/sites-enabled/."
fi

# Delete default files:
if ls /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default > /dev/null 2>&1
    
    then rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
        
    else echo ""
    
fi

#Validate the existence of nginx.conf file and moving it to /etc/nginx/:
if ls /root/project/config-file-nginx/ > /dev/null 2>&1 ; cat /etc/nginx/nginx.conf | grep "PROTECTION" > /dev/null 2>&1

    then 
        echo "The repository 'config-file-nginx' already exists in /root/project/ and was moved to /etc/nginx/."
               
    else
        rm -fr /root/project/config-file-nginx/
        git clone https://github.com/luannabarrete/config-file-nginx.git /root/project/config-file-nginx/ > /dev/null 2>&1 &&
        echo "The repository with the configuration file has been cloned successfully!\n"
        mv -f /root/project/config-file-nginx/nginx.conf /etc/nginx/
        echo "\nConfiguration file 'nginx.conf' moved to /etc/nginx/ successfully!\n"
        rm -fr /root/project/config-file-nginx/
        git clone https://github.com/luannabarrete/config-file-nginx.git /root/project/config-file-nginx/ > /dev/null 2>&1
fi

echo "________________________________________________________________________________________________________________\n"

# Restart the Nginx service and display its status right after.



if curl localhost:8080 > /dev/null 2>&1

    then    
        systemctl status nginx
        echo "\n

 █████╗ ███╗   ███╗██████╗  ██████╗  ██████╗███████╗
██╔══██╗████╗ ████║██╔══██╗██╔═══██╗██╔════╝██╔════╝
███████║██╔████╔██║██║  ██║██║   ██║██║     ███████╗
██╔══██║██║╚██╔╝██║██║  ██║██║   ██║██║     ╚════██║
██║  ██║██║ ╚═╝ ██║██████╔╝╚██████╔╝╚██████╗███████║
╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝  ╚═════╝  ╚═════╝╚══════╝\n_________________________\n\nTHE SITE IS UP!!! :D\n_________________________\n"
    else    
        echo "\n_________________________\n\nTHE SITE IS DOWN!!! D:\n\nRestarting site...\n_________________________\n"
        systemctl restart nginx
        systemctl status nginx
        
fi
        
