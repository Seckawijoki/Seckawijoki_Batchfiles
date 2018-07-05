@echo off

set fileWritten=file_replaced_string.txt
set "replacedString=android:versionCode="6404""
echo %replacedString% > %fileWritten%
set versionCode=6404
set newVersionCode=7012

echo replacedString = %replacedString%
echo versionCode = %versionCode%
echo newVersionCode = %newVersionCode%
echo.
type %fileWritten%
powershell -c "(gc %fileWritten%).Replace('"%versionCode%','"%newVersionCode%')|Out-File %fileWritten%"
type %fileWritten%
