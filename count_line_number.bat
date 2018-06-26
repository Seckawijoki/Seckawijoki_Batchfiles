@echo off
setlocal EnableDelayedExpansion
set FILE=count_line_number.bat
set "cmd=findstr /R /N "^^" %FILE% | find /C ":""
for /f %%a in ('!cmd!') do set number=%%a
echo %number%