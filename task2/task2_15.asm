extern io_get_dec, io_print_char, io_print_dec, io_newline

section .data
    two dd 2
    
section .bss
    x1 resd 1
    y1 resd 1
    x2 resd 1
    y2 resd 1
    x3 resd 1
    y3 resd 1

global main
section .text

main:
    call io_get_dec
    mov dword[x1], eax
    call io_get_dec
    mov dword[y1], eax
    call io_get_dec
    mov dword[x2], eax
    call io_get_dec
    mov dword[y2], eax
    call io_get_dec
    mov dword[x3], eax
    call io_get_dec
    mov dword[y3], eax
    mov ebx, dword[y2] ; S = 1/2|(x1(y2 - y3) + x2(y3 - y1) + x3(y1 - y2))|
    sub ebx, eax
    imul ebx, dword[x1]
    mov ecx, eax
    sub ecx, dword[y1]
    imul ecx, dword[x2]
    mov eax, dword[y1]
    sub eax, dword[y2]
    imul eax, dword[x3]
    add eax, ebx
    add eax, ecx
    mov edx, eax ; начало вычисления модуля
    sar edx, 31
    xor eax, edx
    sub eax, edx ; конец вычисления модуля
    xor edx, edx
    div dword[two]
    mov ebx, edx
    call io_print_dec
    mov eax, '.'
    call io_print_char
    mov eax, ebx
    imul eax, 5
    call io_print_dec
    call io_newline
    xor eax, eax
    ret
