@echo off
set DIR=%~dp0\..\CPP_files
set SUFFIX=cpp
:: /s参数会搜索子目录下的文件
for /f "delims=" %%i in ('dir /s /b %DIR%\*.%SUFFIX%') do (
  echo %%~i
)
 pause