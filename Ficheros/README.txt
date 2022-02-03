INSTALACIÓN - Script instalar_servicio.sh
Ejecutar en el equipo que se quiera instalar Squid.

En el directorio de /Scripts_Instalacion
$ chmod 704 instalar_servicio.sh
$ ./instalar_servicio.sh (hace falta root)

OPCIONES
	1) Instala el servicio Squid (código fuente)
	2) Desinstala el servicio Squid (código fuente)
	3) Editar el fichero de configuración de Squid /etc/squid/squid.conf
	4) Generación de ficheros log y cache (Necesario para que el servicio corra)
	5,6,7) Iniciar, reiniciar y parar servicio con Systemd


Script proxy_squid.sh 

Para ejecutar en el equipo donde está squid instalado.

	1) Misma opción que 4) anterior, por si no se ejecuta en ese script.
	2) Configurar para ESCENARIO 1
	9) Configurar para ESCENARIO 2
	10) Configurar para ESCENARIO 3

	3,4,5) Ver ficheros log
	5,6,7) Iniciar, reiniciar y parar servicio con Systemd


Script servidor_apache.sh

	1) Configurar para ESCENARIO 1
	2) Configurar para ESCENARIO 2
	3) Configurar para ESCENARIO 2 (para otro servidor, en nuestro caso del laboratorio esto deberia ejecutarse en el equipo que implementa squid)
	4,5) Reiniciar apache
	 
q) Para salir de cualquier script

(*) Para cada escenario que se quiera ejecutar, tener en cuenta que hay que ejecutar la parte del servidor apache y la de squid. No tiene mayor complicación para las opciones.

(*)Ejecutar los script dentro del mismo directorio donde se ubican.