#!/bin/sh

which docker > /dev/null
if [ $? -eq 1 ]; then
    echo docker not found
    echo try to install docker
    sleep 1

    curl -sSL get.docker.com | sh
    sudo usermod -aG docker $USER

    which docker > /dev/null
    if [ $? -eq 1 ]; then
        echo "\e[31mERROR : fail to install 'docker'\e[0m"
    fi
fi

which docker-compose > /dev/null
if [ $? -eq 1 ] ; then
    echo docker-compose not found
    echo try to install docker-compose
    sleep 1

    sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose 2> /dev/null
    
    which docker-compose > /dev/null
    if [ $? -eq 1 ]; then
        echo "\e[31mERROR : fail to install 'docker-compose'\e[0m"
    fi
fi

which make > /dev/null
if [ $? -eq 1 ]; then 
    echo command not found : make
    echo try to install make

    which apt-get > /dev/null
    if [ $? -eq 0 ]; then
        sudo apt-get install make
    else
        which apk > /dev/null
        if [ $? -eq 0 ]; then
            apk add make
        fi
    fi
    
    which make > /dev/null
    if [ $? -eq 1 ]; then
        echo "\e[31mERROR : fail to install 'docker-compose'\e[0m"
    fi
fi