cmake_minimum_required(VERSION 3.16)

# ============================================================
# LLVM 独立分发包路径（请根据你的实际路径修改）
# ============================================================
set(LLVM_ROOT "D:/APP/LLVM/clang+llvm-18.1.8-x86_64-pc-windows-msvc")

# ============================================================
# 编译器设置：使用 LLVM 的 clang-cl（替代 MSVC 的 cl.exe）
# ============================================================
set(CMAKE_C_COMPILER "${LLVM_ROOT}/bin/clang-cl.exe")
set(CMAKE_CXX_COMPILER "${LLVM_ROOT}/bin/clang-cl.exe")

# 链接器：使用 LLVM 的 lld-link（替代 MSVC 的 link.exe）
set(CMAKE_LINKER "${LLVM_ROOT}/bin/lld-link.exe")

project(LLVMHelloWorld)

find_package(LLVM)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

# ============================================================
# ⚠️ CRT（C 运行时库）设置
#
# LLVM 官方提供的预编译库是 Release 版，使用 /MD（动态链接、Release 运行时）。
# 所以不管是 Debug 还是 Release 构建，都必须统一用 /MD（MultiThreadedDLL），
# 而非默认的 Debug 用 /MDd、Release 用 /MD。
#
# 如果以后你自己从源码编译了 LLVM 的 Debug 版库，可以改回下面这种配置：
#   set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>DLL")
# ============================================================
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDLL")

add_compile_options("/utf-8")
add_compile_options("/FS")

add_definitions(-DUNICODE -D_UNICODE)

# ============================================================
# LLVM 库配置
# ============================================================
find_package(LLVM REQUIRED CONFIG)

message(STATUS "使用 LLVM 版本: ${LLVM_VERSION}")
message(STATUS "LLVM 路径: ${LLVM_INCLUDE_DIRS}")

# ============================================================
# 生成可执行文件
# ============================================================
add_executable(HelloLLVM main.cpp)

target_include_directories(HelloLLVM PRIVATE ${LLVM_INCLUDE_DIRS})
target_compile_definitions(HelloLLVM PRIVATE ${LLVM_DEFINITIONS})

# 链接 LLVM 库
llvm_map_components_to_libnames(LLVM_LIBS support core irreader)
target_link_libraries(HelloLLVM ${LLVM_LIBS})

# ============================================================
# Debug 模式的额外修正
#
# 因为上面设置了全局 CRT 为 /MD，但 Debug 模式下
# MSVC 标准库头文件仍会强制定义 _ITERATOR_DEBUG_LEVEL=2，
# 与 LLVM 预编译库（_ITERATOR_DEBUG_LEVEL=0）冲突。
#
# 这里用生成器表达式，仅在 Debug 配置时强制追加 /MD 和
# /D_ITERATOR_DEBUG_LEVEL=0，确保和 LLVM 库一致。
# ============================================================
target_compile_options(HelloLLVM PRIVATE
  $<$<CONFIG:Debug>:/MD>
  $<$<CONFIG:Debug>:/D_ITERATOR_DEBUG_LEVEL=0>
)
