@echo off
 setlocal EnableDelayedExpansion

 set "AEGIS_ENABLED=false"

 REM Check if any arguments were provided
 if "%~1" neq "" (
     :parse_args
     if "%~1"=="" goto after_args
     if "%~1"=="--aegis-enabled" (
         set "AEGIS_ENABLED=true"
     ) else (
         echo Unknown argument: %~1
     )
     shift
     goto parse_args
 )

 :after_args

 if "%AEGIS_ENABLED%"=="true" (
     REM Insert the script snippet into index.html
     echo AEGIS is enabled, inserting script snippet into index.html
     set "AEGIS_SCRIPT="
     for /f "delims=" %%i in (web\aegis-script.html) do set "AEGIS_SCRIPT=!AEGIS_SCRIPT!%%i"
 ) else (
     set "AEGIS_SCRIPT="
 )

 set "FLUTTER_BASE_HREF=$FLUTTER_BASE_HREF"

 REM Use powershell to perform the equivalent of envsubst
 powershell -Command "Get-Content web\template.html | ForEach-Object { $_ -replace '\$FLUTTER_BASE_HREF', [System.Environment]::GetEnvironmentVariable('FLUTTER_BASE_HREF') } | Set-Content web\index.html"

 exit /b 0
