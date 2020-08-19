#!/bin/bash

EASYASM="../../tools/EasyASM"
EXPECTED_OUTPUT="expected.txt"
OUTPUT_FILE=$(mktemp)
SRC_FILE="merge_sort.asm merge.asm"

$EASYASM --run easm_crt.asm main.asm $SRC_FILE > $OUTPUT_FILE
if [ $? -ne 0 ]; then
    exit 1
fi

diff $OUTPUT_FILE $EXPECTED_OUTPUT &> /dev/null
if [ $? -ne 0 ]; then
    printf "Test \x1b[31mFailed\x1b[0m\n"
else
    printf "Test \x1b[32mPassed\x1b[0m\n"
fi
