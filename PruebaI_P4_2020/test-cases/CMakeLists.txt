# rm -rf build && mkdir build && cd build
# cmake ..
# cmake --build .

cmake_minimum_required(VERSION 3.8)
project(test_MIPS32SOC)

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})
if (NOT verilator_FOUND)
  message(FATAL_ERROR "Verilator was not found. Either install it, or set the VERILATOR_ROOT environment variable")
endif()

set(VTOPMODULE "Mips32SoC")
set(VERILOG_SRCDIR "${CMAKE_CURRENT_SOURCE_DIR}/verilog")
set(VERILOG_SOURCES "${CMAKE_CURRENT_BINARY_DIR}/${VTOPMODULE}.v")

include_directories(${CMAKE_CURRENT_BINARY_DIR})

# Create a new executable target that will contain all your sources
add_executable(${PROJECT_NAME}  ${PROJECT_NAME}.cpp)

# Add the Verilated circuit to the target
verilate(${PROJECT_NAME}
    TOP_MODULE "${VTOPMODULE}"
    VERILATOR_ARGS -Wno-fatal -Os -DNO_INIT_MEM
    SOURCES ${VERILOG_SOURCES}
)
