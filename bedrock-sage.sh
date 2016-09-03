#!/bin/bash
composer=/usr/local/bin/composer.phar
bold=$(tput bold)
normal=$(tput sgr0)

printf "\n${bold}Setup Bedrock & Sage9${normal}\n"

#
# Config
#
printf "\n${bold}── Config ── \n${normal}"
read -p "${bold}Project Name${normal} (default: project, rules: no spaces): " project
read -p "${bold}DB Username${normal} (default: root): " db_username
read -p "${bold}DB Password${normal} (default: null): " db_password
read -p "${bold}DB Host${normal} (default: localhost): " db_host
read -p "${bold}WP Username${normal} (default: admin): " wp_username
read -p "${bold}WP Password${normal} (default: admin): " wp_password
read -p "${bold}WP Email${normal} (default: wordpress@project.dev): " wp_email

# If variable/s not set, use defaults
project=${project:=project}
db_username=${db_username:=root}
db_password=${db_password:=}
db_host=${db_host:=localhost}
db_name=$project
wp_home=$project.dev #change .dev to .localhost or whatever you're using
wp_username=${wp_username:=admin}
wp_password=${wp_password:=admin}
wp_email=${wp_host:=wordpress@project.dev}
current_path=$(pwd)

# Check if directory exists
while [ -d "$(pwd)/$project" ]; do
	printf "\n${bold}ERROR: ${normal}$(pwd)/$project) already exists.\n"
  read -p "${bold}Please use another project name: ${normal}" project
done

#
# Setup Bedrock
#
printf "\n${bold}── Bedrock ── \n${normal}"
$composer create-project roots/bedrock $project
cd "$(pwd)/$project"

# Setup Env
printf "\n${bold}Setup Env File:\n${normal}"
wp dotenv init
printf "DB_NAME=$db_name\nDB_USER=$db_username\nDB_PASSWORD=$db_password\nDB_HOST=$db_host\nWP_ENV=development\nWP_HOME=http://$wp_home\nWP_SITEURL=http://$wp_home/wp" | tee ".env"
printf "\n"
wp dotenv salts generate

# Create DB
printf "\n${bold}Create Database:\n${normal}"
wp db create

# Run WordPress Install
printf "\n${bold}Run WordPress Install:\n${normal}"
wp core install --title=$project --admin_user=$wp_username --admin_password=$wp_password --admin_email=$wp_email --url=$wp_home

# Setup WordPress Options
printf "\n${bold}Update Defaults:\n${normal}"
wp option update blogdescription ''
wp option update start_of_week 0
wp option update timezone_string 'Africa/Johannesburg'
wp option update permalink_structure '/%postname%'
wp rewrite flush

# Remove WordPress Default Posts
printf "\n${bold}Remove Default Posts:\n${normal}"
wp post delete 1 --force
wp post delete 2 --force

# Remove WordPress Default Themes
printf "\n${bold}Remove Default Themes:\n${normal}"
wp theme delete "twentyten"
wp theme delete "twentyeleven"
wp theme delete "twentytwelve"
wp theme delete "twentythirteen"
wp theme delete "twentyfourteen"

# Create Homepage
printf "\n${bold}Create Homepage:\n${normal}"
wp post create --post_type=page --post_status=publish --post_title="Home"
wp option update show_on_front 'page'

# Install Plugins
printf "\n${bold}Install Plugins:\n${normal}"
$composer require wpackagist-plugin/disable-comments
wp plugin activate disable-comments

#
# Setup Sage
#
printf "\n${bold}── Sage9 ── \n${normal}"
$composer create-project roots/sage web/app/themes/$project 9.0.0-alpha.1
cd "$(pwd)/web/app/themes/$project"
replace "bedrock" "$project" -- assets/config.json
git init
git add .
git commit -m "Init"

printf "Run NPM Install:\n"
npm install

printf "Run NPM Build:\n"
npm run build

printf "Activate Sage:\n"
wp theme activate $name

printf "Open Atom\n"
atom .
