@if %1.==. if not %prompt:~-4%==$s$h (cmd /s/c"prompt %prompt%$s$h&%0/?")
@echo off
if %1.==.   exit/b
if %1.==/?. goto:usage
if %1==/1 goto:attr1 
if %1==/2 goto:attr2
if %1==/4 goto:attr4
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_colstr [^<colorcode^>:"<color str>"^|"<common str>"^|^<escape Char^>];... 
(if %1.==. exit/b)&setlocal enabledelayedexpansion&pushd %tmp%
for /f "tokens=1* delims=:" %%a in ("%~1")do (
  if %%a:%%b.==%%a:"%%~b". (set col=%%a
    for %%z in ("LBlue=9";"LGreen=A";"LAqua=B";"LRed=C";"LPurple=D";
                "LYellow=E";"LWhite=F";"Black=0";"Blue=1";"Green=2";
                "Aqua=3";"Red=4";"Purple=5";"Yellow=6";"White=7";"Gray=8";
               )do set col=!col:%%~z!
      if exist "%%~b?" del/a/q "%%~b?"2>nul
      set/p= <nul>"%%~b"2>nul&findstr/a:!col! .* "%%~b?"2>nul 3>&2
    ) else if %1==\n (echo.
    ) else if %1==\b (set/p=<nul
    ) else if %1==\q (set/p=""^"<nul
    ) else if %1==\t (set/p= <nul &rem 注意=后面不是空格，是制表符
    ) else (set/p"=%~1"<nul)
)&(if %2. neq . (shift&endlocal&goto:_colstr))&exit/b
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:usage
echo.  colstr V1.1 code By plp626 On 09-5-30
echo.usage:
echo.  %~n0 [^<colorcode^>:"<color str>"^|"<common str>"^|^<escape Char^>];...
echo.
echo.^<colorcode^>:     
echo.       参看findstr /?的a参数，这里颜色属性16进制数字，
echo.       这里的颜色代码与它后面16进制颜色属性数字是等效的
echo.       Black=0   Blue=1   Green=2   Aqua=3   Red=4   Purple=5 
echo        Yellow=6   White=7   Gray=8   LBlue=9   LGreen=A  
echo        LAqua=B   LRed=C   LPurple=D   LYellow=E   LWhite=F  
echo.^<color string^>:
echo.       除了非法文件名外的所有字符
echo.       另外，不可以是纯“空格”、纯“.” 不可以“空格”、“.”结尾 
echo.       如果含有",;=^"其中之一给前面加上^^转义(命令行下)
echo.       如果含有惊叹号!需要给它前面加上6个^^转义(命令行下)     
echo.^<common string^>:
echo.       除了"外的所有字符, 注意对惊叹号的处理要在前面加上^
echo.^<escape char^>:
echo.   "\q"(双引号)、"\t"(制表符)、"\b"(退格)、"\n"(换行)
cmd/c %~n0 c:"[注意]";"多个字符串时用";\q;c:"^;";\q;"隔开";\n
echo.exapmple:&echo    命令行下键入：
echo.   %~n0  "欢迎发email:"; graygreen:"plp626@163.com"; "  交流^!";\n;
echo. 
echo 将显示：&echo.
cmd/c %~n0 "欢迎发email:  "; graylgreen:"plp626@163.com"; "  交流^!";\n;\n;
echo.键入 "%~n0/1" 查看一位数字的颜色属性效果
echo.键入 "%~n0/2" 查看两位数字的颜色属性效果
echo.键入 "%~n0/4" 查看四位数字的颜色属性效果&exit/b
:attr1
for %%b in (LBlue LGreen LAqua LRed LPurple LYellow LWhite Black : 
            Blue Green Aqua Red Purple Yellow White Gray
           )do if %%b==: (echo.) else cmd/c %~n0 "  ";%%b:"%%b"
echo\&&exit/b
:attr2
title %cmdcmdline%
setlocal&set attr=0 1 2 3 4 5 6 7 8 9 a b c d e f
for %%a in (%attr%)do echo.&for %%b in (%attr%)do cmd/c %~n0 %%a%%b:"[%%a%%b]"
echo.&endlocal&exit/b
:attr4
echo     当attr为3-4位时,低两位的作用不变，高两位则输出相应的边缘线：
cmd/c %~n0 \n;"     0000 =  "&for %%b in (1 2 3 : 4 5 6 7 : 8 9 A B : C D E F)do (
    if %%b==: (echo\&echo\) else  cmd/c %~n0 "     0%%b00 = "; 0%%b00:"0";)
echo.&exit/b