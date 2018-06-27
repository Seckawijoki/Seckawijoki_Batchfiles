@echo off
set input=AAA BBB CCC DDD EEE FFF
set nth=4
for /F "tokens=%nth% delims= " %%a in ("%input%") do set nthstring=%%a
echo %nthstring%