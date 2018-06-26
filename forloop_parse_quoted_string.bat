@echo off
set FILE=quoted_string_to_be_parsed.txt
echo Unquoted is foobar > %FILE%
echo Quoted is "foobar" >> %FILE%
echo myVar is still foobar or "foobar" >> %FILE%

setlocal DisableDelayedExpansion enableextensions

FOR /F "tokens=* delims=" %%a IN (%FILE%) DO (
    echo UNQUOTED is %%a
    echo QUOTED is "%%a"
    set "myVar=%%a"
    :: Use setlocal and EnableDelayedExpansion to parse the string with quotation marks.
    setlocal enabledelayedexpansion 
    echo MYVAR is still !myVar! or "!myVar!"
    endlocal
    echo.
)