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
