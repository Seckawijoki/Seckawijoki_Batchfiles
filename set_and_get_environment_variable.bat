rem 设置环境变量
rem ----- incomplete -----
rem 关闭终端回显
@echo off
 
@echo ====current environment：
@echo %PATH%
 
rem 添加环境变量,即在原来的环境变量后加上英文状态下的分号和路径
set MY_PATH=D:\test\
@echo ====new environment：
setx PATH "%PATH%;%MY_PATH%"
echo=
echo.
@echo %PATH%
 
pause