@echo off
call %~dp0init_env.bat

rmdir /s /q build_clang
cmake -B build_clang -G Ninja -DCMAKE_BUILD_TYPE=Debug
rem @cmd /k
