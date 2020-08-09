@echo off
title admin
cls


set "mysql_folder="
for /F "skip=6 delims=" %%i in (settings.txt) do if not defined mysql_folder set "mysql_folder=%%i"

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
if %OS%==32BIT set osbit=x86
if %OS%==64BIT set osbit=x64

echo [1] copy mysql password.
echo [2] alter user 'root'@'localhost' identified by '*your new password*'; 
echo.
echo.
rem server\windows\%osbit%\%mysql_folder%\bin\mysqld.exe --console --datadir=%cd%\server\db

%cd%\server\windows\%osbit%\%mysql_folder%\bin\mysql.exe -u root -p


pause