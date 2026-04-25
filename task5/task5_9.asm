extern scanf, printf, malloc, free

section .rodata
    fin db "%u", 0
    fout db "%d ", 0
    newline db 10, 0

section .data
    sizeof_int dd 4
    max_trace dq 0x8000000000000000
    
section .bss 
    n resd 1
    cur_trace resq 1
    ans_size resd 1
    cur_size resd 1
    ans_matrix resd 1
    cur_matrix resd 1

section .text
global main
main:
    push ebp
    mov ebp, esp
    and esp, -16
    sub esp, 16
    mov dword[esp], fin
    mov dword[esp + 4], n
    call scanf
    xor ebx, ebx; ebx - counter for BIG loop

.l1:
    mov dword[cur_trace], 0
    mov dword[cur_trace + 4], 0
    mov dword[esp], fin
    mov dword[esp + 4], cur_size
    call scanf
    mov eax, dword[cur_size]
    mul dword[cur_size]
    mul dword[sizeof_int]
    mov dword[esp], eax
    call malloc
    mov dword[cur_matrix], eax
    xor esi, esi; esi - counter for loop (i)

.l1i:
    xor edi, edi; edi - counter for loop (j)

.l1j:
    mov eax, esi
    mul dword[cur_size]
    add eax, edi
    mul dword[sizeof_int]
    mov edx, dword[cur_matrix]
    lea eax, [edx + eax]
    mov dword[esp], fout
    mov dword[esp + 4], eax
    call scanf
    cmp esi, edi
    je .changing_trace

.l2:
    inc edi
    cmp edi, dword[cur_size]
    jne .l1j
    inc esi
    cmp esi, dword[cur_size]
    jne .l1i
    
.l3:
    mov eax, dword[cur_trace + 4]
    cmp eax, dword[max_trace + 4]
    jl .l7
    je .l4
    mov dword[max_trace + 4], eax
    mov eax, dword[cur_trace]
    mov dword[max_trace], eax
    mov eax, dword[cur_size]
    mov dword[ans_size], eax
    mov eax, dword[cur_matrix]
    mov dword[ans_matrix], eax
    jmp .l7

.l4: 
    cmp eax, 0; is the number less than 0?
    jl .l5
    mov eax, dword[cur_trace]
    cmp eax, dword[max_trace]
    jbe .l7
    jmp .l6

.l5:
    mov eax, dword[cur_trace]
    cmp eax, dword[max_trace]
    jbe .l7

.l6:
    mov dword[max_trace], eax
    mov eax, dword[cur_size]
    mov dword[ans_size], eax
    mov eax, dword[cur_matrix]
    mov dword[ans_matrix], eax

.l7:
    inc ebx
    cmp ebx, dword[n]
    jne .l1
     
    xor esi, esi; esi - counter for loop (i)

.l8i:
    xor edi, edi; edi - counter for loop (j)

.l8j:
    mov eax, esi
    mul dword[ans_size]
    add eax, edi
    mul dword[sizeof_int]
    mov edx, dword[ans_matrix]
    lea eax, dword[edx + eax]
    mov eax, dword[eax]
    mov dword[esp], fout
    mov dword[esp + 4], eax
    call printf
    inc edi
    cmp edi, dword[ans_size]
    jne .l8j
    mov dword[esp], newline
    call printf
    inc esi
    cmp esi, dword[ans_size]
    jne .l8i
    
    mov eax, dword[ans_matrix]
    mov dword[esp], eax
    call free
    add esp, 16
    leave
    xor eax, eax
    ret
    
.changing_trace:
    mov eax, esi
    mul dword[cur_size]
    add eax, edi
    mul dword[sizeof_int]
    mov edx, dword[cur_matrix]
    lea eax, [edx + eax]
    mov eax, dword[eax]
    cmp eax, 0
    jl .negative
    add dword[cur_trace], eax
    adc dword[cur_trace + 4], 0
    jmp .l2    

.negative: 
    cdq
    xor eax, edx
    inc eax
    sub dword[cur_trace], eax
    sbb dword[cur_trace + 4], 0
    jmp .l2
