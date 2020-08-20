; Implement the function draw_rect
; void draw_rect(int width, int height)

.global draw_rect

draw_rect:
addi $sp, $sp, -12
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)


move $t0, $a0; width
move $t1, $a1; height

move $t2, $zero; width mod

li $t3, 1; height mod

li $t4, 1

check_pos:

li $t2, 1

;salto de linea
li $a0, 10
li $v0, 11
syscall

beq $t3, $t1, print_H_end

beq $t3, $t4, print_H


print_V:
beq $t2, $t0, print_endV

beq $t2, $zero, print





print_space:
li $a0, 32

jal print_char

addi $t2, $t2, 1

bne $t2, $t0, print_space

beq $t2, $t0, print_V



print:

li $a0, 42

jal print_char

addi $t2, $t2, 1

bne $t2, $t0, print_V


print_endV:

li $a0, 42

jal print_char

addi $t3, $t3, 1

beq $t2, $t0, check_pos






print_H:

li $a0, 42

jal print_char

addi $t2, $t2, 1

bne $t2, $t0, print_H

addi $t3, $t3, 1

j check_pos

print_H_end:

li $a0, 42

jal print_char

addi $t2, $t2, 1

bne $t2, $t0, print_H_end


lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
addi $sp, $sp, 12

jr $ra

