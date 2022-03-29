#!/bin/bash

#Variaveis
echo "Qual é o nome do host?"
read NOME

#Setando hostname
hostname -b $NOME

#Atualizando sistema
echo " " && echo "Atualizando sistema (apt UPDATE)" && echo " "
apt update -y
echo " " && echo "Atualizando sistema (apt UPGRADE)" && echo " "
apt upgrade -y

#Google Chrome
echo " " && echo "Baixando Google Chrome" && echo " "
wget -P /tmp https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
echo " " && echo "Instalando Google Chrome" && echo " "
apt install -y /tmp/google-chrome-stable_current_amd64.deb

#Anydesk
echo " " && echo "Adicionando chave e repos do Anydesk" && echo " "
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list

#Instalando programas
echo " " && echo "Instalando Anydesk" && echo " "
apt install -y anydesk

echo " " && echo "Instalando OCS Agent" && echo " "
echo "NA PROXIMA TELA, NA INSTALAÇÃO DO OCS ESCOLHA A OPÇÃO -> LOCAL <-"
apt install -y ocsinventory-agent

#Configs
echo " " && echo "Configurando OCS Agent" && echo " "
echo "server = http://10.10.10.10/ocsinventory
# local = /var/lib/ocsinventory-agent
tag = $NOME
# How to log, can be File,Stderr,Syslog
logger = Stderr
logfile = /var/log/ocsinventory-agent/ocsinventory-agent.log" > /etc/ocsinventory/ocsinventory-agent.cfg

echo " " && echo "Rodando OCS Agent" && echo " "
ocsinventory-agent

#Reiniciando
sleep 60
#reboot
