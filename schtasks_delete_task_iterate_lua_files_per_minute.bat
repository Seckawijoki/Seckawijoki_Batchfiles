@echo off

rem ----- incomplete -----
set taskName=runIterateLuaFiles


schtasks /delete /tn "%taskName%" /f