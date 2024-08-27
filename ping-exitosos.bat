@echo off
setlocal enabledelayedexpansion

rem Nombre del archivo de entrada
set input_file=output-ping.txt
rem Nombre del archivo de salida
set output_file=resultado.txt

rem Borrar el archivo de salida si existe
if exist "%output_file%" del "%output_file%"

rem Leer el archivo línea por línea
for /f "tokens=* delims=" %%a in (%input_file%) do (
    set "line=%%a"

    rem Buscar líneas que contienen la IP y el TTL
    echo !line! | findstr /r /c:"Haciendo ping a [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" >nul
    if !errorlevel! equ 0 (
        set "ip=!line:~16,15!"
    )

    echo !line! | findstr /r /c:"TTL=[0-9]*" >nul
    if !errorlevel! equ 0 (
        set "ttl=!line:~-3,3!"
        echo !ip! !ttl! >> %output_file%
    )
)

echo Proceso completado. Resultados guardados en %output_file%
endlocal
