@echo off

forfiles /p "%DRIVE%\%DIR_OUTPUT%" /s /m *.* /d -7 /c "cmd /c del /q @path"
forfiles /p "%PATH_APP_PLAY%\%DIR_BACKUP%" /s /m *.* /d -7 /c "cmd /c del /q @path"