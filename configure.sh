#!/bin/bash

if [ -f ".env" ]; then
    echo ".env file already exists."
    echo "Do you wish to continue (y/n)?"
    read answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
        echo "Continuing with installation."
    else
        echo "Aborting installation."
        exit 1
    fi
else
    echo "Creating .env file"
    touch .env
fi

echo "Enter APP_URL (e.g. https://example.com): "
read app_url

echo "Enter APP_ENV (local/production [production for auto-SSL and performance]): "
read app_env
while [ "$app_env" != "local" ] && [ "$app_env" != "production" ]; do
  echo "APP_ENV must be either local or production. Please try again: "
  read app_env
done

echo "Enter DB_DATABASE (make one up): "
read db_database

echo "Enter DB_USERNAME (make one up) (cannot be root): "
read db_username
while [ "$db_username" == "root" ]; do
  echo "DB_USERNAME cannot be root. Please try again: "
  read db_username
done

echo "Enter DB_PASSWORD (make one up): "
read db_password

echo "Enter DB_ROOT_PASSWORD (make one up): "
read db_root_password

echo "APP_URL='$app_url'" >> .env
echo "APP_ENV='$app_env'" >> .env
echo "DB_DATABASE='$db_database'" >> .env
echo "DB_USERNAME='$db_username'" >> .env
echo "DB_PASSWORD='$db_password'" >> .env
echo "DB_ROOT_PASSWORD='$db_root_password'" >> .env

echo "Starting docker containers"
docker compose build
docker compose up -d

echo "Waiting 15s for database to initialize"
sleep 15

echo "Running Blesta installation command"
docker compose exec php php ./blesta/index.php install -dbhost database -dbport 3306 -dbname "$db_database" -dbuser "$db_username" -dbpass "$db_password" -hostname "$app_url" -docroot /var/www

echo -e "\033[42;37m CONFIGURATION COMPLETE \033[0m"
echo "Register your Blesta installation by going to $app_url/admin/login/ in your browser"