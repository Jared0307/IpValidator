@echo off
setlocal enabledelayedexpansion

set "input=rango-ip.txt"
set output="output-ping.txt"

for /f "tokens=*" %%A in (%input%) do (
    echo Haciendo ping a %%A >> %output%
    ping %%A -n 2 -w 2000 >> %output%
    echo "---------------------------" >> %output%
    echo. >> %output%
)

endlocal
