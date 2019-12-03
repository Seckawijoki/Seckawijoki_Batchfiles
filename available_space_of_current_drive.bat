@echo off
chcp 65001
set dn=d
fsutil volume diskfree %~d0\
for /f "tokens=2* delims=()" %%a in ('fsutil volume diskfree %~d0\') do (
    set availableSpace=%%a
)
echo availableSpace = %availableSpace% B
REM set availableSpace=%availableSpace:~0,-3%
set /a left=%availableSpace:~0,7%/1024
set /a right=%availableSpace:~7%/1024
set "availableSpace=%left%%right%"
if "%availableSpace%" == "" set availableSpace=0
echo availableSpace ≈ %availableSpace% KB
set /a availableSpace=availableSpace/1024
echo availableSpace = %availableSpace% MB
set /a availableSpace=availableSpace/1024
echo availableSpace = %availableSpace% GB

if %availableSpace% lss 500 echo Space not enough in current drive