@echo off
call "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvarsall.bat" x64

:: LLVM 从系统环境变量中读取
if defined LLVMInstallDir (
    set PATH=%LLVMInstallDir%\bin;%PATH%
)

rmdir /s /q build_vs
cmake -B build_vs -G "Visual Studio 17 2022" -A x64 -T ClangCL
echo.
echo exit_code=%errorlevel%
rem @cmd /k
