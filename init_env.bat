@echo off
call "C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvarsall.bat" x64 2>nul

set LLVM_ROOT=D:\APP\LLVM\clang+llvm-18.1.8-x86_64-pc-windows-msvc
set PATH=%LLVM_ROOT%\bin;D:\APP\LLVM;%PATH%
