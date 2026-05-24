# clang_llvm_test
clang_llvm
Ninja
NMake
C++ Clang tools for Windows

如果你装了 "C++ Clang tools for Windows" 组件，就可以直接在 VS 工程属性里选择 `LLVM (clang-cl)` 平台工具集，
然后用 VS 直接编译。独立 LLVM 包不提供这个 VS 集成。

目前你用的是 NMake + clang-cl + lld-link 的路线，不需要这个 VS 组件也能正常用 LLVM 编译。
如果你想回到 VS 生成器 + .sln 的路线，就需要安装那个组件。
https://learn.microsoft.com/zh-cn/cpp/build/clang-support-msbuild?view=msvc-170
