.data
DefTab: .byte "Recomended", 0
DefTab1: .byte " Personalized", 0


row: .byte "Enter rows: ", 0
column: .byte "Enter Columns: ", 0



newGame: .byte "New Game",0
exit: .byte "Exit", 0
credits: .byte "Credits",0

Easy: .byte "( -‿- )",0
Normal: .byte "( 0‿0 )",0
hard: .byte "(´･_･`)",0

bombs: .byte "How many bombs do you want?: ", 0

readys: .byte "Are You Ready?: ",0

yes: .byte "I'm Ready", 0

no: .byte "No, wait...", 0

youwin: .byte "Congratulations you win!!    ( -‿- )",0

youlose: .byte "You lose   (´･_･`)",0


table: .byte "| ? ",0

top: .byte "----",0

space: .byte "   ",0
space0: .byte "  ",0




.text

jal main

    li $v0, 23; limpia pantalla
    syscall
    li $v0, 10
    syscall


main_menu:

   

    li $s2, 20; limite arriba
    li $s3, 24; limite abajo

    li $s4, 0; screen

    li $t0, 89
    li $t1, 20
    
    menu_print:
        li $v0, 23; limpia pantalla
        syscall
#show $t2 decimal
        li $v0, 21 ;imprime el titulo
        syscall 

    
        li $a1, 20
        li $a0, 90
        li $v0, 22  ;gotoxy
        syscall

        li $v0, 4
        li $a0, newGame
        syscall

        li $a1, 22
        li $a0, 90
        li $v0, 22  ;gotoxy
        syscall

        li $v0, 4
        li $a0, credits
        syscall

        li $a1, 24
        li $a0, 90
        li $v0, 22  ;gotoxy
        syscall

        li $v0, 4
        li $a0, exit
        syscall

        Selection_loop:
            printS:

                move $a0, $t0
                move $a1, $t1
                li $v0, 22
                syscall


                li $v0, 11
                li $a0, 62
                syscall

            detect:
                move $a0, $t0
                move $a1, $t1
                move $a2, $s4
                li $v0, 24
                syscall
                
                bne $v1, $t1, refresh
                beq $t2, $zero, accepted
                
                
                j detect

                refresh:
                
                move $a0, $t0
                move $a1, $t1
                li $v0, 22
                syscall

                li $v0, 11
                li $a0, 32
                syscall

                move $t1, $v1
                j printS

                accepted:
                li $t4, 20
                beq $t1, $t4, parameters

                 li $t4, 22
                beq $t1, $t4, made_by

                 li $t4, 24
                beq $t1, $t4, endGame




                endGame:

    jr $ra

