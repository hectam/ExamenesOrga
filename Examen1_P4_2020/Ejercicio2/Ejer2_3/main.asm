.global print
.global main

.data
$LC1:
    .byte "Sorted array: ", 0
$LC0:
    .word 74
    .word 34
    .word 227
    .word 232
    .word 4
    .word 103
    .word 181
    .word 186
    .word 192
    .word 278
    .word 142
    .word 70
    .word 13

.text
print:
    blez $a1, $L6
    addiu $sp, $sp, -32
    sll $a1, $a1, 2
    sw $s1, 24($sp)
    sw $s0, 20($sp)
    sw $ra, 28($sp)
    move $s0, $a0
    addu $s1, $a0, $a1
$L3:
    lw $a0, 0($s0)
    addiu $s0, $s0, 4
    jal print_int
    li $a0, 32
    jal print_char
    bne $s0, $s1, $L3
    lw $ra, 28($sp)
    lw $s1, 24($sp)
    lw $s0, 20($sp)
    li $a0, 10
    addiu $sp, $sp, 32
    j print_char
$L6:
    li $a0, 10
    j print_char
main:
    lui $v0, #hihw($LC0)
    addiu $sp, $sp, -80
    addiu $v0, $v0, #lohw($LC0)
    addiu $v1, $sp, 16
    sw $ra, 76($sp)
    addiu $a0, $v0, 48
$L11:
    lw $t0, 0($v0)
    lw $a3, 4($v0)
    lw $a2, 8($v0)
    lw $a1, 12($v0)
    addiu $v0, $v0, 16
    sw $t0, 0($v1)
    sw $a3, 4($v1)
    sw $a2, 8($v1)
    sw $a1, 12($v1)
    addiu $v1, $v1, 16
    bne $v0, $a0, $L11
    lw $v0, 0($v0)
    addiu $a0, $sp, 16
    li $a2, 12
    move $a1, $zero
    sw $v0, 0($v1)
    jal quicksort
    lui $a0, #hihw($LC1)
    addiu $a0, $a0, #lohw($LC1)
    jal print_str
    addiu $a0, $sp, 16
    li $a1, 13
    jal print
    lw $ra, 76($sp)
    move $v0, $zero
    addiu $sp, $sp, 80
    jr $ra
