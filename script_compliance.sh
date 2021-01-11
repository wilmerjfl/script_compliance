#!/bin/bash
#Script to check compliance status of a mac
GR='\033[1;32m'
RED='\033[1;31m'
OR='\033[0;33m'
YL='\033[1;33m'
GY='\033[1;34m'
NC='\033[0m' # No Color
user=$(dscl . list /Users | grep -v '_' | grep -v 'daemon' | grep -v 'macadmin' | grep -v 'meliadmin' | grep -v 'mfe' | grep -v 'nobody' | grep -v 'root')
printf "${NC}Verificando el compliance de la notebook....${NC}\n"
#Check admin
#printf "${NC}Verificando Admin: ${NC}"
if groups $user | grep -q -w admin; 
then 
    printf "${GR}Es admin${NC}\n"; 
else 
    echo "${RED}No es admin${NC}\n"; 
fi
#Check Printers
#printf "${NC}Verificando Impresoras: "
if ! [ -x "$(command -v lpstat -p)" ]; then
    printf "${RED}Las impresoras no estan instaladas${NC}\n"
else
    printf "${GR}Las impresoras estan instaladas${NC}\n"
fi
#Check Hostname
#echo "Verificando Hostname"
if [[ "$(command Hostname)" == "AR0"* ]]; then
  printf "${GR}Hostname Correcto${NC}\n"
else
  printf "${RED}Hostname Incorrecto${NC}\n"
fi
#Check Account Mobile
user=$(dscl . list /Users | grep -v '_' | grep -v 'daemon' | grep -v 'macadmin' | grep -v 'meliadmin' | grep -v 'mfe' | grep -v 'nobody' | grep -v 'root')
printf "La cuenta movil es: ${GR}${user}${NC}\n" 
#Check Brew
#echo "Verificando Brew: "
if ! [ -x "$(command -v brew)" ]; then
    printf "${RED}Brew no esta instalado${NC}\n"
else
    printf "${GR}Brew esta instalado${NC}\n"
fi
#Check Python3 
#echo "Verificando Python: "
if ! [ -x "$(command -v python3)" ]; then
    printf "${RED}Python3 no esta instalado${NC}\n"
else
    printf "${GR}Python3 esta instalado${NC}\n"
fi
#Check GIT
#echo "Verificando git"
if ! [ -x "$(command -v git)" ]; then
    printf "${RED}Git no esta instalado${NC}\n"
else
    printf "${GR}Git esta instalado${NC}\n"
fi
#Check MHUNT
#echo "Verificando Mhunt"
if ! [ -x "$(command -v pgrep mhuntagent)" ]; then
    printf "${RED}Mhunt no esta instalado${NC}\n"
else
    printf "${GR}Mhunt esta instalado${NC}\n"
fi
#Check HUB WSONE
#echo "Verificando Ivanti"
if ! [ -x "$(command -v pgrep IntelligentHubAgent)" ]; then
    printf "${RED}WSONE no esta Instalado${NC}\n"
else
    printf "${GR}WSONE esta Instalado${NC}\n"
fi
#Check CROWSTRIKE
#echo "Verificando Mcafee"
if ! [ -x "$(command -v sysctl cs)" ]; then
    printf "${RED}Crowstrike no esta Instalado${NC}\n"
else
    printf "${GR}Crowstrike esta Instalado${NC}\n"
fi
#Check GP
#echo "Verificando Global Protect"
if ! [ -x "$(command -v pgrep GlobalProtect)" ]; then
    printf "${RED}GlobalProtect no esta instalado${NC}\n"
else
    printf "${GR}GlobalProtect esta instalado${NC}\n"
fi
#Check Fury
#echo "Verificando Fury"
if ! [ -x "$(command -v fury)" ]; then
    printf "${RED}Fury no esta instalado${NC}\n"
else
    printf "${GR}Fury esta instalado${NC}\n"
fi
#Check Dominio
#echo "Verificando union al dominio:"
ping -c 3 -o arardc01.ml.com 1> /dev/null 2> /dev/null
if [[ $? == 0 ]]; then
    domain=$( dsconfigad -show | awk '/Active Directory Domain/{print $NF}' )
    if [[ "$domain" == "ml.com" ]]; then
        if [[ $? == 0 ]]; then
            printf "${GR}Esta en AD${NC}\n"
        else
            printf "${RED}No esta en AD${NC}\n"
        fi
    else
        printf "${OR}No esta vinculada al dominio de Meli${NC}\n"
    fi
else
    printf "${YL}El DC no esta en rango${NC}\n"
fi
#Check Go
if ! [ -x "$(command -v go version)" ]; then
    printf "${RED}Go no esta instalado \n"
else
    printf "${GR}Go esta Instalado\n"
fi
#Check SDKMan
sdk=$(command -v sdk version)
if [ sdk ]; then
    printf "${GR}SDKMan esta instalado \n"
else
    printf "${RED}SDKMan no esta Instalado \n"
fi
#Check NPM
if ! [ -x "$(command -v npm)" ]; then
    printf "${RED}NPM no esta instalado \n"
else
    printf "${GR}NPM esta Instalado \n"
fi
#Check Node
nvm install node || printf "${RED} Nvm no esta instalado ${NC}"
if ! [ -x "$(command -v node --version)" ]; then
    printf "${RED}Node no esta instalado \n"
else
    printf "${GR}Node esta Instalado \n"
fi
#Check Ruby
if ! [ -x "$(command -v ruby -v)" ]; then
    printf "${RED}Ruby no esta instalado \n"
else
    printf "${GR}Ruby esta Instalado \n"
fi
#Check Maven
mvn=$(command -v mvn -version)
if ! [ mvn ]; then
    printf "${RED}Maven no esta instalado \n"
else
    printf "${GR}Maven esta Instalado \n"
fi
#Check Redis
if ! [ -x "$(command -v redis-cli)" ]; then #Revisar
    printf "${RED}Redis no esta instalado \n"
else
    printf "${GR}Redis esta Instalado \n"
fi
#Check Elasticsearch
if ! [ -x "$(command -v elasticsearch --version)" ]; then #Revisar Elasticsearch e instalar java jdk btw
    printf "${RED}ElasticSearch no esta instalado \n"
else
    printf "${GR}ElasticSearch esta Instalado \n"
fi
#Check Kibana
if ! [ -x "$(command -v kibana)" ]; then
    printf "${RED}Kibana no esta instalado \n"
else
    printf "${GR}Kibana esta Instalado \n"
fi