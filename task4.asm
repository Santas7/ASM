%include "io64_float.inc"

section .rodata
    a dd 0.5
    exp dd 2.7182818284
    one dd 1.0
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
        
        ; Вычислить e^(2(a/x)) - 1
        fld dword[x]     
        fild dword[exp]  
        movss xmm0, dword[x]
        movss dword[numerator], xmm0
        fld dword[numerator]
        fldl2e
        fmulp st1, st0
        fld st0
        frndint
        fsub st1, st0
        fxch st1
        f2xm1
        fld1
        faddp st1, st0
        fscale
        fld dword[one]
        fadd 
        fstp dword[numerator]

        ; Вычислить e^(2(a/x)) + 1
        fld dword[x]
        fld dword[exp]
        movss xmm0, dword[x]
        movss dword[denominator], xmm0
        fld dword[denominator]
        fldl2e
        fmulp st1, st0
        fld st0
        frndint
        fsub st1, st0
        fxch st1
        f2xm1
        fld1
        faddp st1, st0
        fscale
        fld dword[one]
        fsub 
        fstp dword[denominator]
        
        ; частное числитель/знаменатель
        fld dword[numerator] 
        fld dword[denominator] 
        fdiv
        fstp dword[right] 
        PRINT_STRING "Left: "
        PRINT_FLOAT y
        NEWLINE
        PRINT_STRING "Right: "
        PRINT_FLOAT right  
        NEWLINE
        
        ; проверка на равенство левой и правой части
        movss xmm0, dword[right]
        movss xmm1, dword[y]
        cmpeqss xmm0, xmm1
        je answer_yes
        jmp answer_no
       
    answer_yes:
        PRINT_STRING "YES equal"
        jmp end
    
    answer_no:
        PRINT_STRING "NO equal"
    
    end:
        ret
