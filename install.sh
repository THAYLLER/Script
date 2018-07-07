#!/bin/bash

set -e

echo o Atualizando repositórios..
if ! apt update
then
    echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    exit 1
fi
echo "Atualização feita com sucesso"

echo "#####################################################"

echo "Atualizando pacotes já instalados"
if ! sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade
then
    echo "Não foi possível atualizar pacotes."
    exit 1
fi
echo "Atualização de pacotes feita com sucesso"

echo "#####################################################"

echo "Instalando MYSQL"
if ! sudo apt install mysql-server
then
    echo "Não foi possível instalar o mysql"
    exit 1
fi
echo "Instalação finalizada"

echo "#####################################################"

echo "Instalando Apache"
if !sudo apt install apache2
then
	echo "Não foi possível instalar o apache2"
	exit 1
fi
echo "Instalação finalizada"

echo "#####################################################"

echo "Ativando modulos apache2"
if !sudo a2enmod rewrite && sudo systemctl restart apache2
then
	echo "Modulos não ativados"
	exit 1
fi
echo "Modulos ativados"

echo "#####################################################"

echo 	"Instalando php 7"

if !sudo apt install libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-json php-memcached php7.0-dev php7.0-mcrypt php7.0-sqlite3 php7.0-mbstring
then
	echo "Não foi possível instalar o php7"
	echo "nota: se estiver instalando o php no linux mint 19 alterar o script para sudo apt install php
	exit 1
fi
echo "Instalação finalizada"

echo "#####################################################"

"Dica de segurança: 
Abra o arquivo /etc/php/7.0/apache2/php.ini com o nano e procure pela linha (ctrl + w) cgi.fix_pathinfo, ela está comentada por ; e com valor setado para 1, descomente a linha e defina o valor para zero.
Quando fizer a alteração rode o comando sudo systemctl restart apache2."

echo "#####################################################"

echo "Ativar extensão mcrypt"
if !sudo phpenmod mcrypt && systemctl restart apache2
then
	echo "Não foi possivel ativar a extensão mcrypt"
	exit 1
fi
echo "Extesão ativada"

