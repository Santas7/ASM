%include "io64_float.inc"

section .rodata
    two: dd 2.0
    a: dd 0.0
    b: dd 0.0
    
section .data
    x: dd 0.0

section .text
    global main
    main:
        READ_FLOAT a
        READ_FLOAT b 
        fld dword[b]
        fld dword[two]   
        fyl2x ; вычисляем показатель
        fld1 ; загружаем +1.0 в стек
        fld st1 ;  дублируем показатель в стек
        fprem ;  получаем дробную часть
        f2xm1 ; возводим в дробную часть показателя
        fadd ; прибавляем 1 из стека
        fscale ; возводим в целую 
        fld st1
        fpatan ; arctan(2^b)          
        fld dword[a]      
        fsub              ; arctan(2^b) - a
        fabs
        fstp dword[x]     
        PRINT_FLOAT x 
        ret
