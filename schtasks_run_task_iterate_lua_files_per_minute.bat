@echo on

set pathIterateLuaFiles=f:\batch_files\iterate_lua_files.bat

set taskName=runIterateLuaFiles
set "taskRun=call %pathIterateLuaFiles%"
set schedule=MINUTE
set modifier=1
set startTime=10:46:00


schtasks /create /sc %schedule% /tn %taskName% /tr "%taskRun%" /mo %modifier% /s local /u Seckawijoki /p 0218
schtasks /create /sc %schedule% /tn %taskName% /tr "echo test" /mo %modifier% /s local /u Seckawijoki /p 0218
