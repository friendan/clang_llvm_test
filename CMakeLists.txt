cmake_minimum_required(VERSION 3.16)

# ============================================================
# LLVM 路径：从系统环境变量 LLVMInstallDir 读取
# ============================================================
if(DEFINED ENV{LLVMInstallDir})
  file(TO_CMAKE_PATH "$ENV{LLVMInstallDir}" LLVM_ROOT)
else()
  message(FATAL_ERROR "环境变量 LLVMInstallDir 未设置，请在系统中设置 LLVM 安装路径")
endif()
message(STATUS "LLVM_ROOT: ${LLVM_ROOT}")

# ============================================================
# 根据生成器类型加载对应的专用配置
# ============================================================
if(CMAKE_GENERATOR MATCHES "Ninja|NMake")
  include(cmake_llvm.cmake)
elseif(CMAKE_GENERATOR MATCHES "Visual Studio")
  include(cmake_vs.cmake)
else()
  message(FATAL_ERROR "不支持的生成器: ${CMAKE_GENERATOR}")
endif()

project(LLVMHelloWorld)

find_package(LLVM)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

# ============================================================
# CRT（C 运行时库）设置
#
# LLVM 22.x 预编译库使用 /MT（静态链接），所以本项目也必须用静态运行时。
# ============================================================
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded")

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
