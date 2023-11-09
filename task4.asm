%include "io64_float.inc"

section .rodata
    a: dd 0.5
    exp: dd 2.7182818284
    two: dd 2.0 ; просто число 2
    x: dd 0.0
    y: dd 0.0
    numerator: dd 0.0 ; числитель
    denominator: dd 0.0; знаменатель
    right: dd 0.0  ; правая часть выражения

section .text
    global main
    main:
        call checker
        ret
        
    checker:
        READ_FLOAT x
        READ_FLOAT y
        ; Вычисление 2 * a/x
        fld dword[a]     
        fld dword[x]     
        fdiv 
        fld dword[two]
        fmul  
        fstp dword[x]
        
        ; Вычисление e^(2(a/x)) + 1   
        fld dword[exp]  
        fld dword[x]
        fldl2e ; log2[e]
        fmulp st1, st0
        fld st0
        frndint ; округление к ближайшему целому
        fsub st1, st0 
        fxch st1 ; swap()
        f2xm1 ; возводим в дробную часть 
        fld1 ; const 1.0
        faddp st1, st0
        fscale ; возводим в целую часть + умножение
        fld st1
        fadd ; + 1
        fstp dword[denominator]

        ; Вычисление e^(2(a/x)) - 1
        fld dword[exp]  
        fld dword[x]
        fldl2e ; log2[e]
        fmulp st1, st0
        fld st0
        frndint
        fsub st1, st0
        fxch st1
        f2xm1
        fld1 ; const 1.0
        faddp st1, st0
        fscale
        fld st1 
        fsub ; - 1
        fstp dword[numerator]

        ; частное числитель/знаменатель - th(a/x)
        fld dword[denominator] 
        fld dword[numerator] 
        fdiv
        fstp dword[right] 
        PRINT_STRING "Left: "
        PRINT_FLOAT y
        NEWLINE
        PRINT_STRING "Right: "
        PRINT_FLOAT right  
        NEWLINE
        
        ; проверка на равенство левой и правой части
        fld dword[right] 
        fld dword[y]
        fcomip ; условная инструкция
        je yes
        PRINT_STRING "NO" 
        ret

    yes:
        PRINT_STRING "YES"
        ret
