extern io_get_udec, io_print_udec, io_print_char, io_newline

section .bss
    cur_numerator resd 1
    new_numerator resd 1
    cur_denominator resd 1
    new_denominator resd 1
    tmp_1 resd 1
    tmp_2 resd 1
    
section .text
global main
main:
    push ebp
    mov ebp, esp
    call io_get_udec
    mov ebx, eax; ebx = N
    call io_get_udec
    mov dword[cur_numerator], eax
    call io_get_udec
    mov dword[cur_denominator], eax
    cmp ebx, 1
    mov edi, 1
    je .end
    mov esi, 1; esi = 1 - counter for loop
    
.l1:
    call io_get_udec
    mov dword[new_numerator], eax
    call io_get_udec
    mov dword[new_denominator], eax
    mov ecx, dword[cur_denominator]
    push eax
    push ecx
    call nod
    mov ecx, eax; ecx = nod(cur_denominator, new_denominator)
    mov eax, dword[cur_denominator]
    xor edx, edx
    div ecx
    mov dword[tmp_2], eax
    mov eax, dword[new_denominator]
    xor edx, edx
    div ecx
    mov dword[tmp_1], eax
    mov eax, dword[cur_numerator]
    mul dword[tmp_1]
    mov dword[cur_numerator], eax
    mov eax, dword[cur_denominator]
    mul dword[tmp_1]
    mov dword[cur_denominator], eax
    mov eax, dword[new_numerator]
    mul dword[tmp_2]
    add dword[cur_numerator], eax
    inc esi
    cmp esi, ebx
    jne .l1
    
    mov eax, dword[cur_numerator]
    mov ebx, dword[cur_denominator]
    push eax
    push ebx
    call nod
    mov edi, eax; edi = nod(cur_numerator, cur_denominator)
.end:
    mov eax, dword[cur_numerator]
    xor edx, edx
    div edi
    call io_print_udec
    mov eax, ' '
    call io_print_char
    mov eax, dword[cur_denominator]
    xor edx, edx
    div edi
    call io_print_udec
    call io_newline
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
nod:
    push ebp
    mov ebp, esp
    push ebx
    mov eax, dword[ebp + 8]
    mov ebx, dword[ebp + 12]
    mov ecx, ebx
    cmp eax, ebx
    cmova ebx, eax
    cmova eax, ecx
    
    .l:
        xchg eax, ebx
        xor edx, edx
        div ebx
        mov eax, edx
        test edx, edx
        jne .l
           
    mov eax, ebx
    pop ebx
    leave
    ret
