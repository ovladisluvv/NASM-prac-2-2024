extern io_get_udec, io_get_dec, io_print_udec, io_newline
    
section .text
global main
main:
    mov ebp, esp; for correct debugging
    call io_get_udec
    mov ebx, eax ; ebx = n
    call io_get_dec 
    mov ecx, eax ; ecx = k
    mov eax, 1

get_mask:
    shl eax, 1
    loop get_mask
    
    dec eax ; eax = bit mask
    jmp l
    
l:
    mov edx, ebx
    shr ebx, 1
    and edx, eax
    cmp edx, ecx ; ecx - max
    cmova ecx, edx
    test ebx, ebx
    jne l
    
    mov eax, ecx
    call io_print_udec
    call io_newline
    xor eax, eax
    ret
