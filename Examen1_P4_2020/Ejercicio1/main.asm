.global main

.data

.text
main:
    addiu $sp, $sp, -32
    sw $s1, 24($sp)
    sw $s0, 20($sp)
    sw $ra, 28($sp)
    li $s0, 2
    li $s1, 6
$L2:
    move $a0, $s0
    move $a1, $s0
    jal draw_rect
    addiu $s0, $s0, 1
    li $a0, 10
    jal print_char
    bne $s0, $s1, $L2
    li $a1, 7
    li $a0, 4
    jal draw_rect
    lw $ra, 28($sp)
    lw $s1, 24($sp)
    lw $s0, 20($sp)
    move $v0, $zero
    addiu $sp, $sp, 32
    jr $ra
