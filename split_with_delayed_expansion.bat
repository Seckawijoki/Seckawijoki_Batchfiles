@echo off
setlocal EnableDelayedExpansion
 
REM Set a string with an arbitrary number of substrings separated by semi colons
set teststring=The;rain;in;spain
 
REM Do something with each substring
:stringloop
    REM Stop when the string is empty
    if "!teststring!" EQU "" goto END
 
    for /f "delims=;" %%a in ("!teststring!") do set substring=%%a
 
        REM Do something with the substring - 
        REM we just echo it for the purposes of demo
        echo !substring!
 
REM Now strip off the leading substring
:striploop
    set stripchar=!teststring:~0,1!
    set teststring=!teststring:~1!
 
    if "!teststring!" EQU "" goto stringloop
 
    if "!stripchar!" NEQ ";" goto striploop
 
    goto stringloop
)
 
:END
endlocal