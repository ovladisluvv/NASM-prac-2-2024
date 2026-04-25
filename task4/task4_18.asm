extern io_get_dec, io_print_char, io_print_dec, io_newline

section .data
    pre_ans dd 1
    two_divider dd 2
    num_len dd 9
    base dd 10
    first_mult_len dd 19
    second_mult_len dd 29
    
section .bss
    sign resd 1
    x1 resd 20
    x2 resd 20
    x3 resd 20
    temp resd 20
    ans resd 30
    cur_num resd 1

section .text
global main
main:
    push ebp
    mov ebp, esp
    xor edi, edi; edi - sign flag
    call io_get_dec
    xor edx, edx
    cmp eax, 0
    cmovl edx, dword[pre_ans]
    add edi, edx
    push eax
    call my_abs
    mov ecx, 10
    xor esi, esi; esi - counter for loop
.l1:
    xor edx, edx
    idiv dword[base]
    mov dword[x1 + 4 * esi], edx
    inc esi
    loop .l1
    
    call io_get_dec
    xor edx, edx
    cmp eax, 0
    cmovl edx, dword[pre_ans]
    add edi, edx
    push eax
    call my_abs
    mov ecx, 10
    xor esi, esi; esi - counter for loop
.l2:
    xor edx, edx
    idiv dword[base]
    mov dword[x2 + 4 * esi], edx
    inc esi
    loop .l2    
    
    call io_get_dec
    xor edx, edx
    cmp eax, 0
    cmovl edx, dword[pre_ans]
    add edi, edx
    push eax
    call my_abs
    mov ecx, 10
    xor esi, esi; esi - counter for loop
.l3:
    xor edx, edx
    idiv dword[base]
    mov dword[x3 + 4 * esi], edx
    inc esi
    loop .l3
    
    mov eax, edi
    xor edx, edx
    div dword[two_divider]
    mov dword[sign], edx
    
    mov eax, temp
    mov dword[cur_num], eax
    mov eax, x1
    push eax
    mov eax, x2
    push eax
    call my_mul
    
    mov eax, ans
    mov dword[cur_num], eax
    mov eax, x3
    push eax
    mov eax, temp
    push eax
    call my_mul
    
    mov eax, ans
    push eax
    call check
    
    mov eax, dword[sign]
    test eax, eax
    je .l4
    mov eax, '-'
    call io_print_char
    jmp .l4
.l4:
    xor ebx, ebx; ebx - flag for the first not zero
    xor esi, esi; esi - counter for loop
    mov edi, 29
.l5:
    dec edi
    mov eax, dword[ans + 4 * edi]
    test eax, eax
    jne .l6
    test ebx, ebx
    je .l5
.l6:
    inc ebx
    call io_print_dec
    inc esi
    test edi, edi
    jne .l5
    
    call io_newline
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
my_abs:
    push ebp
    mov ebp, esp
    mov eax, dword[ebp + 8]
    mov edx, eax
    sar edx, 31
    xor eax, edx
    sub eax, edx
    leave
    ret
    
my_mul:
    push ebp
    mov ebp, esp
    push esi
    push edi
    push ebx
    mov esi, dword[ebp + 8]
    mov edi, dword[ebp + 12]
    xor ecx, ecx; ecx - counter for the first number's digits
    xor ebx, ebx; edx - counter for the second number's digits
    
    .mul_l1:
        cmp ebx, dword[first_mult_len]
        je .mul_end
        mov eax, dword[esi + 4 * ecx]
        mul dword[edi + 4 * ebx]
        mov edx, dword[cur_num]
        lea edx, [edx + 4 * ebx]
        add dword[edx + 4 * ecx], eax
        cmp ecx, dword[first_mult_len]
        je .mul_l2
        inc ecx
        jmp .mul_l1
       
    .mul_l2:
        xor ecx, ecx
        inc ebx
        jmp .mul_l1
        
    .mul_end: 
        pop ebx
        pop edi
        pop esi
        xor eax, eax
        leave
        ret
        
check:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    mov ebx, dword[ebp + 8]
    xor ecx, ecx; ecx - counter for loop
    xor esi, esi; esi - temp
    
    .check_l_1:
        mov eax, dword[ebx + 4 * ecx]
        xor edx, edx
        div dword[base]
        add dword[ebx + 4 * ecx + 4], eax
        mov dword[ebx + 4 * ecx], edx
        inc ecx
        cmp ecx, dword[second_mult_len]
        jne .check_l_1
    
    pop esi
    pop ebx
    leave
    xor eax, eax
    ret
