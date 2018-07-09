@echo on

rem ----- incomplete -----
set taskName="runGitPull"
set taskRun=f:\batch_files\__call_git_pull.bat
set schedule=DAILY
set modifier=1
set startTime=21:50:00
set startDate=2018/07/08
set system=local
set user=Seckawijoki
set password=0218

schtasks /create /sc %schedule% /mo %modifier% /tn %taskName% /tr %taskRun% /st %startTime% /sd %startDate% /u %user% /p %password%