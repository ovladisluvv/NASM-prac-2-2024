extern scanf, printf, strstr, strlen, putchar 
section .bss 
    str1 resb 101 
    str2 resb 101 
    len1 resd 1 
    len2 resd 1 
    substr resd 1 
    temp1 resd 1
    temp2 resd 1
section .rodata 
    string db "%s", 0 
section .text 
global main 
main: 
    push    ebp 
    mov     ebp, esp 
    and     esp, -16 
    sub     esp, 16 
    mov     dword[esp], string 
    mov     dword[esp + 4], str1 
    call    scanf 
    mov     dword[esp + 4], str2 
    call    scanf 
    mov     ebx, str1
    mov     ecx, str2
    mov     dword[esp + 4], ecx 
    mov     dword[esp], ebx 
    call    strstr 
    mov     ecx, str1 
    mov     dword[substr], eax 
    test    eax, eax
    jne     .l 
    mov     ebx, str2
    mov     ecx, str1
    mov     dword[esp + 4], ecx 
    mov     dword[esp], ebx 
    call    strstr 
    mov     ecx, str2 
    mov     dword[substr], eax 
    test    eax, eax
    jne     .l 
    mov     dword[esp], string 
    mov     dword[esp + 4], ebx 
    call    printf 
    mov dword[temp1], ebx
    mov dword[temp2], ecx
    jmp     .f 
.l: 
    mov     dword[esp], ebx 
    call    strlen 
    mov     dword[len1], eax 
    mov     dword[esp], ecx 
    call    strlen 
    mov     dword[len2], eax 
    xor     esi, esi 
    mov     dword[temp2], ecx 
.s: 
    xor     edi, edi 
    cmp     esi, dword[len1] 
    je      .f 
    add     edi, ebx 
    add     edi, esi 
    cmp     edi, dword[substr] 
    jne     .l2 
    mov     dword[esp], '[' 
    call    putchar 
    mov     ecx, dword[temp2] 
    mov     dword[esp], string 
    mov     dword[esp + 4], ecx 
    call    printf 
    mov     ecx, dword[temp2]  
    mov     dword[esp], ']' 
    call    putchar 
    mov     ecx, dword[temp2] 
    add     esi, dword[len2] 
    jmp     .s 
.l2: 
    movzx   edi, byte[edi] 
    mov     dword[esp], edi 
    call    putchar 
    mov     ecx, dword[temp2] 
    inc     esi 
    jmp     .s 
.f: 
    add     esp, 16
    leave 
    xor     eax, eax 
    ret
