@echo off
call init_env.bat

rmdir /s /q build
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug
@cmd /k
