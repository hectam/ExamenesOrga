.global mergeSort

.data

.text
mergeSort:
    slt $v0, $a1, $a2
    bne $v0, $zero, $L7
    jr $ra
$L7:
    addiu $sp, $sp, -40
    sw $s3, 32($sp)
    subu $s3, $a2, $a1
    sra $s3, $s3, 1
    addu $s3, $s3, $a1
    sw $s2, 28($sp)
    sw $s1, 24($sp)
    move $s2, $a0
    move $s1, $a2
    move $a2, $s3
    sw $ra, 36($sp)
    sw $s0, 20($sp)
    move $s0, $a1
    jal mergeSort
    move $a2, $s1
    addiu $a1, $s3, 1
    move $a0, $s2
    jal mergeSort
    lw $ra, 36($sp)
    move $a3, $s1
    move $a2, $s3
    lw $s1, 24($sp)
    lw $s3, 32($sp)
    move $a1, $s0
    move $a0, $s2
    lw $s0, 20($sp)
    lw $s2, 28($sp)
    addiu $sp, $sp, 40
    j merge
