@echo off & setlocal
rem Notify that 
rem  also works for comma-separated lists, e.g. ABC,DEF,GHI,JKL
set s=AAA BBB CCC DDD EEE FFF
for %%a in (%s%) do echo %%a