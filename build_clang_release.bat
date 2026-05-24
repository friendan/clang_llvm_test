@echo off
call init_env.bat

cmake --build build --config Release
@cmd /k
