# Script-Amdocs

#Raciocínio

Instalar o Nginx no Ubuntu

1. Clonar o repositório do git no Ubuntu

	-- faço um git clone no diretório /usr/share/nginx/.
		--- o arquivo amdocs.html está agora em /usr/share/nginx/dox/

			$ git clone https://github.com/uknbr/dox.git /usr/share/nginx/

2. Desejo: Fazer deploy do .html com o Nginx

	- Preciso saber como direcionar o Nginx para o arquivo HTML, configurando o caminho do mesmo no Nginx.
	- configurando o Nginx

		-- Removo os arquivos de configuração Default e crio um arquivo de configuração:
			$ vim /etc/nginx/sites-available/infratest.com
		-- Atribuo o seguinte texto a ele, configurando o site na porta 8080:


"server {
    listen 80 default_server;

    root /usr/share/nginx/example.com;
    index index.php index.html index.htm;

    server_name example.com www.example.com;
    location / {
        try_files $uri $uri/ /index.php;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/run/php/php7.2-fpm.sock;
        include snippets/fastcgi-php.conf;
    }
}"
		


	-- Agora testo no navegador: Endereço de IP:porta e DEU CERTO!!!


Agora que fiz o deploy, preciso criar um script para automatizar todo este processo.

