extern scanf, printf, malloc, free

section .rodata
    fin db "%d", 0
    fout db "%d", 10, 0
    
section .bss
    n resd 1
    arr resd 1

section .text
global main
main:
    push ebp
    mov ebp, esp
    and esp, -16
    sub esp, 32
    mov dword[esp], fin
    mov dword[esp + 4], n
    call scanf
    mov eax, dword[n]
    imul eax, 4
    mov dword[esp], eax
    call malloc
    mov dword[arr], eax
    xor edi, edi; edi - counter for loop
    mov dword[esp], fin;
    mov dword[esp + 4], eax; 

.l:
    call scanf
    add dword[esp + 4], 4;
    inc edi
    cmp edi, dword[n]
    jne .l
    
    mov eax, dword[arr]
    mov dword[esp], eax
    mov dword[esp + 4], edi
    mov dword[esp + 8], printf
    mov dword[esp + 12], 1
    mov dword[esp + 16], fout
    call apply
    mov eax, dword[arr]
    mov dword[esp], eax
    call free
    add esp, 32
    leave
    xor eax, eax
    ret
    
apply:
    push ebp
    mov ebp, esp
    push esi
    push edi
    sub esp, 24
    xor esi, esi; esi - counter for loop

    .l1:
        mov eax, dword[ebp + 24 + 4 * esi]
        mov dword[esp + esi * 4], eax
        inc esi
        cmp esi, dword[ebp + 20]
        jne .l1
    mov edi, esi
    xor esi, esi; esi - counter for loop

    .l2:
        mov eax, dword[ebp + 8]
        mov eax, dword[eax + 4 * esi]
        mov dword[esp + 4 * edi], eax
        call dword[ebp + 16]
        inc esi
        cmp esi, dword[ebp + 12]
        jne .l2
    add esp, 24
    pop edi
    pop esi
    leave
    ret
