@echo off
set DIR=%~dp0
set FILENAME=to_be_changed_limits
set FILEPATH=%DIR%%FILENAME%
if not exist %FILEPATH% (
 md %FILEPATH%
)

cacls %FILEPATH%
cacls %FILEPATH% /p everyone:N
cacls %FILEPATH%
cacls %FILEPATH% /p everyone:F
cacls %FILEPATH%

pause 1>nil