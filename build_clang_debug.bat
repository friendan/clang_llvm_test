@echo off
call init_env.bat

cmake --build build_clang --config Debug
@cmd /k
