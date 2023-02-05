#!/bin/bash

if [ -d "src" ]; then
    echo "The 'src' directory already exists."
    echo "Do you wish to continue (y/n)?"
    read answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
        echo "Continuing with installation."
    else
        echo "Aborting installation."
        exit 1
    fi
else
    mkdir src
fi

echo "This script will install Blesta 5.6.1"
echo "Do you wish to continue (y/n)?"
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "Downloading Blesta"
    curl -LJ https://account.blesta.com/client/plugin/download_manager/client_main/download/223/blesta-5.6.1.zip -o ./src/blesta.zip
else
    echo "Aborting installation."
    exit 1
fi

echo "Extracting Blesta"
unzip src/blesta.zip -d src/

echo "Applying hotfix files"
cp -r src/hotfix-php8/app/* src/blesta/app/

echo "Applying file permissions"
chmod -R o+w src/blesta/config/
chmod -R o+w src/blesta/cache/

echo -e "\033[42;37m DOWNLOAD COMPLETE \033[0m"
echo "Please run the following command to continue: chmod +x ./configure.sh && ./configure.sh"