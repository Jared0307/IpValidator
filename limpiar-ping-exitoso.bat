@echo off
setlocal enabledelayedexpansion

set "input_file=resultado.txt"
set "output_file=ip-ttl-clean.txt"

if exist "%output_file%" del "%output_file%"

:: Process the input file and output the cleaned data
for /f "usebackq tokens=1,* delims= " %%a in ("%input_file%") do (
    set "ip=%%a"
    set "rest=%%b"
    
    :: Initialize TTL variable
    set "ttl="
    
    :: Check if the rest contains '=' and process TTL
    if not "!rest!"=="" (
        :: Handle TTL with '=' prefix
        for /f "tokens=1,* delims==" %%c in ("!rest!") do (
            set "ttl=%%d"
        )
        
        :: If TTL is empty, check for 'con' or 'co'
        if "!ttl!"=="" (
            :: Check if the rest contains 'con' or 'co'
            if "!rest:con =!" neq "!rest!" (
                for /f "tokens=2 delims= " %%e in ("!rest!") do (
                    set "ttl=%%e"
                )
            ) else if "!rest:co =!" neq "!rest!" (
                for /f "tokens=2 delims= " %%e in ("!rest!") do (
                    set "ttl=%%e"
                )
            ) else (
                :: Handle cases where TTL is directly after IP with or without spaces
                for /f "tokens=2 delims= " %%e in ("!rest!") do (
                    set "ttl=%%e"
                )
            )
        )
    ) else (
        set "ttl=No TTL"
    )
    
    :: Ensure TTL is properly trimmed and formatted
    set "ttl=!ttl: =!"
    
    set "line=!ip!=!ttl!"

    :: Check if the line with IP and TTL is already in the output file
    set "found="
    for /f "delims=" %%i in ("%output_file%") do (
        if "!line!"=="%%i" set "found=1"
    )

    if not defined found (
        echo !line! >> "%output_file%"
    )
)

echo Processing complete. Output written to %output_file%.
