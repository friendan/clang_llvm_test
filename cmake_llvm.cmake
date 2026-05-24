# ============================================================
# LLVM / Ninja 模式专用配置
# 配合 build_sln.bat / build_debug.bat / build_release.bat 使用
# ============================================================

# Ninja / NMake 模式：直接指定 clang-cl + lld-link
set(CMAKE_C_COMPILER "${LLVM_ROOT}/bin/clang-cl.exe")
set(CMAKE_CXX_COMPILER "${LLVM_ROOT}/bin/clang-cl.exe")
set(CMAKE_LINKER "${LLVM_ROOT}/bin/lld-link.exe")
