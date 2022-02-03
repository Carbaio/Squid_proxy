#!/bin/sh  
clear
ejecutar=0 # Entramos en el menu
while [ ${ejecutar} -eq 0 ]
do
	echo "Seleccione una opcion:"
	echo "1) Escenario 1"
	echo "2) Escenario 2 - server1"
	echo "3) Escenario 2 - server2"
	echo "4) Reiniciar Apache"
	echo "5) Iniciar Apache"
	echo "q) Salir"
	echo
	read -p "Opcion seleccionada: " opcion
	case ${opcion} in
	
	1)
		clear
		ifdown eth1
		echo "Generando configuracion para Escenario 1"
		cp ../Otros/squid-httpd.conf /etc/httpd/conf.d/
		tar xfvz ../Otros/apache1.tar.gz 
		mv -f squid1/ /var/www/
		echo "Reiniciando apache..."
		service httpd restart
		cp -f ../Otros/eth1-apache /etc/sysconfig/network-scripts/ifcfg-eth1
		ifdown eth0
		ifup eth1
		;;

	2)
		clear
		cp ../Otros/index-server1.html /var/www/html/index.html
		;;

	3)
		clear
		cp ../Otros/index-server2.html /var/www/html/index.html
		;;


	4)
		clear
		echo "Reiniciando Apache"
		service httpd restart
		;;
	5)
		clear
		echo "Iniciando Apache"
		service httpd start
		;;
	q)
		ejecutar=1
		;;
	*)
		ejecutar=0
		clear
		echo
		echo -e "Opcion no valida"
		echo
		;;
		esac
done
