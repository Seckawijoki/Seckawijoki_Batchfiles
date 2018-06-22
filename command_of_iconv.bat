@echo off
set GBK_FILE=%~dp0\gbk_file.txt
set UTF8_FILE=%~dp0\utf8_file.txt
echo "English>%GBK_FILE%"
echo "0>%UTF8_FILE%"
echo ----- Content of gbk_file.txt:
type %GBK_FILE%
echo ----- Content of utf8_file.txt:
type %UTF8_FILE%
echo ----- START iconv ------
iconv -f GBK -t UTF-8 -c %GBK_FILE% > %UTF8_FILE%
echo ------ END iconv -------
echo ----- Content of gbk_file.txt:
type %GBK_FILE%
echo ----- Content of utf8_file.txt:
type %UTF8_FILE%
pause