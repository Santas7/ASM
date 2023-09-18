; библиотека для макросов SASM
%include "io.inc"

section .bss
    ; секция под неинициализированные данные
    ; resd резервирует в памяти массив из n двойных слов
    ; (4 байта каждое)
    array resd 100
    array_len resd 1

section .text
    ; секция кода
    global main

    ; основной код программы
    ; начальная метка входа
    main:
        ; вводим длину массива
        PRINT_STRING "Start program.."
        NEWLINE
        GET_DEC 4, array_len
        PRINT_STRING "Array length: "
        PRINT_DEC 4, array_len
        NEWLINE
        PRINT_STRING "Array fill:"
        mov eax, [array_len] ; до куда идем в цикле
        mov ecx, 0 ; индекс который будет перемещаться
    
    ; заполнение массива данными
    fill_array:
        GET_DEC 4, [array + 4*ecx]
        PRINT_DEC 4, [array + 4*ecx]
        PRINT_CHAR ", "
        add ecx, 1 ; увел на 1
        sub eax, 1 ; умен на 1
        jnz fill_array ; Jump if Not Zero

        ; Вызываем сортировку пузырьком
        ; for (int i = 0; i < n - 1; i++)
        mov eax, [array_len]
        sub eax, 1 ; n-1
        xor ebx, ebx
        
        ; eax - хранение(n-1)
        ; ebx - флаг отслеживания обменов
        ; ecx - индекс (i) который перемещается в цикле
        ; xor буду исп-ть для обнуления битов в регистре
    
    ; сортировка массива пузярьком
    sort:
        xor ecx, ecx
        
        inner_loop:
            ; если ecx (i) <= n-1
            cmp ecx, eax ; Сравниваем индекс с n - 1
            jge check 
            
            ; esi - хранение текущего элемента массива
            ; edi - хранение след. элемента массива
            mov esi, [array + 4*ecx]
            mov edi, [array + 4*(ecx+1)]
            
            ; если esi <= edi то переход к no_swap
            cmp esi, edi
            jle no_swap
    
            ; иначе совершаем swap(обмен) элементов
            ; array[i] = edi (array[i+1])
            ; array[i+1] = esi (array[i])
            mov [array + 4*ecx], edi
            mov [array + 4*(ecx+1)], esi
            
            no_swap:
                add ecx, 1
                jmp inner_loop

        check:
            test ebx, ebx ; Проверяем флаг обмена
            jnz sort ; Если были обмены, продолжаем сортировку
    
            ; Если нет обменов, массив отсортирован
            NEWLINE
            PRINT_STRING "Sorted array:"
            xor ecx, ecx ; обнуляем регистр
    
    ; вывод отсортированного массива
    print_array:
        mov eax, [array + 4*ecx]
        PRINT_DEC 4, eax
        PRINT_CHAR ", "
        add ecx, 1
        cmp ecx, [array_len]
        jnz print_array
        NEWLINE
        PRINT_STRING "Program end.."
        ret
