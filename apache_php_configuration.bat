@echo off
Setlocal EnableDelayedExpansion
title configuration
cls

set "www="
for /F "skip=1 delims=" %%i in (settings.txt) do if not defined www set "www=%%i"

set "apache_folder="
for /F "skip=2 delims=" %%i in (settings.txt) do if not defined apache_folder set "apache_folder=%%i"

set "php_folder="
for /F "skip=3 delims=" %%i in (settings.txt) do if not defined php_folder set "php_folder=%%i"

set "php_version="
for /F "skip=4 delims=" %%i in (settings.txt) do if not defined php_version set "php_version=%%i"

set "dll_file="
for /F "skip=5 delims=" %%i in (settings.txt) do if not defined dll_file set "dll_file=%%i"


rem set "www=www"
rem set "apache_folder=Apache24"
rem set "php_folder=php748"
rem set "php_version=7.4.8"
rem set "dll_file=php7apache2_4.dll"

set mypath=%cd%
set mypath_left=%mypath%
set mypath_right=%mypath:\=/%
rem echo %mypath:~0,1%

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
if %OS%==32BIT set osbit=x86
if %OS%==64BIT set osbit=x64


set httpd_patch=server\windows\%osbit%\%apache_folder%\conf\httpd.conf
set php_patch=server\windows\%osbit%\%php_folder%\php.ini
rem set httpd_patch=%osbit%\httpd.conf
set "sc= <"
set "ec=> "

set "scs=%sc%"
set "ece=%ec%"



rem
echo #> %httpd_patch%

FOR /F "usebackq delims=" %%a in (`"findstr /n ^^ server\configuration\httpd_1.txt"`) do (
    set "var=%%a"
    SETLOCAL EnableDelayedExpansion
    set "var=!var:*:=!"
    echo(!var!>> %httpd_patch%
    ENDLOCAL
)

echo Define SRVROOT "%mypath_right%/server/windows/%osbit%/%apache_folder%">> %httpd_patch%
echo ServerRoot "%mypath_right%/server/windows/%osbit%/%apache_folder%">> %httpd_patch%

FOR /F "usebackq delims=" %%a in (`"findstr /n ^^ server\configuration\httpd_2.txt"`) do (
    set "var=%%a"
    SETLOCAL EnableDelayedExpansion
    set "var=!var:*:=!"
    echo(!var!>> %httpd_patch%
    ENDLOCAL
)

echo DocumentRoot "%mypath_right%/%www%">> %httpd_patch%
echo !scs!Directory "%mypath_right%/%www%"!ece!>> %httpd_patch%

FOR /F "usebackq delims=" %%a in (`"findstr /n ^^ server\configuration\httpd_3.txt"`) do (
    set "var=%%a"
    SETLOCAL EnableDelayedExpansion
    set "var=!var:*:=!"
    echo(!var!>> %httpd_patch%
    ENDLOCAL
)

echo # PHP7.4.8 module>> %httpd_patch%
echo LoadModule php%php_version:~0,1%_module "%mypath_right%/server/windows/%osbit%/%php_folder%/%dll_file%">> %httpd_patch%
echo AddType application/x-httpd-php .php>> %httpd_patch%
echo PHPIniDir "%mypath_right%/server/windows/%osbit%/%php_folder%">> %httpd_patch%

echo http has been configured.
rem

rem
echo ;> %php_patch%

FOR /F "usebackq delims=" %%a in (`"findstr /n ^^ server\configuration\php_1.txt"`) do (
    set "var=%%a"
    SETLOCAL EnableDelayedExpansion
    set "var=!var:*:=!"
    echo(!var!>> %php_patch%
    ENDLOCAL
)

echo extension_dir = "%mypath_left%\server\windows\x64\%php_folder%\ext">> %php_patch%

FOR /F "usebackq delims=" %%a in (`"findstr /n ^^ server\configuration\php_2.txt"`) do (
    set "var=%%a"
    SETLOCAL EnableDelayedExpansion
    set "var=!var:*:=!"
    echo(!var!>> %php_patch%
    ENDLOCAL
)

echo extension="%mypath_left%\server\windows\x64\%php_folder%\ext\mysqli">> %php_patch%
echo extension="%mypath_left%\server\windows\x64\%php_folder%\ext\mysqli.so">> %php_patch%
echo extension="%mypath_left%\server\windows\x64\%php_folder%\ext\mysqli.dll">> %php_patch%
echo extension="%mypath_left%\server\windows\x64\%php_folder%\ext\php_mysql.dll">> %php_patch%
echo extension="%mypath_left%\server\windows\x64\%php_folder%\ext\php_mysqli.dll">> %php_patch%
echo extension="%mypath_left%\server\windows\x64\%php_folder%\ext\php_pdo_mysql.dll">> %php_patch%

FOR /F "usebackq delims=" %%a in (`"findstr /n ^^ server\configuration\php_3.txt"`) do (
    set "var=%%a"
    SETLOCAL EnableDelayedExpansion
    set "var=!var:*:=!"
    echo(!var!>> %php_patch%
    ENDLOCAL
)
echo php has been configured.
echo.
echo configuration done.
start apache_php.bat
rem

rem echo %apache_folder%%osbit% Was running
rem %mypath:~0,1%:\server\windows\%osbit%\%apache_folder%\bin\httpd

rem pause
exit