parameters:
        li $v0, 23; limpia pantalla
        syscall

        li $s2, 19; limite arriba
        li $s3, 21; limite abajo

        li $s4, 0; screen

        li $t0, 100
        li $t1, 19

        li $t5, 5 ;bomb number
        li $t6, 6 ; easy or normal
        li $t7, 25 ; normal or hard

        no_wait:

        li $s2, 19; limite arriba
        li $s3, 21; limite abajo

        li $t0, 100
        li $t1, 19


        parameters_print:
           
            
            slt $t8, $t5, $t6
            bne $t8, $zero, bomb0

            bomb1:

             li $v0, 23; limpia pantalla
            syscall

            li $v0, 27 ;imprime el titulo
            syscall

            slt $t8, $t5, $t7
            bne $t8, $zero, continue 

            bomb2:
             li $v0, 23; limpia pantalla
            syscall
            li $v0, 28 ;imprime el titulo
            syscall 

            j continue

            bomb0:
             li $v0, 23; limpia pantalla
            syscall
            li $v0, 26 ;imprime el titulo
            syscall 

            continue:

            li $a1, 20
            li $a0, 70
            li $v0, 22  ;gotoxy
            syscall

            li $v0, 4
            li $a0, bombs
            syscall

            li $a1, 20
            li $a0, 110
            li $v0, 22  ;gotoxy
            syscall

            slt $t8, $t5, $t6
            bne $t8, $zero, EasyFace

            NormalFace:
            li $v0, 4
            li $a0, Normal
            syscall

            slt $t8, $t5, $t7
            bne $t8, $zero, parameters_loop


            li $a1, 20
            li $a0, 110
            li $v0, 22  ;gotoxy
            syscall

            warningFace:
            li $v0, 4
            li $a0, hard
            syscall

            j parameters_loop

            EasyFace:
            li $v0, 4
            li $a0, Easy
            syscall








            j parameters_loop

            parameters_loop:
                beq $t1, $s2, up
                beq $t1, $s3, down

                up:
                    addi $t5, $t5, 1

                    move $a0, $t0
                    move $a1, $t1
                    li $v0, 22
                    syscall


                    li $v0, 11
                    li $a0, 94
                    syscall

                    j detect_param

                down:
                    addi $t5, $t5, -1

                    move $a0, $t0
                    move $a1, $t1
                    li $v0, 22
                    syscall


                    li $v0, 11
                    li $a0, 118
                    syscall
                j detect_param
                   

            detect_param:


                li $a1, 20
                li $a0, 100
                li $v0, 22  ;gotoxy
                syscall

                move $a0, $t5
                li $v0, 1
                syscall


                move $a0, $t0
                move $a1, $t1
                move $a2, $s4
                li $v0, 24
                syscall
                
                beq $t2, $zero, ready

                


                refresh_param:

                move $a0, $t0
                move $a1, $t1
                li $v0, 22
                syscall

                li $v0, 11
                li $a0, 32
                syscall

                move $t1, $v1

               

                j parameters_print


                ready:
                     li $s2, 27; limite arriba
                     li $s3, 29; limite abajo


                     li $t0, 93
                     li $t1, 27


                    li $a1, 25
                    li $a0, 90
                    li $v0, 22  ;gotoxy
                    syscall

                    li $v0, 4
                    li $a0, readys
                    syscall

                    li $a1, 27
                    li $a0, 94
                    li $v0, 22  ;gotoxy
                    syscall

                    li $v0, 4
                    li $a0, yes
                    syscall

                    li $a1, 29
                    li $a0, 94
                    li $v0, 22  ;gotoxy
                    syscall

                    li $v0, 4
                    li $a0, no
                    syscall
                print_r:
                     move $a0, $t0
                     move $a1, $t1
                     li $v0, 22
                     syscall 
                     li $v0, 11
                     li $a0, 62
                     syscall
                
                is_ready:
                    move $a0, $t0
                    move $a1, $t1
                    move $a2, $s4
                    li $v0, 24
                    syscall

                    bne $v1, $t1, refresh_ready
                    beq $t2, $zero, accepted_or_declined
                
                
                     j is_ready

                refresh_ready:
                
                    move $a0, $t0
                    move $a1, $t1
                    li $v0, 22
                    syscall

                    li $v0, 11
                    li $a0, 32
                    syscall

                    move $t1, $v1
                    j print_r

                accepted_or_declined:
                    li $t4, 20
                    beq $t1, $s2, game

                     li $t4, 22
                    beq $t1, $s3, no_wait










j main_menu


made_by:
        li $v0, 23; limpia pantalla
        syscall

        

        li $v0, 32; limpia pantalla
        syscall

         li $a0, 20
                li $a1, 20
                li $a2, 20
                li $v0, 24
                syscall


j main_menu


game:

    li $v0, 23; limpia pantalla
    syscall


    li $t7, 9
    li $t8, 9

    li $t1, 9
    li $t0, 78

    move $s0, $t0;limite izquierdo
    addi $s0, $s0, 2
    li $v0, 4
    mult $t7, $v0
    add $s1, $lo, $t0; limite derecho
    addi $s1, $s1, 2
    
    move $v0, $t1
    addi $v0, $v0, 2
    move $s2, $v0 ;limite de arriba

    add $v0, $v0, $t8
    add $v0, $v0, $t8
    move $s3, $v0



    li $t2, 0

    print_numberX:
            move $a1, $t1
            move $a0, $t0
            li $v0, 22  ;gotoxy
            syscall
            li $v0, 4
            li $a0, space0
            syscall
            j p
            number_loopX:

            
            li $v0, 4
            li $a0, space
            syscall
            p:
            li $v0, 1
            move $a0, $t2
            syscall
            addi $t2, $t2, 1
            beq $t7, $zero, print_table0
            addi $t7, $t7, -1

            j number_loopX






    print_table0:

    addi $t1, $t1, 1
    li $t7, 9
    li $t8, 9
    li $t2, 0

    

    print_table:
            move $a1, $t1
            move $a0, $t0
            li $v0, 22  ;gotoxy
            syscall
        print_top:
            li $v0, 4
            li $a0, top
            syscall

            beq $t7, $zero, end_top
            addi $t7, $t7, -1
            j print_top

        end_top:
            li $v0, 11
            li $a0, '-'
            syscall

            addi $t1, $t1, 1
            addi $t0, $t0, -1; comentar en caso de no ser necesario
            move $a1, $t1
            move $a0, $t0
            li $v0, 22  ;gotoxy
            syscall

            li $t7, 9
        print_numberY:

            
            li $v0, 1
            move $a0, $t2
            syscall
            addi $t2, $t2, 1
            addi $t0, $t0, 1
            
            move $a1, $t1
            move $a0, $t0
            li $v0, 22  ;gotoxy
            syscall

        print_cube:
            li $v0, 4
            li $a0, table
            syscall

            beq $t7, $zero, end_cube
            addi  $t7, $t7, -1
            j print_cube
        end_cube:

            li $v0, 11
            li $a0, '|'
            syscall

            addi $t1, $t1, 1
            li $t7, 9

            beq $t8, $zero, print_base0

            addi $t8, $t8, -1

            j print_table

        print_base0:

            li $t7, 9
            move $a1, $t1
            move $a0, $t0
            li $v0, 22  ;gotoxy
            syscall

            print_base:
                li $v0, 4
                li $a0, top
                syscall

                beq $t7, $zero, end_base

                addi $t7, $t7, -1

                j print_base

            end_base:
                li $v0, 11
                li $a0, '-'
                syscall

                addi $t1, $t1, 1
                

                
                

            



                
 





