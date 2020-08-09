@echo off
Setlocal EnableDelayedExpansion
title apache_php
cls
set mypath=%cd%

set "apache_folder="
for /F "skip=2 delims=" %%i in (settings.txt) do if not defined apache_folder set "apache_folder=%%i"

rem set "apache_folder=Apache24"


rem echo %mypath:~0,1%

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
if %OS%==32BIT set osbit=x86
if %OS%==64BIT set osbit=x64


echo %apache_folder%%osbit% Was running
%mypath%\server\windows\%osbit%\%apache_folder%\bin\httpd

pause
exit