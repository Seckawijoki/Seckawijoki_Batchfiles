chcp 65001
set DRIVE=%~d0
fsutil volume diskfree %DRIVE%
for /f "tokens=5* delims= " %%a in ('fsutil volume diskfree %DRIVE%') do set availableSpace=%%a
set availableSpace=%availableSpace:~0,-3%
if "%availableSpace%" == "" set availableSpace=0
if %availableSpace% lss 50 (
  echo Available space of drive %DRIVE% is less than 50G now, start deleting some backups.
)
echo %availableSpace%
set availableSpace=