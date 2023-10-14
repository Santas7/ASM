%include "io64_float.inc"

section .rodata
    a0 dd 1.0
    factorial2 dd 2.0
    factorial4 dd 24.0
    factorial6 dd 720.0

section .text
    global main
    main:
        ;write your code here
        call calculate_cosine
        xor rax, rax
        ret
    
    calculate_cosine:
        READ_FLOAT xmm0
    
        ; приближение cos(x) = a0 - (x^2/2!) + (x^4/4!) - (x^6/6!) + ... 
        movss xmm1, xmm0
        mulss xmm1, xmm0  ; x^2
        
        movss xmm2, xmm1
        movss xmm3, [a0]
        ; x^2/2!
        divss xmm2, [factorial2]
        subss xmm3, xmm2  ; a0 - x^2/2!
        
        movss xmm2, xmm1
        movss xmm4, [factorial4]
        ; x^4/4!
        divss xmm2, xmm4
        addss xmm3, xmm2  ; a0 - x^2/2! + x^4/4!
        
        ; x^6/6!
        movss xmm2, xmm1
        mulss xmm2, xmm1  ; x^6
        movss xmm4, [factorial6]
        divss xmm2, xmm4
        subss xmm3, xmm2  ; a0 - x^2/2! + x^4/4! - x^6/6! + ...
        
        PRINT_FLOAT xmm3
        ret
