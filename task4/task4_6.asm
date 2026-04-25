extern io_get_udec, io_print_udec, io_newline
    
section .bss
    ans resd 1
    N resd 1
    arr resd 1001
    
section .text
global main
main:
    push ebp
    mov ebp, esp
    call io_get_udec
    mov dword[N], eax
    test eax, eax
    je .end
    xor ebx, ebx

.l1:
    call io_get_udec
    mov dword[arr + ebx * 4], eax
    inc ebx
    cmp ebx, dword[N]
    jb .l1
    
    call io_get_udec
    mov ecx, eax; ecx = k
    xor ebx, ebx
    
.l2:
    mov edx, dword[arr + ebx * 4]
    push edx
    call zeros
    cmp eax, ecx
    je .add
.l2_1:
    inc ebx
    cmp ebx, dword[N]
    jne .l2

.end:
    mov eax, dword[ans]
    call io_print_udec
    call io_newline
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
.add:
    inc dword[ans]
    jmp .l2_1
    
zeros:
    push ebp
    mov ebp, esp
    push esi
    push edi
    mov eax, dword[ebp + 8]
    xor esi, esi
    
    .l1:
        mov edi, eax
        and edi, 1
        dec edi
        neg edi
        add esi, edi
        shr eax, 1
        test eax, eax
        jne .l1
        
    mov eax, esi    
    pop edi
    pop esi
    mov esp, ebp
    pop ebp
    ret
