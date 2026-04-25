extern io_get_udec, io_print_udec, io_print_string, io_newline

section .data
    yes db 'Yes', 0
    no db 'No', 0
    base dd 10
    temp dd 0
    
section .bss
    num resd 0
    
section .text
global main
main:
    push ebp
    mov ebp, esp
    call io_get_udec
    mov ebx, eax; ebx = M
    call io_get_udec
    mov ecx, eax; ecx = N
    test ecx, ecx; if N == 0
    je .zero
    
.l1:
    push ebx
    call turn
    add ebx, eax
    loop .l1

.zero:; N == 0
    mov dword[num], ebx
    push ebx
    call turn
    cmp eax, ebx
    jne .no

.yes:
    mov eax, yes
    call io_print_string
    call io_newline
    mov eax, dword[num]
    call io_print_udec
    call io_newline
    jmp .end
    
.no:
    mov eax, no
    call io_print_string
    call io_newline
    
.end:
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
turn:
    push ebp
    mov ebp, esp
    push esi
    xor esi, esi
    mov eax, dword[ebp + 8]

    .l:
        xchg eax, esi
        mul dword[base]
        xchg esi, eax
        xor edx, edx
        div dword[base]
        add esi, edx
        test eax, eax
        jne .l
    
    mov eax, esi
    pop esi
    leave
    ret
