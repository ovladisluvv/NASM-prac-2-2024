extern io_get_udec, io_print_udec, io_print_char, io_newline
    
section .bss
    temp resd 1
    arr resd 1000000
    n resd 1
    bit_mask resd 1
    
section .text
global main
main:
    mov ebp, esp; for correct debugging
    call io_get_udec
    test eax, eax
    je .end
    mov dword[n], eax
    xor ebx, ebx; ebx - counter for loop

.l1:
    call io_get_udec
    mov dword[arr + ebx * 4], eax
    inc ebx
    cmp ebx, dword[n]
    jb .l1
    
    call io_get_udec
    mov ecx, eax; cl = k
    mov eax, 1
    shl eax, cl
    dec eax; eax - bit mask
    mov dword[bit_mask], eax
    xor eax, eax
    
.l2:
    mov ebx, dword[temp]; ebx - old temp
    mov edx, dword[arr + eax * 4]; edx - current number
    mov esi, edx; esi - new temp
    and esi, dword[bit_mask]
    ror esi, cl
    mov dword[temp], esi
    shr edx, cl
    add edx, ebx
    mov dword[arr + eax * 4], edx
    inc eax
    cmp eax, dword[n]
    jb .l2
    
    mov ebx, dword[temp]
    add dword[arr], ebx; ebx - current number
    xor ebx, ebx
    
.print_arr:
    mov eax, dword[arr + ebx * 4]
    call io_print_udec
    mov eax, ' '
    call io_print_char
    inc ebx
    cmp ebx, dword[n]
    jb .print_arr
    
.end:
    call io_newline
    xor eax, eax
    ret
