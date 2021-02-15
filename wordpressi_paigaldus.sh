# Wordpressi installi skript
# Kontrollime wordpressi olemasolu
WP=$(grep wp_version /var/www/html/wordpress/wp-includes/version.php | grep -c '*.*.*')
# Wordpressi puudumise korral installime selle
if [ $WP -eq 0 ]; then
	mysql --user="root" --password="qwerty" --execute="CREATE DATABASE wpdatabase; create user wpuser@localhost identified by 'wppass'; grant all privileges on wpdatabase.* to wpuser@localhost; flush privileges;"
	service apache2 restart
	service mysql restart
	apt install unzip
	wget -c http://wordpress.org/latest.zip
	unzip -q latest.zip -d /var/www/html
	rm -R latest.zip
	chown -R www-data.www-data /var/www/html/wordpress
	chmod -R 755 /var/www/html/wordpress
	mkdir -p /var/www/html/wordpress/wpcontent/uploads
	chown -R www-data.www-data /var/www/html/wordpress/wpcontent/uploads
	cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
	sed -i "s/database_name_here/wpdatabase/g" /var/www/html/wordpress/wp-config.php
	sed -i "s/username_here/wpuser/g" /var/www/html/wordpress/wp-config.php
	sed -i "s/password_here/wppass/g" /var/www/html/wordpress/wp-config.php
	echo "Wordpress on paigaldatud"
# Wordpressi olemasolu korral väljastame sõnumi mis ütleb, et see on juba olemas
elif [ $WP -eq 1 ]; then
	echo "Wordpress on juba paigaldatud"
fi
# Skripti lõpp
