cmake_minimum_required(VERSION 3.16)
# ==============================================
# 🔥 第一步：必须先指定编译器！！！（放在最前面）
# ==============================================
set(CMAKE_C_COMPILER clang-cl)
set(CMAKE_CXX_COMPILER clang-cl)
project(LLVMHelloWorld)

set(LLVM_ROOT "D:/APP/LLVM/clang+llvm-18.1.8-x86_64-pc-windows-msvc") # 👇 手动指定你的 LLVM 路径（改成你自己的！）
find_package(LLVM)	#找到 LLVM 库（给你用 IR、API）

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>") # 静态链接CRT

add_compile_options("/utf-8") # 设置工程代码文件是UTF8编码
add_compile_options("/FS") # 允许多个编译器实例同时写入PDB文件
add_definitions(-DUNICODE -D_UNICODE) # 设置UNICODE字符集



# 让 CMake 找到 LLVM
find_package(LLVM REQUIRED CONFIG)

# 输出 LLVM 信息（确认成功）
message(STATUS "使用 LLVM 版本: ${LLVM_VERSION}")
message(STATUS "LLVM 路径: ${LLVM_INCLUDE_DIRS}")


# 生成可执行文件
add_executable(HelloLLVM main.cpp)

target_include_directories(HelloLLVM PRIVATE ${LLVM_INCLUDE_DIRS})
target_compile_definitions(HelloLLVM PRIVATE ${LLVM_DEFINITIONS})

# 链接 LLVM 库（最基础的核心库）
llvm_map_components_to_libnames(LLVM_LIBS support core irreader)
target_link_libraries(HelloLLVM ${LLVM_LIBS})



