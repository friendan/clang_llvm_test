#include <iostream>
#include <cstdlib>
#define NOMINMAX
#include <windows.h>
// 引入 LLVM 头文件
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/IRBuilder.h"

using namespace std;
using namespace llvm;

int main() {
    // 设置控制台输出为 UTF-8，解决中文乱码
    SetConsoleOutputCP(CP_UTF8);

    // 普通 C++ 输出
    cout << "================================" << endl;
    cout << "Hello LLVM World!" << endl;
    cout << "LLVM 版本: " << LLVM_VERSION_STRING << endl;
    cout << "================================" << endl;

    // ===== 下面是一段最简单的 LLVM 代码（验证能正常使用）=====
    LLVMContext Context;
    IRBuilder<> Builder(Context);
    Module* M = new Module("MyModule", Context);

    // 输出成功信息
    cout << "✅ LLVM 初始化成功！可以开始开发编译器了~" << endl;

    delete M;

    // 暂停，等待用户按键后退出
    cout << endl << "按任意键退出..." << endl;
    system("pause >nul");
    return 0;
}

