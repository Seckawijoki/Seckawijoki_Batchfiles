@echo off
set DIR=%~dp0
set FILENAME=to_be_changed_limits
set FILEPATH=%DIR%%FILENAME%
if not exist %FILEPATH% (
 md %FILEPATH%
)
 echo 1->%FILEPATH%\file1_to_be_changed_limits
 echo 2->%FILEPATH%\file2_to_be_changed_limits

cacls %FILEPATH%
cacls %FILEPATH%\*
cacls %FILEPATH% /p everyone:N
cacls %FILEPATH%
cacls %FILEPATH%\*
cacls %FILEPATH% /p everyone:F
cacls %FILEPATH%
cacls %FILEPATH%\*
cacls %FILEPATH% /t /e /c /g Users:f
cacls %FILEPATH%
cacls %FILEPATH%\*

pause 1>nil