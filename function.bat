@echo off
echo. going to execute myDosFunc with different arguments  
call :myDosFunc 100 YeePEE  
call :myDosFunc 100 "for me"  
call :myDosFunc 100,"for me"  
call :myDosFunc 100,for me  
echo. 
goto :eof  
::--------------------------------------------------------  
::-- Function section starts below here  
::--------------------------------------------------------  
:myDosFunc   
:: here starts myDosFunc identified by it`s label  
if "%~1" equ "" goto end
echo.  
echo. here the myDosFunc function is executing a group of commands  
echo. it could do %~1 of things %~2.  
goto :eof  

:end