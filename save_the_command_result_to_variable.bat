@echo off
rem 查找ip地址举例
set "MYIP="
for /f "delims=" %%i in ('ipconfig /all^| find /i "ipv4"') do (
  ::echo %%i
  set "MYIP=%MYIP%%%i"
)
echo %MYIP%