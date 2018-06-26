@echo off
set READ_FILE=read_file.txt
set ANOTHER_READ_FILE=another_read_file.txt
echo 1row1col 1row2col 1row3col  >%READ_FILE%
echo 2row1col 2row2col 2row3col  >>%READ_FILE%
echo 3row1col 3row2col 3row3col  >>%READ_FILE%
echo .1row1col 1row2col 1row3col  >%ANOTHER_READ_FILE%
echo .2row1col 2row2col 2row3col  >>%ANOTHER_READ_FILE%
echo 3row1col 3row2col 3row3col  >>%ANOTHER_READ_FILE%
echo.
type %READ_FILE%
echo.
:: 只输出第一列。默认了空格作分隔符
for /f %%i in (%READ_FILE%) do echo %%i
echo.
:: 输出标题
for %%i in (%READ_FILE%) do echo %%i
echo.
:: 使用delims指定空格为分隔符
for /f "delims= " %%i in (%READ_FILE%) do echo %%i
echo. 
:: 输出第二列
for /f "tokens=2 delims= " %%i in (%READ_FILE%) do echo %%i
echo. 
:: 输出第二第三列。输出时多了一个%%j变量
for /f "tokens=2,3 delims= " %%i in (%READ_FILE%) do echo %%i %%j
echo. 
:: 对以通配符*，就是把这一行全部或者这一行的剩余部分当作一个元素了。
for /f "tokens=* delims= " %%i in (%READ_FILE%) do echo %%i
echo. 
:: 用skip来告诉for跳过前两行。
for /f "skip=2 tokens=*" %%i in (%READ_FILE%) do echo %%i
echo. 
:: 用eol来告诉for忽略以"."开头的行。
for /f "eol=. tokens=*" %%i in (%ANOTHER_READ_FILE%) do echo %%i
echo. 