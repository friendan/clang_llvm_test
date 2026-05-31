@echo off
call %~dp0init_env.bat

cmake --build build_clang --config Debug
rem @cmd /k
