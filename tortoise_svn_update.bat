@echo off

rem SVN安装目录
set svn_home=C:\TortoiseSVN\bin\

rem SVN需要update文件的本地目录
set svn_LocalPath=F:\trunk\env1

rem SVN自动更新操作命令
call "%svn_home%"\TortoiseProc.exe /command:update /path:"%svn_LocalPath%" /closeonend:1