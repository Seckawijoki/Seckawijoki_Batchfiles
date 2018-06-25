@echo off
set 成立=
if "%A%"=="%B%" set 成立=1
if "%C%"=="%D%" set 成立=1
if defined 成立 (
	echo 有一个成立
) else (
	echo 均不成立
)

set 成立=
if "%A%"=="%B%" if "%C%"=="%D%" set 成立=1
if defined 成立 (
	echo 均成立
) else (
	echo 至少有一个不成立
)

set 成立=
if "%A%"=="%B%" set /a 成立=~成立
if "%C%"=="%D%" set /a 成立=~成立
if "%成立%"=="-1" (
	echo 有且只有一个成立
) else (
	echo 均不成立
)