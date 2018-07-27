@echo off

set batchGitPush=__common_git_add_commit_push.bat
set pathBatchFiles=f:\batch_files
set pathGitPush=%pathBatchFiles%\%batchGitPush%

git config --global user.email "seckawijoki@gmail.com"
git config --global user.name "seckawijoki@gmail.com"

set pathBase=f:
set aDirs=batch_files bash_files cpp_files lua_files working_notes_of_Miniworld

f:
echo Copy desktop files to working note directory..
call f:\batch_files\__copy_desktop_files_to_working_notes.bat
if exist f:\cpp_files\*.exe del /q /s f:\cpp_files\*.exe

for %%i in (%aDirs%) do (
  cd %pathBase%\%%i
  echo Running git pushes in %%i:
  copy %pathGitPush% %batchGitPush%
  call %batchGitPush%
)

echo Finish all git pushes.