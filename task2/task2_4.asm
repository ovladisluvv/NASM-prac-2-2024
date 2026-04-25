extern io_get_dec, io_print_dec, io_newline

section .bss
    X resd 1

global main
section .text
main:
    call io_get_dec ; Ввод X
    mov dword[X], eax
    call io_get_dec ; Ввод N
    mov ebx, eax ; ebx = N
    call io_get_dec ; Ввод M
    sub ebx, eax ; ebx = N - M
    call io_get_dec ; Ввод Y
    sub eax, 2011
    imul eax, ebx
    add eax, dword[X]
    call io_print_dec
    call io_newline
    xor eax, eax
    ret
