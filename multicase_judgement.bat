@echo off
set ����=
if "%A%"=="%B%" set ����=1
if "%C%"=="%D%" set ����=1
if defined ���� (
	echo ��һ������
) else (
	echo ��������
)

set ����=
if "%A%"=="%B%" if "%C%"=="%D%" set ����=1
if defined ���� (
	echo ������
) else (
	echo ������һ��������
)

set ����=
if "%A%"=="%B%" set /a ����=~����
if "%C%"=="%D%" set /a ����=~����
if "%����%"=="-1" (
	echo ����ֻ��һ������
) else (
	echo ��������
)