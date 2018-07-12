@echo off

set fileName=__common_git_add_commit_push.sh
copy f:\batch_files\%fileName% f:\cpp_files\%fileName%
copy f:\batch_files\%fileName% f:\lua_files\%fileName%
copy f:\batch_files\%fileName% f:\working_notes_of_Miniworld\%fileName%
f:
cd batch_files
echo Copy desktop files to working note directory..
call f:\batch_files\__copy_desktop_files_to_working_notes.bat

echo Running git pushes of batch files...
call f:\batch_files\%fileName%
echo Running git pushes of cpp files...
call f:\cpp_files\%fileName%
echo Running git pushes of lua files...
call f:\lua_files\%fileName%

echo Running git pushes of working note files...
call f:\working_notes_of_Miniworld\%fileName%
echo Finish all git pushes.