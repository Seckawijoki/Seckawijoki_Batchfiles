@echo off
chcp 65001

set year=%date:~0,4%
set month=%date:~5,2%
set day=%date:~8,2%
set whatday=%date:~11,2%
set hour=%time:~0,2%
set minute=%time:~3,2%
set second=%time:~6,2%
set millisecond=%time:~9,2%

echo date = %date%
echo time = %time%
echo year = %year%
echo month = %month%
echo day = %day%
echo minute = %minute%
echo whatday = %whatday%
echo hour = %hour%
echo minute = %minute%
echo second = %second%
echo millisecond = %millisecond%

set directoryName=NDK_build_armeabi_%year%-%month%-%day%%whatday%%hour%-%minute%

echo directoryName = %directoryName%