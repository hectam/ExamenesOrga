
.global quicksort


quicksort:

addiu $sp, $sp, -16

sw $s0, 0($sp)
sw $s1, 4($sp);first
sw $s2, 8($sp);last
sw $ra, 12($sp)

move $s0, $a0 
move $s1, $a1
move $s2, $a2


slt $t0, $s1, $s2

beq $t0, $zero,end_if


li $t3, 4

multu $t3, $s1
mflo $t0;pivot
multu $t3, $s1
mflo $t1;i
multu $t3, $s2
mflo $t2;j





check_while1:
slt $t3, $t1, $t2

beq $t3, $zero, end_while1

    while1:
    
        check_while2:
        slt $t3, $t1($s0), $t0($s0)
        beq $t3, $zero, end_while2
        
        slt $t4, $t1, $s2
        beq $t4, $zero, end_while2
        
        bne $t1($s0), $t0($s0),end_while2

            while2:
            
            addi $t1, $t1, 1
            

            j check_while2



        end_while2:
        
        check_while3:
        
        slt $t3, $t0($s0),$t2($s0)
        beq $t3, $zero, end_while3
        
        
            while3:
            addi $t2, $t2, -1
            
            j check_while3
        
        end_while3:
        
        slt $t3, $t1, $t2
        
        beq $t3, $zero, end_if1
        
        
        
        
        end_if1:


        

    end_while1:





end_if:

lw $s0, 0($sp)
lw $s1, 4($sp)
lw $s2, 8($sp)
lw $ra, 12($sp)

addiu $sp, $sp, 16
