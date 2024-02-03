#!/bin/sh

if [ -f "./Makefile" -o -f "docker-compose.yml" ] ; then
    echo "\e[33mFound 'Makefile' and 'docker-compose.yml' files.\e[0m"
    echo "\e[33mIf you want to reset the configuration and make a new server, remove these two files : 'Makefile' and 'docker-compose.yml'\e[0m"
    exit
fi

echo -n "Enter your server directory path (default: /opt/factorio) > "
read your_directory

echo -n "Enter name of save file (default: _autosave1.zip) > "
read your_savename

#echo -n "Enter your name > "
#read your_username

#echo -n "Enter your token (you can find at %appdata%/factorio/player-data.json in Windows) > "
#read your_token

if [ -z "$your_directory" ] ; then
    your_directory="/opt/factorio"
fi
if [ -z "$your_savename" ] ; then
    your_savename="_autosave1.zip"
fi

echo ""
echo "= INFO ="
echo "Factorio server directory : $your_directory"
echo "Savefile name : $your_savename"
#echo "Username : $your_username"
#echo "Token : $your_token"
echo ""
sleep 3

cp ./templates/template.docker-compose.yml ./docker-compose.yml
cp ./templates/template.Makefile ./Makefile

TARGET="./Makefile"
REPLACE_USERNAME="YOUR_USERNAME"
REPLACE_TOKEN="YOUR_TOKEN"
REPLACE_SAVE="YOUR_SAVENAME"
REPLACE_DIR="YOUR_FACTORIO_DIRECTORY"
# sed -i "s/$REPLACE_USERNAME/$your_username/g" "$TARGET"
# sed -i "s/$REPLACE_TOKEN/$your_token/g" "$TARGET"
sed -i "s/$REPLACE_SAVE/$your_savename/g" "$TARGET"
sed -i "s|$REPLACE_DIR|$your_directory|g" "$TARGET"

TARGET="./docker-compose.yml"
# sed -i "s/$REPLACE_USERNAME/$your_username/g" "$TARGET"
# sed -i "s/$REPLACE_TOKEN/$your_token/g" "$TARGET"
sed -i "s/$REPLACE_SAVE/$your_savename/g" "$TARGET"
sed -i "s|$REPLACE_DIR|$your_directory|g" "$TARGET"

echo "Work done"