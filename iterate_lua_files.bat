@echo off
set DIR=%~dp0\..\Lua_files
set SUFFIX=lua
:: /B          使用空格式(没有标题信息或摘要)
for /f "delims=" %%i in ('dir /b %DIR%\*.%SUFFIX%') do (
  echo %%~i
)
 pause