## 项目概述
这是一个基于LLVM开发的WIN32程序，使用CMake作为构建系统。


## 编码要求：
1. 先想后写：不清楚的需求主动问，不瞎猜；给出多种实现方案，说明优缺点；不合理的需求要指出。
2. 简洁为主：只写实现需求必需的代码，不搞复杂架构，不添加多余功能。
3. 精准修改：只改需要改的代码，不改无关部分；保持原有代码风格，不擅自优化正常代码。
4. 目标导向：先明确代码要达到的效果，先写测试用例，再写功能代码，确保代码能通过测试。
5. 每次改完代码后 要编译项目且没有编译报错才算修改成功 有报错要修正 


### 构建步骤（Ninja + clang-cl 路线，推荐日常使用）
1. `build_clang_sln.bat` — 生成 Ninja 工程文件（build_clang 目录）
2. `build_clang_debug.bat` — 编译生成调试版本程序（默认用这个）
3. `build_clang_release.bat` — 编译生成发布版本程序
4. `bin\HelloLLVM.exe` — 运行程序

### 构建步骤（VS 生成器 + ClangCL 路线，用于 VS 调试）
1. `build_vs_sln.bat` — 生成 VS .sln 工程文件（build_vs 目录）
2. `build_vs_debug.bat` — VS 调试版本编译
3. `build_vs_release.bat` — VS 发布版本编译
4. 双击 `build_vs\LLVMHelloWorld.sln` 可直接在 VS 中打开并调试

