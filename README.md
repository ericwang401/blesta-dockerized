# Blesta Dockerized

## Getting Started

Run `chmod +x ./download.sh && ./download.sh` and follow the steps.
Then run `chmod +x ./configure.sh && ./configure.sh` and follow the steps.


Remember! The `DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD`, and `DB_ROOT_PASSWORD` can only be set once in your environment file. If you ever want to change your credentials, you need to use the MySQL CLI. You can access MySQL CLI by entering the shell of the MySQL container `docker compose exec database sh`.

## Making configurations

If you ever need to modify the PHP configuration, the .env file, or any of the dockerfiles, make sure to run `docker compose build && docker compose up -d` afterwards. This makes sure that Blesta is running on the latest changes you made.
