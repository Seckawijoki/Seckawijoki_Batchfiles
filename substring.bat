@echo off
chcp 65001
set testStr=abcdefghijklmnopqrstuvwxyz0123456789
echo 原始字符串 %testStr%
echo 提取前五个字符串：%testStr:~0,5%
echo %testStr:~5%
echo 提取最后五个字符串：%testStr:~-5%
echo 提取第一个到倒数第六个字符串：%testStr:~0,-5%
echo 提取五个字符串，从第四个字符开始:%testStr:~3,5%