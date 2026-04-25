extern io_get_dec, io_print_dec, io_newline

section .data
    three dd 3
    
section .bss
    beets resd 1
    boxes resd 1
    hours resd 1
    
global main
section .text

main:
    call io_get_dec
    mov ebx, eax
    call io_get_dec
    imul ebx, eax
    call io_get_dec
    imul eax, ebx
    mov dword[beets], eax
    call io_get_dec
    mov ebx, eax
    mov eax, dword[beets]
    dec eax
    add eax, ebx
    xor edx, edx
    idiv ebx
    mov dword[boxes], eax
    call io_get_dec
    sub eax, 6
    sar eax, 31
    inc eax
    mov ebx, eax
    mov eax, dword[boxes]
    dec eax
    xor edx, edx
    idiv dword[three]
    inc eax 
    imul ebx, eax
    mov eax, dword[boxes]
    sub eax, ebx
    call io_print_dec
    xor eax, eax
    ret
