@echo off
call init_env.bat

rmdir /s /q build_clang
cmake -B build_clang -G Ninja -DCMAKE_BUILD_TYPE=Debug
@cmd /k
