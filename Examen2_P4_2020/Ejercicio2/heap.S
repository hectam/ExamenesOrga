#set byte [0x10000000] = ["Array representation of Heap is:", 10, 0]
call main

; Exit program
mov eax, 10
int 0x80

swap:
    push ebx
    mov	edx, DWORD [esp + 8]
    mov	eax, DWORD [esp + 12]
    mov	ecx, DWORD [edx]
    mov	ebx, DWORD [eax]
    mov	DWORD [edx], ebx
    mov	DWORD [eax], ecx
    pop	ebx
    ret

heapify:
    push esi

    mov esi, dword[esp + 16]; lagest

    mov eax, dword[esp + 16]
    mul eax
    mov ebx, 2
    mul ebx

    add eax, 1

    mov ecx, eax; l

    mov eax, dword[esp + 16]
    mul eax
    mov ebx, 2
    mul ebx

    add eax, 2

    mov edx, eax; r

    if10:
    cmp ecx, dword[esp + 12]
    jge endif10

    mov eax, [esp + 8]

    mov eax, [eax + ecx * 4]; arr[l]

    mov ebx, [esp + 8]

    mov ebx, [ebx + esi * 4]; arr[largest]

    cmp eax, ebx

    jl endif10
    
    mov esi, ecx

    endif10:

    if20:
    cmp edx, dword[esp + 12]
    jge endif20

    mov eax, [esp + 8]

    mov eax, [eax + edx * 4]; arr[r]

    mov ebx, [esp + 8]

    mov ebx, [ebx + esi * 4]; arr[largest]

    cmp eax, ebx

    jl endif20
    
    mov esi, edx

    endif20:


    if30:
        cmp esi, dword[esp + 16]
        je endif30
        

        sub esp, 8
        mov ebx, [esp + 8]
        mov ebx, [ebx + dword[esp + 16] * 4]
        lea eax, ebx
        push eax

        
        mov ebx, [esp + 8]
        mov ebx, [ebx + esi * 4]
        lea eax, ebx
        push eax

        call swap

        add esp, 8

        sub esp, 12

        push esi

        push dword[esp +12]

        push dword[esp + 8]

        call heapify

        add esp, 12
        


    endif30:




    pop esi
    
    ; TODO: Implement heapify function
    ret

buildHeap:
    mov ecx,dword[esp + 8]

    sar ecx, 1

    sub ecx, 1; startIdx
    
    mov eax, ecx; i

    mov ebx, 0

    for:
    cmp eax, ebx

    jl endfor

    sub esp, 12

    push eax

    push dword[esp + 8]

    push dword[esp + 4]


    call heapify

    add esp, 12

    dec eax

    endfor:

    
    ; TODO: Implement buildHeap function
    ret

printHeap:
    push	ebp
    push	edi
    push	esi
    push	ebx
    sub	esp, 24
    mov	ebp, DWORD [esp+44]
    mov	edi, DWORD [esp+48]
    push 0x10000000
    call	print_str
    add	esp, 16
    test	edi, edi
    jle	$L14
    mov	esi, ebp
    lea	edi, [ebp+edi*4]
$L15:
    sub	esp, 12
    push	DWORD [esi]
    call	print_int
    mov	DWORD [esp], 32
    call	print_char
    add	esi, 4
    add	esp, 16
    cmp	esi, edi
    jne	$L15
$L14:
    sub	esp, 12
    push	10
    call	print_char
    add	esp, 28
    pop	ebx
    pop	esi
    pop	edi
    pop	ebp
    ret

main:
    push	ebp
    mov	ebp, esp
    push	esi
    push	ebx
    push	ecx
    sub	esp, 68
    mov	ebx, 20
    mov	DWORD [ebp-72], 1
    mov	DWORD [ebp-68], 3
    mov	DWORD [ebp-64], 5
    mov	DWORD [ebp-60], 4
    mov	DWORD [ebp-56], 6
    mov	DWORD [ebp-52], 13
    mov	DWORD [ebp-48], 10
    mov	DWORD [ebp-44], 9
    mov	DWORD [ebp-40], 8
    mov	DWORD [ebp-36], 15
    mov	DWORD [ebp-32], 17
    push	11
    lea	esi, [ebp-72]
    push	esi
    call	buildHeap
    add	esp, 8
    push	11
    push	esi
    call	printHeap
    add	esp, 16
    mov	eax, 0
    lea	esp, [ebp-12]
    pop	ecx
    pop	ebx
    pop	esi
    leave
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
