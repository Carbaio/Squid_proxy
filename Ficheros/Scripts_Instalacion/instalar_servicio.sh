#!/bin/sh  
clear
ejecutar=0 # Entramos en el menu
while [ ${ejecutar} -eq 0 ]
do
	echo "Seleccione una opcion:"
	echo "1) Instalacion Squid"
	echo "2) Desinstalacion Squid"
 	echo "3) Ver fichero de configuracion"
	echo "4) Generar ficheros log y cache"
	echo "5) Iniciar servicio"
	echo "6) Reiniciar servicio"
	echo "7) Parar servicio"
	echo "q) Salir"
	echo
	read -p "Opcion seleccionada: " opcion
	case ${opcion} in
	
	1)
		clear
		echo "Instalando Squid-proxy..."
		groupadd -g 13 squid
		useradd -g squid -u 13 -d /var/spool/squid -M -s /usr/sbin/nologin squid
		mkdir /opt/squid
		cd /opt/squid
		wget http://www.squid-cache.org/Versions/v3/3.5/squid-3.5.28.tar.gz
		tar xvzf squid-3.5.28.tar.gz
		cd squid-3.5.28
		./configure --prefix=/usr/local/squid --sysconfdir=/etc/squid --with-logdir=/var/log/squid --with-pidfile=/var/run/squid.pid --enable-storeio=ufs,aufs --enable-auth --enable-removalpolicies=lru,heap --enable-useragent-log --enable-refererlog --bindir=/usr/sbin
		make 
		make install 
		mkdir /var/spool/squid
		mkdir /var/log/squid
		mkdir /var/cache/squid 
		chown squid:squid /var/spool/squid/
		chown squid:squid /var/log/squid/
		chown squid:squid /var/cache/squid/
		echo "Instalacion completada con exito"
		echo "Añadiendo al sistema de arranque Systemd..."
		cp /opt/squid/squid-3.5.28/tools/systemd/squid.service /lib/systemd/system
		cp /usr/local/squid/sbin/squid /usr/sbin
		systemctl daemon-reload
		echo "Proceso finalizado con exito"
		;;
	2)
		clear
		echo "Desinstalando Squid-proxy..."
		cd /opt/squid/squid-3.5.28
		make uninstall
		cd 
		rm -rf /opt/squid/
		rm -rf /usr/local/squid
		rm -rf /etc/squid
		rm -rf /var/spool/squid/
		rm -rf /var/log/squid/
		rm -rf /var/cache/squid/
		rm /lib/systemd/system/squid.service
		rm /usr/sbin/squid
		echo "Desinstalacion completada con exito"
		;;
	3)
		clear
		nano /etc/squid/squid.conf
		;;
	4)	
		clear
		cp ../Ficheros_Configuracion/squid1.conf /etc/squid/squid.conf
		echo "Creando ficheros log..."
		touch /var/log/squid/squid.log
		touch /var/log/squid/access.log
		touch /var/log/squid/store.log
		chown squid:squid /var/log/squid/access.log 
		chown squid:squid /var/log/squid/store.log 
		chown squid:squid /var/log/squid/squid.log
		echo "Generando swap directories (cache)..."
		squid -z
		;;

	5)	clear
		systemctl start squid;
		systemctl status squid;
		;;


	6)	clear
		systemctl restart squid;
		systemctl status squid;
		;;

	7)	clear
		systemctl stop squid;
		systemctl status squid;
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
