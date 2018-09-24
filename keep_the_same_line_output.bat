@echo off
setlocal EnableExtensions EnableDelayedExpansion

set lastValue=0
for /f %%i in ('dir /b *.*') do (
    for /f %%a in ('copy /Z "%~dpf0" nul') do set "CR=%%a"
    <nul set /p "=%%i!CR!" <NUL
)

echo y
<nul set /p "=Peng Dapu!CR!" <NUL
<nul set /p "=Seckawijoki!CR!" <NUL
<nul set /p "=Houtaipo!CR!" <NUL