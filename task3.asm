%include "io64_float.inc"

section .rodata
    two dd 2.0
    a dd 1.0
    b dd 3.0

section .data
    x dd 0.0

section .text
    global main
    main:
        fld dword[two]     
        fld dword[b]   ; ST(1) = b
        f2xm1
        fpatan            
        fld dword[a]      
        fsub              ; arctan(2^b) - a
        fstp dword[x]     
        PRINT_FLOAT x 
        ret
