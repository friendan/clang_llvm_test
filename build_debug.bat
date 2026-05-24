@echo off
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x64

set LLVM_ROOT=D:\APP\LLVM\clang+llvm-18.1.8-x86_64-pc-windows-msvc
set PATH=%LLVM_ROOT%\bin;D:\APP\LLVM;%PATH%

cmake --build build --config Debug
@cmd /k
