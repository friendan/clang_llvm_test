@echo off
call %~dp0init_env.bat

cmake --build build_vs --config Release
rem @cmd /k
