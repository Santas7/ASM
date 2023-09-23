; библиотека для макросов SASM
%include "io64.inc"

section .bss
    array resq 100
    array_len resq 1

section .text
    global main

    ; точка входа в программу - main
    main:
        PRINT_STRING "Start program.."
        NEWLINE
        GET_DEC 8, [array_len]
        PRINT_STRING "Array length: "
        PRINT_DEC 8, [array_len]
        NEWLINE
        PRINT_STRING "Array fill:"
        mov rdx, [array_len]
        mov rbx, 0

    ; заполнение массива данными
    fill_array:
        GET_DEC 8,[array + 8*rbx]
        PRINT_DEC 8,[array + 8*rbx]
        PRINT_CHAR ", "
        inc rbx ; i++
        dec rdx ; array_len--
        ; переход если EAX != 0
        jnz fill_array

    ; EAX == 0
    mov rdx, [array_len]
    dec rdx
    xor rbx, rbx

    ; сортировка массива пузырьком
    sort:
        xor rcx, rcx
        inner_loop:
            cmp rcx, rdx
            ; ECX >= EAX тогда переходим к метке
            jge check 
            
            mov rsi, [array + 8*rcx]
            mov rdi, [array + 8*rcx + 8]

            cmp rsi, rdi
            ; ESI (A[i]) <= EDI (A[i+1])
            ; значит swap не будет!
            jle no_swap

            ; совершаем операцию swap
            ; 4*ecx смещение до нужного элемента
            mov [array + 8*rcx], rdi
            mov [array + 8*rcx + 8], rsi
            xor rcx, rcx
            
            no_swap:
                inc rcx
                ; обратно к метке inner_loop
                jmp inner_loop

        check:
            test rbx, rbx
            ; если флаг ZF установлен 
            ; то переходим к метке sort (внешний цикл)
            jnz sort
            NEWLINE
            PRINT_STRING "Sorted array:"
            xor rdx,rdx
            mov rbx, [array_len]
    
    print_array:
        PRINT_DEC 8, [array + 8*rdx]
        PRINT_CHAR ", "
        inc rdx
        dec rbx
        jnz print_array
        NEWLINE
        PRINT_STRING "Program end.."
        ret
