extern scanf, printf, strncmp

section .rodata
    fin_dec db "%d", 0
    fin_str db "%s", 0
    
section .data
    count dd 1
    str_len dd 10
    
section .bss
    N resd 1
    str_arr resb 5500
    strings resb 500

section .text
global main
main:
    push ebp
    mov ebp, esp
    and esp, -16
    sub esp, 16
    mov dword[esp], fin_dec
    mov dword[esp + 4], N
    call scanf
    mov esi, dword[N]
    dec esi
    test esi, esi
    je .end
    mov dword[esp], fin_str
    mov dword[esp + 4], str_arr
    call scanf
    mov esi, 1; esi - counter for loop
.l1:
    mov eax, dword[count]
    imul eax, 11
    lea eax, [str_arr + eax]
    mov dword[esp], fin_str
    mov dword[esp + 4], eax
    call scanf
    xor edi, edi
.l2:
    mov ebx, edi
    imul ebx, 11
    lea ebx, [str_arr + ebx]
    mov dword[esp], ebx
    mov ecx, dword[str_len]
    mov dword[esp + 8], ecx
    call strncmp
    test eax, eax
    je .l3
    inc edi
    cmp edi, dword[count]
    jne .l2
    inc dword[count]
.l3:    
    inc esi
    cmp esi, dword[N]
    jne .l1
    
.end:
    mov eax, dword[count]
    mov dword[esp], fin_dec
    mov dword[esp + 4], eax
    call printf
    add esp, 16
    leave
    xor eax, eax
    ret
