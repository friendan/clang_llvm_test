cmake_minimum_required(VERSION 3.16)

# ============================================================
# LLVM 独立分发包路径（请根据你的实际路径修改）
# ============================================================
set(LLVM_ROOT "D:/APP/LLVM/clang+llvm-18.1.8-x86_64-pc-windows-msvc")

# ============================================================
# 判断生成器类型，分别设置编译器和链接器
# ============================================================
if(CMAKE_GENERATOR MATCHES "Ninja|NMake")
  # ------------------------------
  # Ninja / NMake 模式：直接指定 clang-cl + lld-link
  # ------------------------------
  set(CMAKE_C_COMPILER "${LLVM_ROOT}/bin/clang-cl.exe")
  set(CMAKE_CXX_COMPILER "${LLVM_ROOT}/bin/clang-cl.exe")
  set(CMAKE_LINKER "${LLVM_ROOT}/bin/lld-link.exe")
elseif(CMAKE_GENERATOR MATCHES "Visual Studio")
  # ------------------------------
  # VS 生成器模式：通过 -T ClangCL 使用 LLVM 工具集
  # CMake 会自动找到 clang-cl 和 link.exe，无需额外设置
  # ------------------------------
endif()

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
# Debug 模式下强制匹配 LLVM 预编译库的 CRT 设置
#
# 因为 LLVM 预编译库是 Release 版（_ITERATOR_DEBUG_LEVEL=0, /MD），
# 而 Debug 构建默认 _ITERATOR_DEBUG_LEVEL=2, /MDd，会链接失败。
#
# 这里用生成器表达式，仅在 Debug 配置时强制追加 /MD 和
# /D_ITERATOR_DEBUG_LEVEL=0，确保和 LLVM 库一致。
#
# Ninja 模式：必须，否则链接报 /failifmismatch
# VS 模式：同样需要，ClangCL 工具集不改变 CRT 默认值
# ============================================================
target_compile_options(HelloLLVM PRIVATE
  $<$<CONFIG:Debug>:/MD>
  $<$<CONFIG:Debug>:/D_ITERATOR_DEBUG_LEVEL=0>
)
