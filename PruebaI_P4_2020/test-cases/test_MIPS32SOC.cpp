#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN

#include <iostream>
#include <chrono>
#include <random>
#include "doctest.h"
#include "VMips32SoC__Syms.h"

#define GLOBAL_BASEADDR 0x0
#define CODE_BASEADDR   0x0

#define DECLARE_MIPS32_REGS(m) \
    uint32_t& zero = m.Mips32SoC->reg_file->memory[0]; \
    uint32_t& at = m.Mips32SoC->reg_file->memory[1]; \
    uint32_t& v0 = m.Mips32SoC->reg_file->memory[2]; \
    uint32_t& v1 = m.Mips32SoC->reg_file->memory[3]; \
    uint32_t& a0 = m.Mips32SoC->reg_file->memory[4]; \
    uint32_t& a1 = m.Mips32SoC->reg_file->memory[5]; \
    uint32_t& a2 = m.Mips32SoC->reg_file->memory[6]; \
    uint32_t& a3 = m.Mips32SoC->reg_file->memory[7]; \
    uint32_t& t0 = m.Mips32SoC->reg_file->memory[8]; \
    uint32_t& t1 = m.Mips32SoC->reg_file->memory[9]; \
    uint32_t& t2 = m.Mips32SoC->reg_file->memory[10]; \
    uint32_t& t3 = m.Mips32SoC->reg_file->memory[11]; \
    uint32_t& t4 = m.Mips32SoC->reg_file->memory[12]; \
    uint32_t& t5 = m.Mips32SoC->reg_file->memory[13]; \
    uint32_t& t6 = m.Mips32SoC->reg_file->memory[14]; \
    uint32_t& t7 = m.Mips32SoC->reg_file->memory[15]; \
    uint32_t& s0 = m.Mips32SoC->reg_file->memory[16]; \
    uint32_t& s1 = m.Mips32SoC->reg_file->memory[17]; \
    uint32_t& s2 = m.Mips32SoC->reg_file->memory[18]; \
    uint32_t& s3 = m.Mips32SoC->reg_file->memory[19]; \
    uint32_t& s4 = m.Mips32SoC->reg_file->memory[20]; \
    uint32_t& s5 = m.Mips32SoC->reg_file->memory[21]; \
    uint32_t& s6 = m.Mips32SoC->reg_file->memory[22]; \
    uint32_t& s7 = m.Mips32SoC->reg_file->memory[23]; \
    uint32_t& t8 = m.Mips32SoC->reg_file->memory[24]; \
    uint32_t& t9 = m.Mips32SoC->reg_file->memory[25]; \
    uint32_t& k0 = m.Mips32SoC->reg_file->memory[26]; \
    uint32_t& k1 = m.Mips32SoC->reg_file->memory[27]; \
    uint32_t& gp = m.Mips32SoC->reg_file->memory[28]; \
    uint32_t& sp = m.Mips32SoC->reg_file->memory[29]; \
    uint32_t& fp = m.Mips32SoC->reg_file->memory[30]; \
    uint32_t& ra = m.Mips32SoC->reg_file->memory[31]; \
    uint32_t& pc = m.Mips32SoC->PC

#define CHECK_ERROR_SIGNALS(m) \
        do { \
             \
        } while (0)

#include "tests-code.cpp"

void reset(VMips32SoC& m) {
    m.rst = 1;
    m.clk = 0;
    m.eval();
    m.clk = 1;
    m.eval();
    m.clk = 0;
    m.rst = 0;
    m.eval();
}

void clockPulse(VMips32SoC& m) {
    m.clk = 1;
    m.eval();
    m.clk = 0;
    m.eval();
}

void setProgramCode(VMips32SoC& m, const uint32_t code[], int size) {
    for (int i = 0; i < size; i++) {
        m.Mips32SoC->inst_mem->memory[i] = code[i];
    }
}

void randomizeRegisterFile(VMips32SoC& m) {
    unsigned seed = std::chrono::steady_clock::now().time_since_epoch().count();
    std::default_random_engine re(seed);
    std::uniform_int_distribution<> dist(1, 65535);

    for (int i = 1; i < 32; i++) {
        m.Mips32SoC->reg_file->memory[i] = dist(re);
    }
}

