::The bat can treat characters like '=', ';' or ',' as word separators. 
::These characters have the same effect as the space character.
@echo off & setlocal
set s=AAA BBB CCC DDD EEE FFF
call :sub1 %s%
exit /b
:sub1
if "%1"=="" exit /b
echo %1
:: Use shift command to change to the next element.
shift
goto :sub1