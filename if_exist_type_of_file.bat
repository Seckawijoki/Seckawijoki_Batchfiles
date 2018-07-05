@echo off
set DIR_EMPTY=empty_directory
if exist *.bat (
  echo There are bat files.
) else (
  echo There are not bat files.
)
if exist *.cpp (
  echo There are cpp files.
) else (
  echo There are not cpp files.
)
if exist *.xml (
  echo There are xml files.
) else (
  echo There are not xml files.
)
if exist *.lua (
  echo There are lua files.
) else (
  echo There are not lua files.
)
mkdir %DIR_EMPTY%
if exist %DIR_EMPTY%\* (
  echo There are some files in the directory %DIR_EMPTY%. 
) else (
  echo There are no files in the directory %DIR_EMPTY%.
)