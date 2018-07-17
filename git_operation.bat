@echo on

if not defined push set push=true
if not defined dirOperated set dirOperated=all

set FILE_GIT_PUSH=__common_git_add_commit_push.sh
set FILE_GIT_PULL=__common_git_pull.sh

set A_DIRS_OPERATED=batch_files cpp_files lua_files working_notes_of_Miniworld

if "%push%" == "true" (
  set fileGitOperation=%FILE_GIT_PUSH%
) else (
  set fileGitOperation=%FILE_GIT_PULL%
)

if "%dirOperated%" == "all" (
  set aDirsOperated=%A_DIRS_OPERATED%
) else (
  set aDirsOperated=%dirOperated%
)

for %%i in (%aDirsOperated%) do (
  cd f:\%%i
  copy f:\bash_files\%fileGitOperation% %fileGitOperation% 
  call %fileGitOperation%
)

pause