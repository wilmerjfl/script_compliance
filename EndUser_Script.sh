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
    sdk install java 8.0.275-zulu & \

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
    brew update
    brew install python@3.8

}

### Instalar FuryCLI
Install_FuryCLI ()
{
    pip3 install --user -i http://pypi.ml.com/simple/ furycli --trusted-host pypi.ml.com --upgrade --no-warn-script-location && \
    
    echo '#Added by furycli:' >> ~/.zshrc
    echo "export PATH=\"/Users/$USER/Library/Python/3.8/bin:\$PATH\"" >> ~/.zshrc
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