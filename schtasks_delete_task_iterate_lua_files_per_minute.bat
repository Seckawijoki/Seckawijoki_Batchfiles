@echo off

set taskName=runIterateLuaFiles


schtasks /delete /tn "%taskName%" /f