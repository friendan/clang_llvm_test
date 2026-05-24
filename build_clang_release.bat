@echo off
call init_env.bat

cmake --build build_clang --config Release
@cmd /k
