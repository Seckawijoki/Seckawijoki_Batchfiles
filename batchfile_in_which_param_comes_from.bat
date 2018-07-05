@echo off
echo ----- %~n0 -----
set mParamFromOtherBatchfile=A remote parameter from other batchfiles, it will call the batchfile to use the parameter.
set mCalledBatchfile=batchfile_which_reads_the_remote_param.bat
echo ----- start to call %mCalledBatchfile% -----
call %mCalledBatchfile%