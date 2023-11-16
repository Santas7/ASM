section .rodata
    two: dd 2.0
    format: db "%f", 0


section .text
    global main
    extern printf
    extern scanf
    extern malloc
    extern free

    main:
        push r12 ;Сохранение неизменяемого регистра
        push rbp
        mov rbp, rsp 
        sub rsp, 40
        
        ;malloc - выделение памяти на переменную, в которую считаем значение (её адрес в r12)
        mov rcx, 8
        call malloc
        mov r12, rax
        
        ;Вызов scanf для float
        lea rcx, [format]
        mov rdx, r12
        call scanf
    
        fld dword[r12]
        
        mov rcx, r12
        call free
        xor rax, rax
        
        mov rcx, 8
        call malloc
        mov r12, rax
        
        lea rcx, [format]
        mov rdx, r12
        call scanf
        
    
        fld dword [two]   
        fyl2x ; вычисляем показатель
        fld1 ; загружаем +1.0 в стек
        fld st1 ;  дублируем показатель в стек
        fprem ;  получаем дробную часть
        f2xm1 ; возводим в дробную часть показателя
        fadd ; прибавляем 1 из стека
        fscale ; возводим в целую 
        fld st1
        fpatan ; arctan(2^b) 
        fld dword[r12]               
        fsub              ; arctan(2^b) - a
        fabs 
        fstp dword[r12]
        ;printf с параметром для float
        lea rcx, [format]
        movsd xmm1, qword[r12]
        cvtps2pd xmm1, xmm1
        movq rdx, xmm1
        call printf
        
        ;free - очистка памяти в r12
        mov rcx, r12
        call free
        xor rax, rax
        
        leave
        pop r12 ;Восстановление неизменяемого регистра
        xor rax, rax
        ret
