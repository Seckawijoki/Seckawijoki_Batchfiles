@echo off

REM The errorlevel increasing from left to right
choice /c:dme /m defrag,mem,end

echo errorlevel = %errorlevel%
echo.
if errorlevel 3 echo end
if errorlevel 2 echo mem
if errorlevel 1 echo defrag