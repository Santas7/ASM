; библиотека для макросов SASM
%include "io.inc"

section .bss
    array resd 100
    array_len resd 1

section .text
    global main

    ; точка входа в программу - main
    main:
        PRINT_STRING "Start program.."
        NEWLINE
        GET_DEC 4, [array_len]
        PRINT_STRING "Array length: "
        PRINT_DEC 4, [array_len]
        NEWLINE
        PRINT_STRING "Array fill:"
        mov eax, [array_len]
        mov ecx, 0 ; i = 0

    ; заполнение массива данными
    fill_array:
        GET_DEC 4, [array + 4*ecx]
        PRINT_DEC 4, [array + 4*ecx]
        PRINT_CHAR ", "
        inc ecx ; i++
        dec eax ; array_len--

        ; переход если EAX != 0
        jnz fill_array

    ; EAX == 0
    mov eax, [array_len]
    dec eax
    xor ebx, ebx

    ; сортировка массива пузырьком
    sort:
        xor ecx, ecx
        inner_loop:
            cmp ecx, eax
            ; ECX >= EAX тогда переходим к метке
            jge check 
            
            mov esi, [array + 4*ecx]
            mov edi, [array + 4*(ecx+1)]

            cmp esi, edi
            ; ESI (A[i]) <= EDI (A[i+1])
            ; значит swap не будет!
            jle no_swap

            ; совершаем операцию swap
            ; 4*ecx смещение до нужного элемента
            mov [array + 4*ecx], edi
            mov [array + 4*(ecx+1)], esi
            xor ecx, ecx
            
            no_swap:
                inc ecx
                ; обратно к метке inner_loop
                jmp inner_loop

        check:
            test ebx, ebx
            ; если флаг ZF установлен 
            ; то переходим к метке sort (внешний цикл)
            jnz sort
            NEWLINE
            PRINT_STRING "Sorted array:"
            xor ecx, ecx
    
    print_array:
        mov eax, [array + 4*ecx]
        PRINT_DEC 4, eax
        PRINT_CHAR ", "
        inc ecx
        cmp ecx, [array_len]
        jnz print_array
        NEWLINE
        PRINT_STRING "Program end.."
        ret
