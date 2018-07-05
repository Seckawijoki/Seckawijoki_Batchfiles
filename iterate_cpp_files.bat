@echo off
set DIR=%~dp0\..\CPP_files
set SUFFIX=cpp
:: /s参数会搜索子目录下的文件
:: %%~i 完整盘符、路径与文件名及文件名后缀
:: %%~di 只显示盘符
:: %%~pi 只显示路径
:: %%~ni 只显示文件名，不显示后缀
:: %%~ni 文件名及后缀
:: %%~dpi 显示盘符与路径
:: %%~dpni 显示盘符、路径与文件名，不显示后缀
:: %%~dpni 显示盘符、路径与文件名，不显示后缀
for /f "delims=" %%i in ('dir /s /b %DIR%\*.%SUFFIX%') do (
  echo %%~nxi
)
pause