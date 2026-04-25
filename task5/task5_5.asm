extern scanf, printf, malloc, free

section .rodata
    fin db "%u", 0
    fout db "%u", 10, 0

section .bss
    size resd 1
    ans resd 1
    a_i resd 1
    a resd 1
    
section .text
global main
main:
    push ebp
    mov ebp, esp
    and esp, -16
    sub esp, 16
    mov dword[esp], 8000000
    call malloc
    mov dword[a], eax
.l1:
    mov dword[esp], fin
    lea edx, [a_i]
    mov dword[esp + 4], edx
    call scanf
    mov esi, dword[a_i]; esi = a_i
    test esi, esi
    je .l3
.l2:
    mov ecx, dword[a]
    mov ebx, dword[size]
    mov dword[ecx + ebx * 4], esi
    inc dword[size]
    jmp .l1
    
.l3:
    mov ecx, dword[size]
    test ecx, ecx
    je .end
    mov ebx, dword[a]
    mov edi, dword[ebx + ecx * 4 - 4]
.l4:
    cmp edi, dword[ebx + ecx * 4 - 4]
    jle .l5
    inc dword[ans]
.l5:
    loop .l4
    
.end:
    mov dword[esp], fout
    mov esi, dword[ans]
    mov dword[esp + 4], esi
    call printf
    mov ebx, dword[a]
    mov dword[esp], ebx
    call free
    add esp, 16
    leave
    xor eax, eax
    ret
