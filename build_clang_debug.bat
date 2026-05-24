@echo off
call init_env.bat

cmake --build build --config Debug
@cmd /k
