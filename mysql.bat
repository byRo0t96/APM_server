@echo off
Setlocal EnableDelayedExpansion
title mysql
cls
set mypath=%cd%

set "mysql_folder="
for /F "skip=6 delims=" %%i in (settings.txt) do if not defined mysql_folder set "mysql_folder=%%i"

set "mysql_db="
for /F "skip=7 delims=" %%i in (settings.txt) do if not defined mysql_db set "mysql_db=%%i"

rem set "mysql_folder=mysql8021"
rem 9Tlpy5(sQEoN

set mypath_left=%mypath%
set mypath_right=%mypath:\=/%
rem echo %mypath:~0,1%

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
if %OS%==32BIT set osbit=x86
if %OS%==64BIT set osbit=x64


setx path "%path%;%cd%\server\windows\%osbit%\%mysql_folder%\bin;"
%cd%\server\windows\%osbit%\%mysql_folder%\bin\mysqld.exe --console --datadir=%cd%\server\%mysql_db%

pause

exit