#set byte [0x10000000] = ["The sum of squares is: ", 0]
call main

; Exit program
mov eax, 10
int 0x80

sum:

    push esi
    mov ecx, 0 ; sum
    mov esi, 0 ; i


    fors:
    
    cmp esi, dword[esp + 12]
    
    jge end_for

    mov eax, [esp + 8]
    mov eax, [eax + esi *4]; equivalente a arr[i]

    mul eax

    add ecx, eax

    add esi, 1

    

    jmp fors

    end_for:

    mov eax, ecx
    pop esi
    ; TODO: Implement 'sum' function
    ret

main:
    push	ebp
    mov	ebp, esp
    push	esi
    push	ebx
    push	ecx
    xor	esi, esi
    sub	esp, 76
    mov	eax, 10
    mov	DWORD PTR [ebp - 80], 10
    mov	DWORD PTR [ebp - 76], 43
    mov	DWORD PTR [ebp - 72], 41
    mov	DWORD PTR [ebp - 68], 5
    mov	DWORD PTR [ebp - 64], 45
    mov	DWORD PTR [ebp - 60], 50
    mov	DWORD PTR [ebp - 56], 22
    mov	DWORD PTR [ebp - 52], 86
    mov	DWORD PTR [ebp - 48], 10
    mov	DWORD PTR [ebp - 44], 20
    mov	DWORD PTR [ebp - 40], 55
    mov	DWORD PTR [ebp - 36], 52
    mov	DWORD PTR [ebp - 32], 65

    lea	edx, [ebp - 80]
    push 13
    push edx
    call sum
    add esp, 8

    mov esi ,eax
    sub	esp, 12
    push	0x10000000
    call	print_str
    mov	DWORD PTR [esp], esi
    call	print_int
    mov	DWORD PTR [esp], 10
    call	print_char
    add	esp, 16
    xor	eax, eax
    pop	ecx
    pop	ebx
    pop	esi
    mov esp, ebp
    pop	ebp
    ret

print_str:
    mov eax, 4
    mov ebx, dword [esp + 4]
    int 0x80
    ret

print_int:
    mov eax, 1
    mov ebx, dword [esp + 4]
    int 0x80
    ret

print_char:
    mov eax, 11
    mov ebx, dword [esp + 4]
    int 0x80
    ret
