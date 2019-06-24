@echo off

for /d %%i in (test\*.*) do (
    echo %%i
    rd /q /s "%%i"
)

for /d %%i in (c:\window?) do (
    echo %%i
)