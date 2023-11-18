%include "io64_float.inc"

section .rodata
    a0: dd 1.0
    factorial2: dd 2.0
    factorial4: dd 24.0
    factorial6: dd 720.0
    factorial8: dd 40320.0
    factorial10: dd 3628800.0
    factorial12: dd 479001600.0
    factorial14: dd 87178291200.0
    factorial16: dd 20922789888000.0
    factorial18: dd 6402373705728000.0
    factorial20: dd 2432902008176640000.0
    factorial22: dd 1124000727777607680000.0
    factorial24: dd 620448401733239439360000.0
    factorial26: dd 403291461126605650322784256.0
    factorial28: dd 304888344611713860501504000000.0
    factorial30: dd 265252859812191058636308480000000.0
 
section .text
    global main
    cos:
        READ_FLOAT xmm0
        ; cos(x) = a0 - x^2/2! + x^4/4! - x^6/6! + x^8/8! - x^10/10! + ...
        mulss xmm0, xmm0 ; x^2
        movss xmm1, xmm0 ; xmm1 = x^2
        movss xmm2, xmm1 ; xmm2 = x^2
        movss xmm3, [a0] ; xmm3 = a0
        divss xmm2, [factorial2] ; x^2/2!
        subss xmm3, xmm2  ; a0 - x^2/2!
        
        ; 2 часть
        mulss xmm1, xmm0 ; xmm1 = x^4
        movss xmm2, xmm1  
        divss xmm2, [factorial4] ; x^4/4!
        addss xmm3, xmm2  ; a0 - x^2/2! + x^4/4!
        
        ; 3 часть
        mulss xmm1, xmm0 ; xmm1 = x^6
        movss xmm2, xmm1 
        divss xmm2, [factorial6] ; x^6/6!
        subss xmm3, xmm2
        
        mulss xmm1, xmm0 
        movss xmm2, xmm1  
        divss xmm2, [factorial8] ; x^8/8!
        addss xmm3, xmm2 
        
        mulss xmm1, xmm0 
        movss xmm2, xmm1  
        divss xmm2, [factorial10] ; x^10/10!
        subss xmm3, xmm2  
        
        mulss xmm1, xmm0
        movss xmm2, xmm1 
        divss xmm2, [factorial12] ; x^12/12!
        addss xmm3, xmm2   
        
        mulss xmm1, xmm0 
        movss xmm2, xmm1  
        divss xmm2, [factorial14] ; x^14/14!
        subss xmm3, xmm2 
        
        mulss xmm1, xmm0 
        movss xmm2, xmm1  
        divss xmm2, [factorial16] ; x^16/16!
        addss xmm3, xmm2 
        
        mulss xmm1, xmm0 
        movss xmm2, xmm1  
        divss xmm2, [factorial18] ; x^18/18!
        subss xmm3, xmm2 
        
        mulss xmm1, xmm0 
        movss xmm2, xmm1  
        divss xmm2, [factorial20] ; x^20/20!
        addss xmm3, xmm2   
        
        mulss xmm1, xmm0 
        movss xmm2, xmm1  
        divss xmm2, [factorial22] ; x^22/22!
        subss xmm3, xmm2  
        
        mulss xmm1, xmm0 
        movss xmm2, xmm1  
        divss xmm2, [factorial24] ; x^24/24!
        addss xmm3, xmm2 
        
        mulss xmm1, xmm0 
        movss xmm2, xmm1  
        divss xmm2, [factorial26] ; x^26/26!
        subss xmm3, xmm2   
        
        mulss xmm1, xmm0 
        movss xmm2, xmm1  
        divss xmm2, [factorial28] ; x^28/28!
        addss xmm3, xmm2   
        
        mulss xmm1, xmm0 
        movss xmm2, xmm1  
        divss xmm2, [factorial30] ; x^30/30!
        subss xmm3, xmm2 
        PRINT_FLOAT xmm3
        ret
        
    main:
        call cos
        xor rax, rax
        ret
