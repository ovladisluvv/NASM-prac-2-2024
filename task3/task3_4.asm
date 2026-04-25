extern io_get_udec, io_print_udec, io_newline

section .text
global main
main:
    mov ebp, esp; for correct debugging
    call io_get_udec ; eax = x
    test eax, eax
    je zero
    mov ebx, eax ; ebx = x
    mov edx, ebx ; edx = x - temp to print
    shr edx, 30
    mov eax, edx
    mov esi, 10 ; esi = 10 - counter for "for" loop
    mov edi, 0 ; edi - flag for first zero
    shl ebx, 2
    test eax, eax
    je l1
    inc edi    
    call io_print_udec

l1:
    mov edx, ebx
    shr edx, 29
    shl ebx, 3
    dec esi
    mov eax, edx
    test eax, eax
    jne l2
    test edi, edi
    je l1
l2:
    inc edi
    call io_print_udec
    test esi, esi
    jne l1
    call io_newline
    xor eax, eax
    ret
    
zero:
    call io_print_udec
    call io_newline
    xor eax, eax
    ret
