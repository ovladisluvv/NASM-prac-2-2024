extern fopen, fclose, fscanf, fprintf, malloc, free

section .bss
    N resd 1
    M resd 1
    head resd 1
    tail resd 1
    left resd 1
    right resd 1
    arr resd 100001
    
section .rodata
    input_filename db "input.txt", 0
    input_openmode db "r", 0
    output_filename db "output.txt", 0
    output_openmode db "w", 0
    fin db "%u", 0
    fout db "%u ", 0
    
section .text
global main
main:
    push ebp
    mov ebp, esp
    and esp, -16
    sub esp, 16
    mov dword[esp], input_filename
    mov dword[esp + 4], input_openmode
    call fopen
    mov ebx, eax; ebx - f
    mov dword[esp], ebx
    mov dword[esp + 4], fin
    mov dword[esp + 8], N
    call fscanf
    mov dword[esp + 8], M
    call fscanf
    mov dword[esp], 12
    call malloc
    mov dword[head], eax
    mov dword[tail], eax
    mov dword[eax], 1
    mov dword[eax + 4], 0
    mov dword[eax + 8], 0
    mov dword[arr], eax
    mov esi, 1; esi - counter foor loop
    cmp esi, dword[N]
    je .l1_1

.l1:
    call malloc
    mov dword[arr + esi * 4], eax
    mov ecx, dword[tail]
    mov dword[ecx + 8], eax
    mov dword[eax + 4], ecx
    mov dword[tail], eax
    mov dword[eax + 8], 0
    inc esi
    mov dword[eax], esi
    cmp esi, dword[N]
    jne .l1

.l1_1:
    mov dword[esp], ebx
    mov dword[esp + 4], fin
    xor esi, esi; esi - counter for loop

.l2:
    mov dword[esp + 8], left
    call fscanf
    mov dword[esp + 8], right
    call fscanf
    mov ecx, dword[left]
    mov ecx, dword[arr + ecx * 4 - 4]
    mov edx, dword[right]
    mov edx, dword[arr + edx * 4 - 4]
    mov edi, dword[ecx + 4]
    test edi, edi
    je .l4
    mov eax, dword[ecx + 4]
    mov dword[ecx + 4], 0
    mov ebx, dword[edx + 8]
    mov edi, dword[head]
    mov dword[head], ecx
    mov dword[edx + 8], edi
    mov dword[edi + 4], edx
    mov dword[eax + 8], ebx
    test ebx, ebx
    je .l3
    mov dword[ebx + 4], eax
    jmp .l4

.l3:
    mov dword[tail], eax

.l4:
    inc esi
    cmp esi, dword[M]
    jne .l2
    
    call fclose
    mov dword[esp], output_filename
    mov dword[esp + 4], output_openmode
    call fopen
    mov dword[esp], eax
    mov dword[esp + 4], fout
    mov esi, dword[head]

.l5:
    mov eax, dword[esi]
    mov dword[esp + 8], eax
    call fprintf
    mov esi, dword[esi + 8]
    test esi, esi
    jne .l5
    
    call fclose
    xor esi, esi; esi - cointer for loop

.l6:
    mov eax, dword[arr + esi * 4]
    mov dword[esp], eax
    call free
    inc esi
    cmp esi, dword[N]
    jne .l6
    
    add esp, 16
    leave
    xor eax, eax
    ret
