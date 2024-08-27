@echo off
echo Ejecutando generar-lista.bat...
echo En base a tus necesidades elige los octetos que tendrias de base para que se genere una lista con los octetos faltantes.
call generar-lista.bat

echo Ejecutando ping-all-ips.bat...
echo Este proceso puede tardar debido a que va a hacer 2 ping a las direcciones generadas anteriormente.
call  ping-all-ips.bat

echo Ejecutando ping-exitosos.bat...
echo Filtra los pings que fueron exitosos y los guarda junto con su ttl.
call ping-exitosos.bat

echo Ejecutando limpiar-ping-exitoso.bat...
echo Limpia los pings exitosos ya que el primer archivo puede repetir datos y organiza de mejor manera las ips que se encuentran en la red.
call limpiar-ping-exitoso.bat

echo Tu archivo ip-ttl-clean.txt contiene los datos relevantes de tu red.
echo Todos los scripts han sido ejecutados.
pause