gameLogic:

addi $sp, $sp, -800 ; Reservo 800 bytes en la pila
         ;0 secure

         ;11~18 warning

         ;1 flag

         ;2 bomb

         li $s4, 2

        li $t0, 200 ;200 registros en los que se escribira data

        li $t9, 0; contador para posicionar el punterocada ciclo

        move $t6, $t5
        calc_secure_pos:

            sll $t7, $t9, 2; muevo el puntero al siguiente para guardar

            addu $t7, $t7, $sp ;posiciono para escribir 

            sw $zero, 0($t7); llenamos primero de zonas seguras

            addi $t9, $t9, 1; contador++

            addi $t0, $t0, -1;


            beq $zero, $t0, lets_plantBombs

            j calc_secure_pos
        

        lets_plantBombs:
            

            bomb_planting:

                li $v0, 29
                syscall
                move $t9, $v0

                
                sll $t7, $t9, 2; muevo el puntero al siguiente para guardar

                addu $t7, $t7, $sp ;posiciono para escribir 

                lw $t3, 0($t7)
                
              
                beq $t3, $s4, bomb_planting

                sw $s4, 0($t7); llenamos primero de zonas seguras
                
                warning:
                    warning1:
                        li $t4, 11
                        
                        slt $v0, $t9, $t4
                        bne $v0, $zero, warning2

                        move $t3, $t9; como quiero preservar $t9, lo paso a otro registro
                        sub $t3, $t3, $t4; en el warning 1 resto 11

                        sll $t7, $t3, 2; muevo el puntero al siguiente para guardar
                        addu $t7, $t7, $sp ;posiciono para escribir 
                        lw $t3, 0($t7); guardamos el valor de la zona de warning

                        beq $zero, $t9, warning5

                        li $t4, 10

                        beq $t4, $t9, warning2

                        addi $t4, $t4, 10 ;20

                        beq $t4, $t9, warning2

                        addi $t4, $t4, 10;30

                         beq $t4, $t9, warning2

                        addi $t4, $t4, 10;40

                         beq $t4, $t9, warning2

                        addi $t4, $t4, 10;50

                         beq $t4, $t9, warning2

                        addi $t4, $t4, 10;60

                         beq $t4, $t9, warning2

                        addi $t4, $t4, 10;70

                         beq $t4, $t9, warning2

                        addi $t4, $t4, 10;80

                         beq $t4, $t9, warning2

                        addi $t4, $t4, 10;90

                         beq $t4, $t9, warning2

                        beq $t3, $zero, base_warning1

                        beq $t3, $s4, warning2

                            addi $t3, $t3, 1
                            sw $t3, 0($t7); guardamos el valor a la zona de warning

                            j warning2

                        base_warning1:
                            li $t3, 11
                            sw $t3, 0($t7); guardamos el valor a la zona de warning

                    warning2:
                        li $t4, 10
                        
                        slt $v0, $t9, $t4
                        bne $v0, $zero, warning3

                        move $t3, $t9; como quiero preservar $t9, lo paso a otro registro
                        sub $t3, $t3, $t4; en el warning 2 resto 10

                        sll $t7, $t3, 2; muevo el puntero al siguiente para guardar
                        addu $t7, $t7, $sp ;posiciono para escribir 
                        lw $t3, 0($t7); guardamos el valor de la zona de warning

                       

                        beq $t3, $zero, base_warning2

                        beq $t3, $s4, warning3

                            addi $t3, $t3, 1
                            sw $t3, 0($t7); guardamos el valor a la zona de warning

                            j warning3

                        base_warning2:
                            li $t3, 11
                            sw $t3, 0($t7); guardamos el valor a la zona de warning

                    warning3:
                        li $t4, 9
                        
                        beq $t4, $t9, warning4

                        slt $v0, $t9, $t4
                        bne $v0, $zero, warning4

                        move $t3, $t9; como quiero preservar $t9, lo paso a otro registro
                        sub $t3, $t3, $t4; en el warning 3 resto 9

                        sll $t7, $t3, 2; muevo el puntero al siguiente para guardar
                        addu $t7, $t7, $sp ;posiciono para escribir 
                        lw $t3, 0($t7); guardamos el valor de la zona de warning

                        li $t4, 9

                        beq $t4, $t9, warning4

                        addi $t4, $t4, 10 ;19

                        beq $t4, $t9, warning4

                        addi $t4, $t4, 10;29

                        beq $t4, $t9, warning4

                        addi $t4, $t4, 10;39

                        beq $t4, $t9, warning4

                        addi $t4, $t4, 10;49

                        beq $t4, $t9, warning4

                        addi $t4, $t4, 10;59

                        beq $t4, $t9, warning4

                        addi $t4, $t4, 10;69

                        beq $t4, $t9, warning4

                        addi $t4, $t4, 10;79

                        beq $t4, $t9, warning4

                        addi $t4, $t4, 10;89

                        beq $t4, $t9, warning4

                        addi $t4, $t4, 10;99

                        beq $t4, $t9, warning4

                        beq $t3, $zero, base_warning3

                        beq $t3, $s4, warning4

                            addi $t3, $t3, 1
                            sw $t3, 0($t7); guardamos el valor a la zona de warning

                            j warning4

                        base_warning3:
                            li $t3, 11
                            sw $t3, 0($t7); guardamos el valor a la zona de warning
                warning4:
                        li $t4, 1
                        
                        slt $v0, $t9, $t4
                        bne $v0, $zero, warning5

                        move $t3, $t9; como quiero preservar $t9, lo paso a otro registro
                        sub $t3, $t3, $t4; en el warning 4 resto 1

                        sll $t7, $t3, 2; muevo el puntero al siguiente para guardar
                        addu $t7, $t7, $sp ;posiciono para escribir 
                        lw $t3, 0($t7); guardamos el valor de la zona de warning

                        li $t4, 10

                        beq $t4, $t9, warning5

                        addi $t4, $t4, 10 ;20

                        beq $t4, $t9, warning5

                        addi $t4, $t4, 10;30

                         beq $t4, $t9, warning5

                        addi $t4, $t4, 10;40

                         beq $t4, $t9, warning5

                        addi $t4, $t4, 10;50

                         beq $t4, $t9, warning5

                        addi $t4, $t4, 10;60

                         beq $t4, $t9, warning5

                        addi $t4, $t4, 10;70

                         beq $t4, $t9, warning5

                        addi $t4, $t4, 10;80

                         beq $t4, $t9, warning5

                        addi $t4, $t4, 10;90

                         beq $t4, $t9, warning5

                        beq $t3, $zero, base_warning4

                        beq $t3, $s4, warning5

                            addi $t3, $t3, 1
                            sw $t3, 0($t7); guardamos el valor a la zona de warning

                            j warning5

                        base_warning4:
                            li $t3, 11
                            sw $t3, 0($t7); guardamos el valor a la zona de warning

                warning5:
                        li $t4, 1
                        
                        slt $v0, $t9, $t4
                        bne $v0, $zero, warning6

                        move $t3, $t9; como quiero preservar $t9, lo paso a otro registro
                        add $t3, $t3, $t4; en el warning 5 sumo 1

                        sll $t7, $t3, 2; muevo el puntero al siguiente para guardar
                        addu $t7, $t7, $sp ;posiciono para escribir 
                        lw $t3, 0($t7); guardamos el valor de la zona de warning

                        li $t4, 9

                        beq $t4, $t9, warning6

                        addi $t4, $t4, 10 ;19

                        beq $t4, $t9, warning6

                        addi $t4, $t4, 10;29

                        beq $t4, $t9, warning6

                        addi $t4, $t4, 10;39

                        beq $t4, $t9, warning6

                        addi $t4, $t4, 10;49

                        beq $t4, $t9, warning6

                        addi $t4, $t4, 10;59

                        beq $t4, $t9, warning6

                        addi $t4, $t4, 10;69

                        beq $t4, $t9, warning6

                        addi $t4, $t4, 10;79

                        beq $t4, $t9, warning6

                        addi $t4, $t4, 10;89

                        beq $t4, $t9, warning6

                        addi $t4, $t4, 10;99

                        beq $t4, $t9, warning6

                        beq $t3, $zero, base_warning5

                        beq $t3, $s4, warning6

                            addi $t3, $t3, 1
                            sw $t3, 0($t7); guardamos el valor a la zona de warning

                            j warning6

                        base_warning5:
                            li $t3, 11
                            sw $t3, 0($t7); guardamos el valor a la zona de warning

                warning6:
                        
                        
                        beq $t9, $zero, warning7

                        li $t4, 90

                        slt $v0, $t9, $t4
                        beq $v0, $zero, warning7


                        li $t4, 9
                        move $t3, $t9; como quiero preservar $t9, lo paso a otro registro
                        add $t3, $t3, $t4; en el warning 6 sumo 9

                        sll $t7, $t3, 2; muevo el puntero al siguiente para guardar
                        addu $t7, $t7, $sp ;posiciono para escribir 
                        lw $t3, 0($t7); guardamos el valor de la zona de warning

                        li $t4, 10

                        beq $t4, $t9, warning7

                        addi $t4, $t4, 10 ;20

                        beq $t4, $t9, warning7

                        addi $t4, $t4, 10;30

                         beq $t4, $t9, warning7

                        addi $t4, $t4, 10;40

                         beq $t4, $t9, warning7

                        addi $t4, $t4, 10;50

                         beq $t4, $t9, warning7

                        addi $t4, $t4, 10;60

                         beq $t4, $t9, warning7

                        addi $t4, $t4, 10;70

                         beq $t4, $t9, warning7

                        addi $t4, $t4, 10;80

                         beq $t4, $t9, warning7

                        addi $t4, $t4, 10;90

                         beq $t4, $t9, warning7

                        beq $t3, $zero, base_warning6

                        beq $t3, $s4, warning7

                            addi $t3, $t3, 1
                            sw $t3, 0($t7); guardamos el valor a la zona de warning

                            j warning7

                        base_warning6:
                            li $t3, 11
                            sw $t3, 0($t7); guardamos el valor a la zona de warning

                warning7:

                        li $t4, 90

                        slt $v0, $t9, $t4
                        beq $v0, $zero, warning8


                        li $t4, 10

                        move $t3, $t9; como quiero preservar $t9, lo paso a otro registro
                        add $t3, $t3, $t4; en el warning 7 sumo 10

                        sll $t7, $t3, 2; muevo el puntero al siguiente para guardar
                        addu $t7, $t7, $sp ;posiciono para escribir 
                        lw $t3, 0($t7); guardamos el valor de la zona de warning

                       

                        beq $t3, $zero, base_warning7

                        beq $t3, $s4, warning8

                            addi $t3, $t3, 1
                            sw $t3, 0($t7); guardamos el valor a la zona de warning

                            j warning8

                        base_warning7:
                            li $t3, 11
                            sw $t3, 0($t7); guardamos el valor a la zona de warning
                
                warning8:


                        li $t4, 90

                        slt $v0, $t9, $t4
                        beq $v0, $zero, warning9


                        li $t4, 11

                        move $t3, $t9; como quiero preservar $t9, lo paso a otro registro
                        add $t3, $t3, $t4; en el warning 8 sumo 11

                        sll $t7, $t3, 2; muevo el puntero al siguiente para guardar
                        addu $t7, $t7, $sp ;posiciono para escribir 
                        lw $t3, 0($t7); guardamos el valor de la zona de warning

                        li $t4, 9

                        beq $t4, $t9, warning9

                        addi $t4, $t4, 10 ;19

                        beq $t4, $t9, warning9

                        addi $t4, $t4, 10;29

                        beq $t4, $t9, warning9

                        addi $t4, $t4, 10;39

                        beq $t4, $t9, warning9

                        addi $t4, $t4, 10;49

                        beq $t4, $t9, warning9

                        addi $t4, $t4, 10;59

                        beq $t4, $t9, warning9

                        addi $t4, $t4, 10;69

                        beq $t4, $t9, warning9

                        addi $t4, $t4, 10;79

                        beq $t4, $t9, warning9

                        addi $t4, $t4, 10;89

                        beq $t4, $t9, warning9

                        addi $t4, $t4, 10;99

                        beq $t4, $t9, warning9

                        beq $t3, $zero, base_warning8

                        beq $t3, $s4, warning9

                            addi $t3, $t3, 1
                            sw $t3, 0($t7); guardamos el valor a la zona de warning

                            j warning9

                        base_warning8:
                            li $t3, 11
                            sw $t3, 0($t7); guardamos el valor a la zona de warning
                warning9:


                

                addi $t5, $t5, -1;


                beq $zero, $t5, end_bombplanting

                j bomb_planting

                end_bombplanting:

                li $a0, 0
                li $a1, 0
                li $v0, 22
                syscall

                move $a0, $t6
                li $v0, 33
                syscall


        
        
        
        lets_play:

        move $t0, $s0
        
        move $t1, $s2

        
         

        li $s5, 0

         printPlayer:
                

                move $a0, $t0
                move $a1, $t1
                li $v0, 22
                syscall


                li $v0, 11
                li $a0, 62
                syscall

            detect_Player:
                move $a0, $t0
                move $a1, $t1
                move $a2, $s4
                
                li $v0, 24
                syscall
                move $t3, $v0
                
                
               

                bne $v1, $t1, refresh_playerMove
                bne $t3, $t0, refresh_playerMove

                li $v0, 1 ;chekea bandera
                beq $t2, $v0, flag

                li $v0, 2; chekea excavacion
                beq $t2, $v0, dig
                
                
                j detect_Player

                refresh_playerMove:
                        move $a0, $t0
                        move $a1, $t1
                        li $v0, 22
                        syscall


                        li $v0, 11
                        li $a0, 62
                        syscall
                    
                    move $t1, $v1
                    move $t0, $t3
            
                       

                    j show_data
                

                

            dig:

                
               
                j refresh_table

            flag:
                move $a0, $t0
                move $a1, $t1
                li $v0, 22
                syscall

                
                li $v0, 11
                li $a0, 'F'
                syscall

                move $t4, $s5
                 
               
                sll $t7, $t4, 2; muevo el puntero al siguiente para guardar

                addu $t7, $t7, $sp ;posiciono para escribir

                lw $t5, 0($t7)
                
                li $t8, 2

                bne $t5, $t8, bombRedux

                addi $t6, $t6, -1

                li $a0, 0
                li $a1, 0
                li $v0, 22
                syscall

                move $a0, $t6
                li $v0, 33
                syscall


                bombRedux:
                li $t8, 1
                sw $t8, 0($t7)

                beq $t6, $zero, gamewin


                 addi $t4, $s5, 100
               
                sll $t7, $t4, 2; muevo el puntero al siguiente para guardar

                addu $t7, $t7, $sp ;posiciono para escribir

                li $t8, 1
                sw $t8, 0($t7)

                




                
                

                j detect_Player

            refresh_table:

                addi $t4, $s5, 100

                sll $t7, $t4, 2; muevo el puntero al siguiente para guardar

                addu $t7, $t7, $sp ;posiciono para escribir

                lw $t5, 0($t7)

                beq $t5, $zero, show_data0

                j detect_Player

                show_data0:

                    li $t5, 1
                    sw $t5, 0($t7)

                show_data:

                    li $t4, 100

                    show_data_cicle:

                        li $t5, 200
                        beq $t4, $t5, end_show

                    sll $t7, $t4, 2; muevo el puntero al siguiente para guardar

                    addu $t7, $t7, $sp ;posiciono para escribir

                    lw $t5, 0($t7)

                    beq $t5, $zero, print_unknown
                    
                        addi $t5, $t4, -100
                        
                        move $s6, $s0 ;x
                        move $s7, $s2 ;y
                        li $t8, 10
                        div $t5, $t8

                        li $v0, 4
                        mult $hi, $v0
                        add $s6, $s6, $lo
                        addi $s6, $s6, 1; posicion en x

                        li $t8, 10
                        div $t5, $t8
                        
                        li $v0, 2
                        mult $lo, $v0
                        add $s7, $s7, $lo; posicion en y

                        sll $t7, $t5, 2; muevo el puntero al siguiente para guardar

                        addu $t7, $t7, $sp ;posiciono para escribir

                        lw $t9, 0($t7)
                        
                        move $t5, $zero
                        beq $t9, $t5, print_secure

                        addi $t5, $t5, 1
                        beq $t9, $t5, print_flag

                        addi $t5, $t5, 1
                        beq $t9, $t5, print_bomb

                        

                        addi $t9, $t9, -10
                            addi $s6, $s6, -1
                            move $a0, $s6
                            move $a1, $s7
                            li $v0, 22
                            syscall

                            li $v0, 30
                            syscall

                            li $v0, 1
                            move $a0, $t9
                            syscall

                            li $v0, 31
                            syscall
                        j printed
                        
                        print_secure:

                            

                            addi $s6, $s6, -1
                            move $a0, $s6
                            move $a1, $s7
                            li $v0, 22
                            syscall

                            li $v0, 11
                            li $a0, 32
                            syscall

                            reveal_secure1:
                                        addi $t5, $t4, -100

                                         beq $t5, $zero, reveal_secure5
                                        
                                        li $t3, 10

                                         beq $t5, $t3, reveal_secure4

                                         addi $t3, $t3, 10 ;20

                                         beq $t5, $t3, reveal_secure4

                                         addi $t3, $t3, 10;30

                                          beq $t5, $t3, reveal_secure4

                                        addi $t3, $t3, 10;40

                                          beq $t5, $t3, reveal_secure4

                                         addi $t3, $t3, 10;50

                                          beq $t5, $t3, reveal_secure4

                                        addi $t3, $t3, 10;60

                                          beq $t5, $t3, reveal_secure4

                                         addi $t3, $t3, 10;70

                                          beq $t5, $t3, reveal_secure4

                                         addi $t3, $t3, 10;80

                                          beq $t5, $t3, reveal_secure4

                                         addi $t3, $t3, 10;90

                                          beq $t5, $t3, reveal_secure4

                                            li $t3, 11

                                            slt $v0, $t5, $t3

                                            bne $v0, $zero, reveal_secure2

                                         sub $t5, $t5, $t3
                                         addi $t5, $t5, 100

                                        sll $t7, $t5, 2; muevo el puntero al siguiente para guardar

                                         addu $t7, $t7, $sp ;posiciono para escribir

                                        li $t5, 1
                                         sw $t5, 0($t7)

                            reveal_secure2:
                                addi $t5, $t4, -100

                                       

                                         beq $t5, $zero, reveal_secure5

                                li $t3, 1
                                 sub $t5, $t5, $t3

                                 addi $t5, $t5, 100
                                 sll $t7, $t5, 2; muevo el puntero al siguiente para guardar

                                 addu $t7, $t7, $sp ;posiciono para escribir

                                 li $t5, 1
                                 sw $t5, 0($t7)

                            reveal_secure3:
                                addi $t5, $t4, -100

                                beq $t5, $zero, reveal_secure5

                                li $t3, 90

                                slt $v0, $t5, $t3

                                beq $v0, $zero, reveal_secure4
                                        
                                

                                
                                 addi $t5, $t5, 9

                                 addi $t5, $t5, 100

                                 sll $t7, $t5, 2; muevo el puntero al siguiente para guardar

                                 addu $t7, $t7, $sp ;posiciono para escribir

                                 li $t5, 1
                                 sw $t5, 0($t7)
                            
                            reveal_secure4:
                                        addi $t5, $t4, -100

                                        li $t3, 10

                                        slt $v0, $t5, $t3

                                        bne $v0, $zero, reveal_secure5

                                         sub $t5, $t5, $t3
                                         addi $t5, $t5, 100

                                        sll $t7, $t5, 2; muevo el puntero al siguiente para guardar

                                         addu $t7, $t7, $sp ;posiciono para escribir

                                        li $t5, 1
                                         sw $t5, 0($t7)

                            reveal_secure5:
                                        addi $t5, $t4, -100

                                        li $t3, 90

                                        slt $v0, $t5, $t3

                                        beq $v0, $zero, reveal_secure6
                                        
                                        li $t3, 10
                                         add $t5, $t5, $t3
                                         addi $t5, $t5, 100

                                        sll $t7, $t5, 2; muevo el puntero al siguiente para guardar

                                         addu $t7, $t7, $sp ;posiciono para escribir

                                        li $t5, 1
                                         sw $t5, 0($t7)

                            reveal_secure6:
                                        addi $t5, $t4, -100

                                         li $t3, 99

                                         beq $t5, $t3, reveal_secure9
                                        
                                        li $t3, 9

                                         beq $t5, $t3, reveal_secure9

                                         addi $t3, $t3, 10 ;19

                                         beq $t5, $t3, reveal_secure9

                                         addi $t3, $t3, 10;29

                                          beq $t5, $t3, reveal_secure9

                                        addi $t3, $t3, 10;39

                                          beq $t5, $t3, reveal_secure9

                                         addi $t3, $t3, 10;49

                                          beq $t5, $t3, reveal_secure9

                                        addi $t3, $t3, 10;59

                                          beq $t5, $t3, reveal_secure9

                                         addi $t3, $t3, 10;69

                                          beq $t5, $t3, reveal_secure9

                                         addi $t3, $t3, 10;79

                                          beq $t5, $t3, reveal_secure9

                                         addi $t3, $t3, 10;89

                                          beq $t5, $t3, reveal_secure9

                                            li $t3, 9

                                            slt $v0, $t5, $t3

                                            bne $v0, $zero, reveal_secure7

                                           

                                         sub $t5, $t5, $t3
                                         addi $t5, $t5, 100

                                        sll $t7, $t5, 2; muevo el puntero al siguiente para guardar

                                         addu $t7, $t7, $sp ;posiciono para escribir

                                        li $t5, 1
                                         sw $t5, 0($t7)

                                
                                reveal_secure7:

                                        addi $t5, $t4, -100

                                            
                                            addi $t5, $t5, 1

                                            addi $t5, $t5, 100
                                            sll $t7, $t5, 2; muevo el puntero al siguiente para guardar

                                            addu $t7, $t7, $sp ;posiciono para escribir

                                         li $t5, 1
                                         sw $t5, 0($t7)

                                reveal_secure8:

                                     addi $t5, $t4, -100

                                             li $t3, 90

                                             slt $v0, $t5, $t3

                                            beq $v0, $zero, reveal_secure9

                                           
                                            addi $t5, $t5, 11

                                            addi $t5, $t5, 100

                                            sll $t7, $t5, 2; muevo el puntero al siguiente para guardar

                                            addu $t7, $t7, $sp ;posiciono para escribir

                                         li $t5, 1
                                         sw $t5, 0($t7)

                                reveal_secure9:




                            j printed

                        print_flag:
                            addi $s6, $s6, -1
                            move $a0, $s6
                            move $a1, $s7
                            li $v0, 22
                            syscall

                            li $v0, 11
                            li $a0, 'F'
                            syscall


                        j printed

                        print_bomb:
                            addi $s6, $s6, -1
                            move $a0, $s6
                            move $a1, $s7
                            li $v0, 22
                            syscall

                            li $v0, 11
                            li $a0, 'X'
                            syscall


                        j gamelose



                    print_unknown:
                        addi $t5, $t4, -100
                        
                        move $s6, $s0 ;x
                        move $s7, $s2 ;y
                        li $t8, 10
                        div $t5, $t8

                        li $v0, 4
                        mult $hi, $v0
                        add $s6, $s6, $lo
                        addi $s6, $s6, 1; posicion en x

                        li $t8, 10
                        div $t5, $t8
                        
                        li $v0, 2
                        mult $lo, $v0
                        add $s7, $s7, $lo; posicion en y
                        addi $s6, $s6, -1
                        move $a0, $s6
                        move $a1, $s7
                        li $v0, 22
                        syscall

                        li $v0, 11
                        li $a0, 63
                        syscall

                    printed:

                    addi $t4, $t4, 1

                    j show_data_cicle

                end_show:

                j printPlayer
                    


            
                    





        



       

j gameLogic

gamewin:

        li $a1, 28
        li $a0, 80
        li $v0, 22  ;gotoxy
        syscall
            li $v0, 4
            li $a0, youwin
            syscall


                
                move $a2, $s4
                li $v0, 24
                syscall
j main_menu

gamelose:

        li $a1, 28
        li $a0, 90
        li $v0, 22  ;gotoxy
        syscall
            li $v0, 4
            li $a0, youlose
            syscall


                
                move $a2, $s4
                li $v0, 24
                syscall
j main_menu


main:

    ;prologo de la funcion
    ;guardamos el ra del main
    ;recordando que $sp es el stack pointer
    addi $sp, $sp, -4 ; Reservo 4 bytes en la pila
    sw $ra, 0($sp) ;Guardar el registro $ra

    jal main_menu

    lw $ra, 0($sp)
    addi $sp, $sp, 4

    jr $ra

