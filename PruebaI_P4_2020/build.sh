#!/bin/bash
ROOT_DIR=$(dirname $0)
BUILD="$ROOT_DIR/build"
VREWRITE="$ROOT_DIR/tools/vrewrite"
VTOPMODULE="Mips32SoC"
VERILOG_SRC_DIR="$ROOT_DIR/verilog"

RUN_CMAKE="F"
if [ ! -f $BUILD/Makefile ]; then
    mkdir -p $BUILD
    RUN_CMAKE="T"
fi

REBUILD_MODULE="F"
if [ ! -f "$BUILD/${VTOPMODULE}.v" ]; then
    REBUILD_MODULE="T"
else
    if [ "$BUILD/${VTOPMODULE}.v" -ot "$VERILOG_SRC_DIR/${VTOPMODULE}.v" ]; then
        REBUILD_MODULE="T"
    fi
fi

if [ $REBUILD_MODULE == "T" ]; then
    $VREWRITE --top-module $VTOPMODULE --in $VERILOG_SRC_DIR/${VTOPMODULE}.v \
            --out $BUILD/${VTOPMODULE}.v --repl-with ${VERILOG_SRC_DIR}/mips32soc_repl.v

    if [ $? -ne 0 ]; then
        exit 1
    fi
fi

cd $BUILD
if [ $RUN_CMAKE == "T" ]; then
    cmake ../test-cases
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi
cmake --build .
