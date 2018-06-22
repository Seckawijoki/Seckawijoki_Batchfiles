@echo off
rem 查找ip地址举例
set n=0
for /f "delims=" %%i in ('dir /a-d /b *.*') do (
 echo %%i:  Size = %%~zi Bytes
 set /a n+=%%~zi
)
echo/
echo Total size = %n% Bytes