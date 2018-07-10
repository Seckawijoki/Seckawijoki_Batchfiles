@echo off

set fileName=__common_git_pull.sh
copy %fileName% f:\batch_files\%fileName%
copy %fileName% f:\cpp_files\%fileName%
copy %fileName% f:\lua_files\%fileName%
copy %fileName% f:\working_notes_of_Miniworld\%fileName%

echo Running git pulls of batch files...
call f:\batch_files\%fileName%
echo Running git pulls of cpp files...
call f:\cpp_files\%fileName%
echo Running git pulls of lua files...
call f:\lua_files\%fileName%
echo Running git pulls of working note files...
call f:\working_notes_of_Miniworld\%fileName%
echo Finish all git pulls.