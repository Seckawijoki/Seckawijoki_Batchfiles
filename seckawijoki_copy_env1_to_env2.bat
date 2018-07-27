@echo off

del /q F:\trunk\env2\client\AppPlay\ApkBuilderScripts\automatic_build\*
del /q F:\trunk\env2\client\AppPlay\ApkBuilderScripts\automatic_build\sub_files\*

mkdir F:\trunk\env2\client\AppPlay\ApkBuilderScripts\automatic_build\sub_files
copy F:\trunk\env1\client\AppPlay\ApkBuilderScripts\automatic_build\* F:\trunk\env2\client\AppPlay\ApkBuilderScripts\automatic_build\*
copy F:\trunk\env1\client\AppPlay\ApkBuilderScripts\automatic_build\sub_files\* F:\trunk\env2\client\AppPlay\ApkBuilderScripts\automatic_build\sub_files\*
