@echo off
call init_env.bat

cmake --build build_vs --config Debug
@cmd /k
