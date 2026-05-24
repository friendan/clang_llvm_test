@echo off
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x64

set LLVM_ROOT=D:\APP\LLVM\clang+llvm-18.1.8-x86_64-pc-windows-msvc
set PATH=%LLVM_ROOT%\bin;D:\APP\LLVM;%PATH%

rmdir /s /q build_vs
cmake -B build_vs -G "Visual Studio 17 2022" -A x64 -T ClangCL
echo.
echo exit_code=%errorlevel%
@cmd /k
