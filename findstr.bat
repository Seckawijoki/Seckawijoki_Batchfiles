@echo off
set OVERSEAS_TYPE=US UK JP
set FILENAME=overseas_types.txt
echo %OVERSEAS_TYPE%>%FILENAME%
type %FILENAME%
find "JP" %FILENAME%