TEST_CASE("'add' test") {
    VMips32SoC m;
    DECLARE_MIPS32_REGS(m);

    randomizeRegisterFile(m);
    a0 = 10500;  
    a1 = 3500;
    a2 = -3500;
    a3 = 500;

    setProgramCode(m, test_add_code, TEST_ADD_CODE_SIZE);

    reset(m);
    REQUIRE(pc == CODE_BASEADDR);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);
    
    CHECK(t0 == 14000);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);
    
    CHECK(t1 == -3000);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);
    
    CHECK(t2 == 0);
}

TEST_CASE("'sub' test") {
    VMips32SoC m;
    DECLARE_MIPS32_REGS(m);

    randomizeRegisterFile(m);
    a0 = 10500;  
    a1 = 3500;
    a2 = -3500;
    a3 = 500;

    setProgramCode(m, test_sub_code, TEST_SUB_CODE_SIZE);

    reset(m);
    REQUIRE(pc == CODE_BASEADDR);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);
    
    CHECK(t0 == 7000);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);
    
    CHECK(t1 == -4000);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);
    
    CHECK(t2 == 7000);
}

TEST_CASE("'and' test") {
    VMips32SoC m;
    DECLARE_MIPS32_REGS(m);

    randomizeRegisterFile(m);

    a0 = 0xaabbccdd;  
    a1 = 0x00ff00ff;
    a2 = 0x11223344;
    a3 = 0xff0000ff;

    setProgramCode(m, test_and_code, TEST_AND_CODE_SIZE);

    reset(m);
    REQUIRE(pc == CODE_BASEADDR);
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(t0 == 0x00bb00dd);
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(t1 == 0x11000044);
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(t2 == 0x00220044);
}

TEST_CASE("'or' test") {
    VMips32SoC m;
    DECLARE_MIPS32_REGS(m);

    randomizeRegisterFile(m);

    a0 = 0xaa00cc00;  
    a1 = 0x00bb00dd;
    a2 = 0x00223300;
    a3 = 0x11000044;

    setProgramCode(m, test_or_code, TEST_OR_CODE_SIZE);

    reset(m);
    REQUIRE(pc == CODE_BASEADDR);
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(t0 == 0xaabbccdd);
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(t1 == 0x11223344);
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(t2 == 0x00BB33DD);
}

TEST_CASE("'slt' test") {
    VMips32SoC m;
    DECLARE_MIPS32_REGS(m);

    randomizeRegisterFile(m);

    a0 = 10500;  
    a1 = 3500;
    a2 = -3500;
    a3 = 500;

    setProgramCode(m, test_slt_code, TEST_SLT_CODE_SIZE);

    reset(m);
    REQUIRE(pc == CODE_BASEADDR);
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(t0 == 0);
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(t1 == 1);
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(t2 == 0);
}

TEST_CASE("'lw' test") {
    VMips32SoC m;
    DECLARE_MIPS32_REGS(m);

    randomizeRegisterFile(m);

    a0 = GLOBAL_BASEADDR;
    m.Mips32SoC->data_mem->memory[0] = 0xaabbccdd;
    m.Mips32SoC->data_mem->memory[4] = 0x11223344;
    m.Mips32SoC->data_mem->memory[16] = 0xdeadbeef;

    setProgramCode(m, test_lw_code, TEST_LW_CODE_SIZE);

    reset(m);
    REQUIRE(pc == CODE_BASEADDR);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);
    
    CHECK(t0 == 0xaabbccdd);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(t1 == 0x11223344);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(t2 == 0xdeadbeef);
}

TEST_CASE("'sw' test") {
    VMips32SoC m;
    DECLARE_MIPS32_REGS(m);

    a0 = GLOBAL_BASEADDR;
    t0 = 0xaabbccdd;
    t1 = 0x11223344;
    t2 = 0xdeadbeef;

    setProgramCode(m, test_sw_code, TEST_SW_CODE_SIZE);

    reset(m);
    REQUIRE(pc == CODE_BASEADDR);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(m.Mips32SoC->data_mem->memory[0] == 0xaabbccdd);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(m.Mips32SoC->data_mem->memory[4] == 0x11223344);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);
    
    CHECK(m.Mips32SoC->data_mem->memory[16] == 0xdeadbeef);
}

