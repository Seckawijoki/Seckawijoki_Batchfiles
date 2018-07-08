@echo off

pause
exit

rem ----- incomplete -----
set taskName="runGitPull"
set taskRun=f:\batch_files\__call_git_pull.bat
set taskRun=shutdown
set schedule=DAILY
set modifier=1
set startTime=21:50:00
set startDate=07/07/2018
set system=local
set user=Seckawijoki
set password=0218

schtasks /create /tn %taskName% /tr "%taskRun%" /sc %schedule% /mo %modifier%  /st %startTime% /s %system% /u %user% /p %password%