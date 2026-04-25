extern io_get_udec, io_print_udec, io_newline

global main
section .text

main:
    call io_get_udec
    mov bl, al
    ror ebx, 8
    call io_get_udec
    mov bl, al
    ror ebx, 8
    call io_get_udec
    mov bl, al
    ror ebx, 8
    call io_get_udec
    mov bl, al
    ror ebx, 8
    mov eax, ebx
    call io_print_udec
    call io_newline  
    xor eax, eax
    ret
