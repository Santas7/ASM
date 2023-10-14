%include "io64_float.inc"

section .rodata
    a dd 0.5
    exp dd 2.7182818284
    two dd 2.0
    
section .bss
    x resq 1
    y resq 1
    numerator resq 1 ; числитель
    denominator resq 1 ; знаменатель
    right resq 1  ; правая часть выражения

section .text
    global main
    main:
        READ_FLOAT x
        READ_FLOAT y

        fld dword[a]     
        fld dword[x]     
        fdiv
        fstp dword[x]
        fld dword[x]  
        fld dword[two]
        fmul  
        fstp dword[x]
        
        ; получаем 2x
        PRINT_FLOAT x  
        NEWLINE
        
        ; Вычислить e^(2(a/x)) - 1
        fld dword[x]     
        fild dword[exp]  
        
        ; вычисление e^2x

        fstp dword[numerator]  
        
        
        ; Вычислить e^(2(a/x)) + 1
        fld dword[x]
        fld dword[exp]
        
        ; вычисление e^2x
        
        fstp dword[denominator]
        
        fld dword[numerator] 
        fld dword[denominator] 
        fdiv
        fstp dword[right]  ; Сохранить результат в right
        PRINT_FLOAT right  ; Вывести результат
        ret
