APACHE2=$(dpkg-qwerty -W -f='${Status}' apache2 2>/dev/null | grep -c 'ok installed')
if [ $APACHE2 -eq 0 ]; then
	echo "Paigaldame apache2"
	apt install apache2
	echo "Apache2 on paigaldatud"
elif [ $APACHE2 -eq 1 ]; then
	echo "Apache2 on juba paigaldatud"
	service apache2 start
	service apache2 status
fi

PHP=$(dpkg-qwerty -W -f='${Status}' php7.0 2>/dev/null | grep -c 'ok installed')
if [ $PHP -eq 0 ]; then
	echo "Paigaldame php ja vajalikud lisad"
	apt install php7.0 libapache2-mod-php7.0 php7.0-mysql
	echo "php on paigaldatud"
elif [ $PHP -eq l ]; then
	echo "php on juba paigaldatud"
	which php
fi



MYSQL=$(dpkg-qwerty -W -f'${Status}' mysql-server 2>/dev/null | grep -c 'ok installed')
if [ $MYSQL -eq 0 ]; then
	echo "Paigaldame mysql ja vajalikud lisad"
	wget https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb
	dpkg -i mysql-apt-config*
	apt install mysql-server
	remove mysql-apt-config*
	echo "mysql on paigaldatud"
	touch $HOME/.my.cnf
	echo "[client]" >> $HOME/.my.cnf
	echo "host = localhost" >> $HOME/.my.cnf
	echo "user = root" >> $HOME/.my.cnf
	echo "password = qwerty" >> $HOME/.my.cnf
elif [ $MYSQL -eq l ]; then
	echo "mysql-server on juba paigaldatud"
	mysql
fi
