extern io_get_char, io_print_dec, io_newline

section .bss
    temp resd 1

global main
section .text

main:   
    call io_get_char
    mov ebx, eax ; ebx = значение буквы старта
    call io_get_char
    mov dword[temp], eax ; temp = значение цифры старта
    call io_get_char ; считывание пробела
    call io_get_char
    sub ebx, eax ; ebx = разница значений букв старта и финиша
    call io_get_char
    sub eax, dword[temp] ; eax = разница значений цифр старта и финиша
    mov edx, eax ; начало вычисления модуля разности
    sar edx, 31
    xor eax, edx
    sub eax, edx ; конец вычисления модуля разности
    mov edx, ebx ; начало вычисления модуля разности
    sar edx, 31
    xor ebx, edx
    sub ebx, edx ; конец вычисления модуля разности
    add eax, ebx ; eax = отвеи
    call io_print_dec
    call io_newline
    xor eax, eax
    ret
