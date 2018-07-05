@echo off
set DIR=%~dp0\..\Lua_files
set SUFFIX=lua
:: /B          使用空格式(没有标题信息或摘要)
:: 下方执行只显示了文件名。目录下没有文件夹
REM             %~1　　　 - 删除引号(\")，扩充 %1
REM 　　　　　 %~f1　　　 - 将 %1 扩充到一个完全合格的路径名
REM 　　　　　 %~d1　　　 - 仅将 %1 扩充到一个驱动器号
REM 　　　　　 %~p1　　　 - 仅将 %1 扩充到一个路径
REM 　　　　　 %~n1　　　 - 仅将 %1 扩充到一个文件名
REM 　　　　　 %~x1　　　 - 仅将 %1 扩充到一个文件扩展名
REM 　　　　　 %~s1　　　 - 扩充的路径指含有短名
REM 　　　　　 %~a1　　　 - 将 %1 扩充到文件属性
REM 　　　　　 %~t1　　　 - 将 %1 扩充到文件的日期/时间
REM 　　　　　 %~z1　　　 - 将 %1 扩充到文件的大小
for /f "delims=" %%i in ('dir /b %DIR%\*.%SUFFIX%') do (
  echo %%~i
)
 pause