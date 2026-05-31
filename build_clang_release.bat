@echo off
call %~dp0init_env.bat

cmake --build build_clang --config Release
rem @cmd /k
