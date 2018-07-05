@echo off
cls
set DIR_EMPTY=empty_directory
del /s /q %DIR_EMPTY%
if exist %DIR_EMPTY%\* for /r %%i in (%DIR_EMPTY%\*) do echo %%i
echo end