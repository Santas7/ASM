%include "io64_float.inc"

section .rodata
    two dd 2.0

section .bss
    a resq 1
    b resq 1
    
section .data
    x dd 0.0

section .text
    global main
    main:
        READ_FLOAT a
        READ_FLOAT b
        fld dword[two]     
        fld dword[b]
        f2xm1
        fpatan            
        fld dword[a]      
        fsub              ; arctan(2^b) - a
        fabs
        fstp dword[x]     
        PRINT_FLOAT x 
        ret
