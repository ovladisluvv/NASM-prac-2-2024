extern fopen, fclose, fscanf, printf

section .rodata
    filename db "data.in", 0
    openmode db "r", 0
    fin db "%d", 0
    fout db "%d", 10, 0
    
section .text
global main
main:
    push ebp
    mov ebp, esp
    and esp, -16
    sub esp, 16
    mov dword[esp + 4], openmode
    mov dword[esp], filename
    call fopen
    mov ebx, eax; f
    xor esi, esi; esi - counter for numbers
    mov dword[esp], ebx
    mov dword[esp + 4], fin
    lea edx, [esp + 12]
    mov dword[esp + 8], edx
.l1:
    call fscanf
    cmp eax, 1
    jne .end
    inc esi
    jmp .l1
.end:
    mov dword[esp], ebx
    call fclose
    mov dword[esp], fout
    mov dword[esp + 4], esi
    call printf
    add esp, 16
    leave   
    xor eax, eax
    ret
