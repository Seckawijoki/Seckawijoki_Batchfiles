@echo off
set s=%1%
echo %s%
:: 代码块的左括号与if同行
:: 字符串判断时，要对变量添加双引号
if "%s%" equ "string" (
  echo true
) else (
  echo false
)
if "%s%" == "string" (
  echo true
) else (
  echo false
)
if "%s%" neq "string" (
  echo true
) else (
  echo false
)
pause 1>nil
