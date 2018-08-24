@echo off
dir ..\Backup_automatic_build /s /b /ad | sort /r

for /f "delims=" %%i in ('dir . ..\Backup_automatic_build /s /b /ad') do (
    rd "%%i"
)