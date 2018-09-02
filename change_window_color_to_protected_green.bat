@echo off

reg add "HKEY_CURRENT_USER\Control Panel\Colors" /ve /t REG_SZ /d "204 232 207" /f
reg add "HKEY_CURRENT_USER\Control Panel\Colors" /v HilightText /t REG_SZ /d "204 232 207" /f
reg add "HKEY_CURRENT_USER\Control Panel\Colors" /v InfoWindow /t REG_SZ /d "204 232 207" /f
reg add "HKEY_CURRENT_USER\Control Panel\Colors" /v Window /t REG_SZ /d "204 232 207" /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard" /v Window /t REG_DWORD /d 0x00cce8cf /f

