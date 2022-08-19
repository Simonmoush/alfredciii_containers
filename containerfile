# syntax=docker/dockerfile:1
FROM wordpress:cli as populate_db

COPY ./data_snapshots/alfredciii-2022-08-17.xml /home/www-data/wp_data.xml

WORKDIR /var/www/html
wp core download

# this isn't working because can't connect to local server thru /run/mysqld/mysqld.sock
wp config create --dbname=exampledb --dbuser=exampleuser # maybe don't hard code these

#make a user

COPY ./alfredciii_wp_theme /var/www/html/wp-content/themes/alfredciii_wp_theme

wp theme activate alfredciii_wp_theme

wp plugin install wordpress-importer --activate

wp import /home/www-data/wp_data.xml --authors=create #mak
