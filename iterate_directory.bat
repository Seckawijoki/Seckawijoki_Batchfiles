@echo off

for /d %%i in (*.*) do (
    echo %%i
)

for /d %%i in (c:\window?) do (
    echo %%i
)