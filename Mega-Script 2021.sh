#!/bin/bash


### Instalar SDKMAN
Install_SDKMAN ()
{
    curl "https://get.sdkman.io/"|bash && \
    source ~/.sdkman/bin/sdkman-init.sh
}

### Instalar Dev_Tools
Dev_Tools ()
{
    JavaVersion=$(sdk list java|grep "11.*-zulu"|tr -s " "|head -n 1|awk '{ print $8 }')
    
    sdk install java $JavaVersion & \

    sdk install gradle 3.5 & \

    sdk install maven 3.5.4 & \

    sdk install grails 2.5.3 && \

    sdk install grails 2.5.4 

}

### Instalar HomeBrew
Install_Homebrew ()
{
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

### Instalar Python3
Install_Python3 ()
{
    brew install python3

}

### Instalar FuryCLI
Install_FuryCLI ()
{
    pip3 install --user -i https://pypi.artifacts.furycloud.io/ furycli --upgrade --no-warn-script-location && \
    
    echo '#Added by furycli:' >> ~/.zshrc
    echo "export PATH=\"/Users/$USER/Library/Python/3.7/bin:\$PATH\"" >> ~/.zshrc
    ln -sf /Users/$USER/Library/Python/3.7/bin/fury /usr/local/bin
    ln -sf /Users/$USER/Library/Python/3.8/bin/fury /usr/local/bin
    ln -sf /Users/$USER/Library/Python/3.9/bin/fury /usr/local/bin
    source ~/.zshrc && \

    fury version # Para validar instalacion de furycli
    if [[ "$?" == 0 ]];
    then
        echo "Fury Client ha sido instalado exitosamente!"
    else
        echo "Fury Client no fue instalado correctamente, contactate con Internal Systems"
    fi
}

###Install IT Accelertor Env
Install_ITAcc ()
{
    #Install Java jdk 
    echo "Install JDK Java"
    brew tap AdoptOpenJDK/openjdk
    brew install --cask adoptopenjdk11
    #installing Go
    brew install go
    echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bash_profile 
    source ~/.bash_profile 
    go version
    if [[ "$?" == 0 ]];
    then
        echo "Go Instalado correctamente"
    else
        echo "Error al instalar Go"
    fi

    #INSTALLING NVM AND NODE
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm install node || echo "No se instalo Node"

    #INSTALLING RVM AND RUBY
    echo "Installing RVM and Ruby"
    curl -sSL https://get.rvm.io | bash -s stable --ruby
    rvm install 2.7

    #installing KIBANA AND ELASTIC SEARCH
    echo "Installing Kibana Full"
    brew tap elastic/tap
    brew install elastic/tap/kibana-full

    ##
    echo "Installing Elastic Search"
    brew install elastic/tap/elasticsearch-full

    ##installing redis
    echo "Installing REDIS"
    brew install redis

    echo "Downloads VirtualBox"
    curl -o vbox.dmg  https://download.virtualbox.org/virtualbox/6.1.16/VirtualBox-6.1.16-140961-OSX.dmg
    
    echo "Installing Discord, Zoom, Github"
    brew install --cask zoom github discord
}

Compliance_Check ()
{
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
    nvm = $(command -v nvm install node)
    $nvm >/dev/null 2>&1
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
        printf "${RED}Kibana no esta instalado ${NC}\n"
    else
        printf "${GR}Kibana esta Instalado ${NC}\n"
    fi
}
### Funcion menu
Menu ()
{
    echo ""
	echo "  1) Instalar todo el ambiente"
	echo "  2) Instalar SDKMAN"
	echo "  3) Instalar Homebrew"
	echo "  4) Instalar Python3"
	echo "  5) Instalar Furycli"
    echo "  6) Check BootcampIT"
	echo "  7) Instalar Extras Bootcamp IT"
    echo "  8) Salir"
	echo ""
	echo "Indica una opcion:  "
}

### Menu Principal
opc=0
until [ $opc -eq 8 ]
do
    case $opc in
        1)  
            Install_SDKMAN
            Dev_Tools
            Install_Homebrew
            Install_Python3
            Install_FuryCLI
            Install_ITAcc
            Compliance_Check
            Menu
            ;;
        2)  
            Install_SDKMAN
            Menu
            ;;
        3)
            Install_Homebrew
            Menu
            ;;
        4)  
            Install_Python3
            Menu
            ;;
        5)
            Install_FuryCLI
            Menu
            ;;
        6) 
            Compliance_Check
            Menu
            ;;
        7) Install_ITAcc
           Compliance_Check
           Menu
            ;;
        *)
            Menu
            ;;
    esac
    read opc
done

#EOF