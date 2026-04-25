extern io_get_udec, io_print_udec, io_print_char, io_newline

section .bss
    a11 resd 1
    a12 resd 1
    a21 resd 1
    a22 resd 1
    b1 resd 1
    b2 resd 1
    
global main
section .text

main:
    mov ebp, esp; for correct debugging
    call io_get_udec
    mov dword[a11], eax
    call io_get_udec
    mov dword[a12], eax
    call io_get_udec
    mov dword[a21], eax
    call io_get_udec
    mov dword[a22], eax
    call io_get_udec
    mov dword[b1], eax
    call io_get_udec
    mov dword[b2], eax
    mov eax, dword[a12] ; eax = a12
    xor eax, -1 ; eax = ㄱa12
    and eax, dword[b1] ; eax = ㄱa12 * b1
    mov ebx, dword[a21] ; ebx = a21
    and ebx, dword[b1] ; ebx = a21 * b1
    xor ebx, dword[b2] ; ebx = a21 * b1 + b2
    xor ebx, dword[b1] ; ebx = a21 * b1 + b2 + b1
    and ebx, dword[a12] ; ebx = a12 * (a21 * b1 + b2 + b1)
    xor eax, ebx ; eax = ㄱa12 * b1 + a12 * (a21 * b1 + b2 + b1)
    and eax, dword[a11] ; eax = a11 * (ㄱa12 * b1 + a12 * (a21 * b1 + b2 + b1))
    mov ebx, dword[a11] ; ebx = a11
    xor ebx, -1 ; ebx = ㄱa11
    mov ecx, dword[b1] ; ecx = b1
    and ecx, dword[a22] ; ecx = b1 * a22
    xor ecx, dword[b2] ; ecx = b1 * a22 + b2
    and ecx, dword[a12] ; ecx = a12 * (b1 * a22 + b2)
    mov edx, dword[a12] ; edx = a12
    xor edx, -1 ; edx = ㄱa12
    and edx, dword[b2] ; edx = ㄱa12 * b2
    xor ecx, edx ; ecx = a12 * (b1 * a22 + b2) + ㄱa12 * b2
    and ebx, ecx ; ebx = ㄱa11 * (a12 * (b1 * a22 + b2) + ㄱa12 * b2)
    xor eax, ebx ; eax = x = a11 * (ㄱa12 * b1 + a12 * (a21 * b1 + b2 + b1)) + ㄱa11 * (a12 * (b1 * a22 + b2) + ㄱa12 * b2)
    call io_print_udec ; x printed
    mov eax, ' '
    call io_print_char
    mov eax, dword[a11] ; eax = a11
    xor eax, -1 ; eax = ㄱa11
    mov ebx, dword[a12] ; ebx = a12
    xor ebx, -1 ; ebx = ㄱa12
    mov ecx, dword[a21] ; ecx = a21
    xor ecx, -1 ; ecx = ㄱa21
    and ebx, ecx ; ebx = ㄱa12 * ㄱa21
    and ebx, dword[b2] ; ebx = ㄱa12 * ㄱa21 * b2
    mov ecx, dword[a12] ; ecx = a12
    and ecx, dword[b1] ; ecx = a12 * b1
    xor ebx, ecx ; ebx = ㄱa12 * ㄱa21 * b2 + a12 * b1
    and eax, ebx ; eax = ㄱa11 * (ㄱa12 * ㄱa21 * b2 + a12 * b1)
    mov ebx, dword[a21] ; ebx = a21
    and ebx, dword[b1] ; ebx = a21 * b1
    xor ebx, dword[b2] ; ebx = a21 * b1 + b2
    and ebx, dword[a11] ; ebx = (a21 * b1 + b2) * a11
    xor eax, ebx ; eax = y = ㄱa11 * (ㄱa12 * ㄱa21 * b2 + a12 * b1) + (a21 * b1 + b2) * a11
    call io_print_udec ; y printed
    call io_newline
    xor eax, eax
    ret
