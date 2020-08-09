@echo off
Setlocal EnableDelayedExpansion
title configuration
cls
set mypath=%cd%


set "mysql_folder="
for /F "skip=6 delims=" %%i in (settings.txt) do if not defined mysql_folder set "mysql_folder=%%i"

set "mysql_db="
for /F "skip=7 delims=" %%i in (settings.txt) do if not defined mysql_db set "mysql_db=%%i"

if not exist "server\%mysql_db%\" mkdir server\%mysql_db%

rem set "mysql_folder=mysql8021"

set mypath_left=%mypath%
set mypath_right=%mypath:\=/%
rem echo %mypath:~0,1%

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
if %OS%==32BIT set osbit=x86
if %OS%==64BIT set osbit=x64


rem mysqld --console --initialize --basedir=%cd%\server\windows\%osbit%\%mysql_folder% --datadir=%cd%\server\db

setx path "%path%;%cd%\server\windows\%osbit%\%mysql_folder%\bin;"

%cd%\server\windows\%osbit%\%mysql_folder%\bin\mysqld.exe --console --initialize --basedir=%cd%\server\windows\%osbit%\%mysql_folder% --datadir=%cd%\server\%mysql_db%
echo configuration done.
start mysql_admin.bat
%cd%\server\windows\%osbit%\%mysql_folder%\bin\mysqld.exe --console --datadir=%cd%\server\%mysql_db%

rem echo [1] copy mysql password.
rem echo [2] alter user 'root'@'localhost' identified by '*your new password*'; 

rem server\windows\%osbit%\%mysql_folder%\bin\mysqld.exe --console --datadir=%cd%\server\db

rem mysql.exe -u root -p




rem alter user 'root'@'localhost' identified by 'root';
rem mysqladmin -u root -p shutdown

pause

exit