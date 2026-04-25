extern io_get_udec, io_print_udec, io_newline

section .data
    ans dd 0
    C dd 1
    two dd 2
    
section .bss
    n resd 1
    k resd 1
    new_k resd 1
    ro resd 1
    new_ro resd 1
    znam resd 1
    temp resd 1
    
section .text
global main
main:
    mov ebp, esp; for correct debugging
    call io_get_udec
    mov ebx, eax; ebx = n
    mov dword[n], eax
    call io_get_udec; eax = k
    mov dword[k], eax
    test ebx, ebx
    je .zero; if n == 0
    xor ecx, ecx; ecx - counter for bits of n (ro)
    
.l1:; counting bits of n
    shr ebx, 1
    inc ecx
    test ebx, ebx
    jne .l1
    mov dword[ro], ecx
    
    mov edx, 1; edx = temp
    shl edx, cl
    shr edx, 1
    mov dword[temp], edx
    test eax, eax
    je .end1; if k == 0
    cmp ecx, eax
    jb .end; if ro < k
    ; rn ro >= k, eax = k
    mov ecx, eax; ecx = k
    inc ecx; k' = k + 1, ro' = ro - 1
    cmp ecx, dword[ro]
    jb .l2

.l4:
    dec dword[ro]
    mov eax, dword[ro]; eax = ro
    cmp eax, dword[k]
    jb .end
    
.l5:
    mov eax, dword[n]; eax = n
    mov ebx, dword[temp]
    cdq
    idiv ebx
    mov dword[n], edx
    xor ecx, ecx
    shr ebx, 1
    mov dword[temp], ebx
    test edx, edx
    je .l7
    mov eax, edx
    
.l6:
    cdq
    idiv dword[two]
    inc ecx
    test eax, eax
    jne .l6
    
.l7:
    cmp ecx, dword[ro]
    je .l8
    
    dec dword[k]
    mov edi, dword[k]
    test edi, edi
    je .l9
    jmp .l10

.l8:
    mov dword[new_k], 1
    mov edi, dword[ro]
    dec edi
    mov dword[new_ro], edi
    mov edi, dword[k]
    dec edi
    test edi, edi
    je .l13
    mov eax, 1
    
.l11:
    mov esi, dword[new_ro]
    imul esi
    dec dword[new_ro]
    mov esi, dword[new_k]
    cdq
    idiv esi
    inc dword[new_k]
    dec edi
    test edi, edi
    jne .l11
    
    add dword[ans], eax
    
.l10:
    dec dword[ro]
    mov edi, dword[ro]
    cmp edi, dword[k]
    jae .l5
    jmp .end
    
.l12:
    inc dword[ans]
    
.end:
    mov eax, dword[ans]
    call io_print_udec
    call io_newline
    xor eax, eax
    ret
    
.end1:; if k == 0
    mov edx, dword[n]
    inc edx
    mov ecx, dword[ro]
    shr edx, cl
    add dword[ans], edx
    dec ecx
    add dword[ans], ecx
    jmp .end
    
.zero:
    dec eax
    test eax, eax
    jne .end; if k - 1 != 0 <=> k != 1
    inc dword[ans]
    jmp .end
    
.l2:
    mov eax, dword[C]
    mov dword[ans], 1
    mov dword[znam], 1
    inc ecx
    cmp ecx, dword[ro]
    jae .l4
    
.l3: ;getting C^n_k
    mov eax, dword[C]
    mov ebx, ecx
    dec ebx
    imul eax, ebx
    mov esi, dword[znam]
    cdq
    idiv esi
    inc dword[znam]
    add dword[ans], eax
    mov dword[C], eax
    inc ecx
    cmp ecx, dword[ro]
    jb .l3
    jmp .l4    
    
.l9:
    mov eax, dword[n]
    mov ecx, dword[ro]
    dec ecx
    test ecx, ecx
    je .l12
    mov esi, 1
    shl esi, cl
    cmp esi, eax
    jne .end
    
.l13:
    inc dword[ans]
    jmp .l10