TEST_CASE("'jmp' test") {
    VMips32SoC m;
    DECLARE_MIPS32_REGS(m);

    setProgramCode(m, test_jump_code, TEST_JUMP_CODE_SIZE);

    reset(m);
    REQUIRE(pc == CODE_BASEADDR);
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(pc == (CODE_BASEADDR + 16));
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(pc == (CODE_BASEADDR + 20));
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(pc == (CODE_BASEADDR + 4));
}

TEST_CASE("'beq' test") {
    VMips32SoC m;
    DECLARE_MIPS32_REGS(m);

    a0 = 10500;
    a1 = -3500;
    a2 = 10500;
    a3 = -3500;

    setProgramCode(m, test_beq_code, TEST_BEQ_CODE_SIZE);

    reset(m);
    REQUIRE(pc == CODE_BASEADDR);
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(pc == (CODE_BASEADDR + 4));
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(pc == (CODE_BASEADDR + 20));
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(pc == (CODE_BASEADDR + 24));
    clockPulse(m);
    CHECK_ERROR_SIGNALS(m);
    CHECK(pc == (CODE_BASEADDR + 8));
}

TEST_CASE("'bne' test") {
    VMips32SoC m;
    DECLARE_MIPS32_REGS(m);

    a0 = 10500;
    a1 = 10500;
    a2 = -3500;
    a3 = -3500;

    setProgramCode(m, test_bne_code, TEST_BNE_CODE_SIZE);

    reset(m);
    REQUIRE(pc == CODE_BASEADDR);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);
    
    CHECK(pc == (CODE_BASEADDR + 4));
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(pc == (CODE_BASEADDR + 20));
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(pc == (CODE_BASEADDR + 24));
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);
    
    CHECK(pc == (CODE_BASEADDR + 8));
}

TEST_CASE("'lui' test") {
    VMips32SoC m;
    DECLARE_MIPS32_REGS(m);

    randomizeRegisterFile(m);
    setProgramCode(m, test_lui_code, TEST_LUI_CODE_SIZE);

    reset(m);
    REQUIRE(pc == CODE_BASEADDR);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(t0 == 0xaabb0000);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(t1 == 0xccdd0000);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(t2 == 0x11220000);
}

TEST_CASE("'addi' test") {
    VMips32SoC m;
    DECLARE_MIPS32_REGS(m);

    randomizeRegisterFile(m);
    a0 = 3500;
    a1 = 3500;
    a2 = 3500;

    setProgramCode(m, test_addi_code, TEST_ADDI_CODE_SIZE);

    reset(m);
    REQUIRE(pc == CODE_BASEADDR);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(t0 == 4000);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(t1 == 3000);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(t2 == 0);
}

TEST_CASE("'andi' test") {
    VMips32SoC m;
    DECLARE_MIPS32_REGS(m);

    randomizeRegisterFile(m);
    a0 = 0xaabbccdd;
    a2 = 0x11223344;

    setProgramCode(m, test_andi_code, TEST_ANDI_CODE_SIZE);

    reset(m);
    REQUIRE(pc == CODE_BASEADDR);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(t0 == 0xdd);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(t1 == 0x3344);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(t2 == 0xc0d0);
}

TEST_CASE("'ori' test") {
    VMips32SoC m;
    DECLARE_MIPS32_REGS(m);

    randomizeRegisterFile(m);
    a0 = 0xaabbcc00;
    a1 = 0x11223300;
    a2 = 0x11223300;

    setProgramCode(m, test_ori_code, TEST_ORI_CODE_SIZE);

    reset(m);
    REQUIRE(pc == CODE_BASEADDR);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(t0 == 0xaabbccdd);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(t1 == 0x11223344);
    CHECK_ERROR_SIGNALS(m);
    clockPulse(m);

    CHECK(t2 == 0x1122f3cd);
}
