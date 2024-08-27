@echo off
setlocal enabledelayedexpansion

set "output_file=rango-ip.txt"
if exist "%output_file%" del "%output_file%"

:: Solicitar el número de octetos
echo Enter the number of octets (1-3):
set /p octets=
echo Number of octets: !octets!
echo Enter the octets (e.g., 192.x.x.x) (1)
echo Enter the octets (e.g., 192.168.x.x) (2)
echo Enter the octets (e.g., 192.168.10.x) (3)

:: Verificar y procesar según el número de octetos
if "!octets!"=="1" (
    echo Enter the base octet (e.g., 10)
    set /p base_octet=
    echo Base octet: !base_octet!
    for /l %%i in (1,1,254) do (
        echo !base_octet!.%%i >> "%output_file%"
    )
    goto :EOF
) else if "!octets!"=="2" (
    echo Enter the first two octets (e.g., 192.168)
    set /p base_octets=
    echo Base octets: !base_octets!
    for /l %%i in (0,1,255) do (
        for /l %%j in (1,1,254) do (
            echo !base_octets!.%%i.%%j >> "%output_file%"
        )
    )
    goto :EOF
) else if "!octets!"=="3" (
    echo Enter the first three octets (e.g., 192.168.10)
    set /p base_octets=
    echo Base octets: !base_octets!
    for /l %%i in (1,1,254) do (
        echo !base_octets!.%%i >> "%output_file%"
    )
    goto :EOF
) else (
    echo Invalid number of octets. Please enter a number between 1 and 3.
    goto :EOF
)

echo IP addresses have been written to %output_file%.
