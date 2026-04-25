extern io_get_udec, io_print_udec, io_newline

section .bss
    arr resd 2011
    
section .text
global main
main:
    push ebp
    mov ebp, esp
    call io_get_udec
    mov esi, eax; esi = K
    mov ecx, 2011; ecx = 2011 - counter for loop
    mov edi, ecx; edi = 2011 - just 2011
    xor ebx, ebx; ebx = 0 - array index
    
.l1:
    mov eax, ebx
    mul eax
    push esi
    push eax
    call f
    xor edx, edx
    div edi
    mov dword[arr + ebx * 4], edx
    inc ebx
    loop .l1
    
    call io_get_udec
    mov ebx, eax
    call io_get_udec
    mov ecx, ebx; ecx = N
    xor edx, edx
    div edi
    mov eax, edx; eax = Y0
    
.l2:
    mov eax, dword[arr + eax * 4]
    loop .l2
    
    call io_print_udec
    call io_newline
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
f:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    mov eax, dword[ebp + 8]
    mov esi, dword[ebp + 12]
    xor ebx, ebx; ebx = 0 - new number
    
    .l:
        xchg eax, ebx
        mul esi
        xchg ebx, eax
        xor edx, edx
        div esi
        add ebx, edx
        test eax, eax
        jne .l
        
    mov eax, ebx
    pop esi
    pop ebx
    leave
    ret
