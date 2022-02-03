#!/bin/sh  
clear
ejecutar=0 # Entramos en el menu
while [ ${ejecutar} -eq 0 ]
do
	echo "Seleccione una opcion:"
	echo "1) Generar ficheros log y cache"
	echo "2) Escenario 1"
 	echo "3) Ver logs squid.conf"
	echo "4) Ver logs store.log"
	echo "5) Ver logs access.log"
	echo "6) Iniciar servicio"
	echo "7) Reiniciar servicio"
	echo "8) Parar servicio"
	echo "9) Escenario 2"
	echo "10) Escenario 3"
	echo "q) Salir"
	echo
	read -p "Opcion seleccionada: " opcion
	case ${opcion} in
	
	1)
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

	2)
		clear
		cp -f ../Otros/dhcpd.conf /etc/dhcp/
		echo "Configurando interfaces..."
		cp -f ../Otros/eth1-proxy /etc/sysconfig/network-scripts/ifcfg-eth1
		cp ../Otros/hosts1 /etc/hosts
		#Antes que Apache
		ifup eth1
		service dhcpd start
		ip a
		;;	

	3)
		clear
		cat /var/log/squid/squid.log
		;;
	4)
		clear
		cat /var/log/squid/store.log
  		;;

	5)
		clear
		cat /var/log/squid/access.log
  		;;

	6)	
		clear
		systemctl start squid;
		systemctl status squid;
		;;


	7)	clear
		systemctl restart squid;
		systemctl status squid;
		;;

	8)	clear
		systemctl stop squid;
		systemctl status squid;
		;;

	9)	#Es necesario el cambio de hosts en cliente
		clear
		echo "Montando escenario 2..."
		cp ../Ficheros_Configuracion/squid2.conf /etc/squid/squid.conf
		systemctl restart squid
		cp ../Otros/hosts2 /etc/hosts
		;;

	10)	
		clear
		echo "Montando proxy modo transparente con iptables..."
		service httpd stop
		echo 1 > /proc/sys/net/ipv4/ip_forward
		service iptables start
		iptables -t nat -A PREROUTING -p tcp -s 192.168.1.0/29 --dport 80 -j REDIRECT --to-port 3128
  		iptables -t nat -A PREROUTING -p tcp -s 192.168.1.0/29 --dport 443 -j REDIRECT --to-port 3128
		iptables -t nat -A POSTROUTING -s 192.168.1.0/29 -d 0.0.0.0/0 -o eth0 -j MASQUERADE
		cp ../Ficheros_Configuracion/squid3.conf /etc/squid/squid.conf
		systemctl restart squid
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
