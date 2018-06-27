@echo off & setlocal
set s=AAA BBB CCC DDD EEE FFF
set t=%s%
:loop
for /f "tokens=1*" %%a in ("%t%") do (
   echo %%a
   rem 将截取剩下的部分赋给t，其实这里可以使用延迟变量开关
   set t=%%b
)
if defined t goto :loop