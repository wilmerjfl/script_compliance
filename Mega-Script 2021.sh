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
    pip3 install --user -i http://pypi.ml.com/simple/ furycli --trusted-host pypi.ml.com --upgrade --no-warn-script-location && \
    
    echo '#Added by furycli:' >> ~/.zshrc
    echo "export PATH=\"/Users/$USER/Library/Python/3.7/bin:\$PATH\"" >> ~/.zshrc
    ln -s /Users/$USER/Library/Python/3.7/bin/fury /usr/local/bin

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
    brew install --cask java11
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

    nvm install node
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
	echo "  6) Salir"
	echo ""
	echo "Indica una opcion:  "
}

### Menu Principal
opc=0
until [ $opc -eq 6 ]
do
    case $opc in
        1)  
            Install_SDKMAN
            Dev_Tools
            Install_Homebrew
            Install_Python3
            Install_FuryCLI
            Install_ITAcc
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
        *)
            Menu
            ;;
    esac
    read opc
done

#EOF