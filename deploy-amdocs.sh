#!/bin/bash

#Comando if para validar se o repositório já existe, ou seja, se já foi clonado para o diretório local. Caso não tenha sido clonado, isto é feito.

if ls /usr/share/nginx/dox

        then
                echo "______________________________________________________\n______________________________________________________\n\nO repositório já foi clonado.\n______________________________________________________\n______________________________________________________\n"
        else
                git clone https://github.com/uknbr/dox.git /usr/share/nginx/dox && echo "______________________________________________________\n______________________________________________________\nReposistório clonado com sucesso!"
fi

# !!! DEPLOY COM NGINX !!!

# Se for encontrado o arquivo de configuração...
if ls /etc/nginx/sites-available/infratest.com

# ...então nada...
        then
                echo "\n'infratest.com' já se encontra no diretório.\n______________________________________________________\n"

# ...senão verifique a existência do repositório "infratest". Se existir, somente mova-o para o diretório correto, senão faça um git clone dele e mova o arquivo para o diretório correto. Após isto crie um arquivo idêntico em /etc/nginx/sites-enabled/ e estabeleça um link entre os dois.

        elif ls /root/project/infratest

        then
                mv /root/project/infratest/infratest.com /etc/nginx/sites-available/ &&
                ln -s /etc/nginx/sites-available/infratest.com /etc/nginx/sites-enabled/infratest.com &&
                echo "Arquivo de configuração movido com sucesso."

        else

                git clone https://github.com/luannabarrete/infratest.git /root/project/infratest &&
                mv /root/project/infratest/infratest.com /etc/nginx/sites-available/ &&
                ln -s /etc/nginx/sites-available/infratest.com /etc/nginx/sites-enabled/infratest.com &&
                echo "Arquivo de configuração clonado e movido com sucesso."
fi

#Excluir os arquivos Default:
if ls /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

        then rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

        else echo ""

fi

git clone https://github.com/luannabarrete/nginx.conf.git /root/

echo "______________________________________________________\n"

# Reiniciar o serviço do Nginx e exibir seus status logo apó.
sudo systemctl restart nginx;
sudo systemctl status nginx;
