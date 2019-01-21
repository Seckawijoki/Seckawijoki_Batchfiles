@echo off

( dir /b /a "%dir%" | findstr . ) > nul && (
    echo %dir% not empty
) || (
    echo %dir% empty
)