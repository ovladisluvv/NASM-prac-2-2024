extern fopen, fclose, fscanf, fprintf, printf, strcmp, malloc, free

section .data
    max_domain_length equ 101
    max_str_length equ 101

section .rodata
    in_filename db "input.txt", 0
    out_filename db "output.txt", 0
    format_int db "%d", 0
    format_long db "%lld", 10
    format_str db "%s", 0

section .bss
    server resd 8
    temp resb 101
    temp1 resd 1

section .text
global main
main:
    push ebp
    mov ebp, esp
    and esp, -16
    mov dword [esp-4], in_filename
    mov dword [esp], 0
    call fopen
    mov ebx, eax ; сохранить указатель на файл в ebx

    ; Прочитать количество записей из файла
    lea eax, [n]
    call dword [fscanf]

    ; Выделить память для структур dns
    mov dword [esp+4], n
    mov dword [esp], 8
    call malloc
    mov dword [server], eax

    ; Прочитать данные из файла
    mov ecx, n ; счетчик

read_loop:
    lea eax, [temp]
    call dword [fscanf]
    mov edx, eax ; домен
    mov eax, [server]
    mov [eax], edx
    add eax, 4
    mov edx, [temp + max_domain_length]
    mov [eax], edx
    add dword [server], 8
    loop read_loop

    ; Закрыть файл
    mov dword [esp], ebx
    call fclose

    ; Сортировка массива
    mov eax, [server]
    mov dword [esp+4], eax
    mov dword [esp+8], n
    mov dword [esp+12], 8
    lea eax, [compare]
    mov dword [esp+16], eax
    call qsort

    ; Открыть файл для записи
    mov dword [esp-4], out_filename
    mov dword [esp], 1
    call fopen
    mov ebx, eax ; сохранить указатель на файл в ebx

    ; Прочитать количество запросов из файла
    lea eax, [m]
    call dword [fscanf]

    ; Обработать запросы и записать результат в файл
    xor ecx, ecx ; счетчик

query_loop:
    ; Прочитать запрос
    lea eax, [temp]
    call dword [fscanf]
    ; Найти IP и записать его в файл
    mov eax, [server]
    mov edx, n
    mov esi, temp
    xor edi, edi ; левая граница поиска
    mov ebp, n ; правая граница поиска
    call bin_search
    lea ebx, [format_long]
    mov eax, esi
    call dword [printf]
    ; Записать результат в файл
    mov dword [esp], eax ; указатель на результат в eax
    lea eax, [format_long]
    mov dword [esp+4], ebx
    mov dword [esp+8], ebx
    call dword [fprintf]
    ; Увеличить счетчик
    inc ecx
    cmp ecx, m
    jne query_loop

    ; Закрыть файл
    mov dword [esp], ebx
    call fclose

    ; Освободить память
    mov eax, [server]
    call free
    ret

compare:
    ; Реализация функции сравнения для qsort
    mov eax, [edi] ; первый элемент
    mov edx, [esi] ; второй элемент
    call strcmp
    ret

bin_search:
    ; Рекурсивный поиск в отсортированном массиве
    ; eax - указатель на начало массива
    ; edx - размер массива
    ; esi - искомая строка
    ; edi - левая граница поиска
    ; ebp - правая граница поиска
    cmp edi, ebp
    je .not_found
    mov eax, edi
    add eax, ebp
    shr eax, 1 ; средний элемент
    mov ecx, eax
    imul ecx, edx, 8 ; перемножаем средний элемент на размер структуры
    mov esi, eax ; сохраняем индекс среднего элемента
    mov dword[temp1], edx
    mov edx, dword[esp+12]
    mov eax, [eax*8 + edx] ; загружаем значение среднего элемента
    mov edx, dword[temp1]
    mov ebx, [esp+8] ; загружаем указатель на искомую строку
    call strcmp
    test eax, eax
    jz .found
    jns .left_half

    .right_half:
        inc esi ; переход к правой половине
        mov edi, esi ; обновляем левую границу
        jmp .bin_search_recursive
    
    .left_half:
        dec esi ; переход к левой половине
        mov ebp, esi ; обновляем правую границу
    
    .bin_search_recursive:
        call bin_search
    
    .found:
        mov eax, esi ; возвращаем результат
        ret
    
    .not_found:
        mov eax, -1 ; значение не найдено
        ret
