extern io_get_char, io_print_dec, io_newline

section .data
 two dd 2

global main
section .text
main:    
    call io_get_char
    sub eax, 'A'
    inc eax
    mov ebx, eax
    sub ebx, 8
    neg ebx
    call io_get_char
    sub eax, '0'
    sub eax, 8
    neg eax
    imul eax, ebx
    div dword[two]
    call io_print_dec
    call io_newline
    xor eax, eax
    ret
