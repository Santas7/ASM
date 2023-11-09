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
    degtorad: dd 0.0174533

section .text
    global main
    acos:
        READ_FLOAT xmm0
        mulss xmm0, [degtorad]
        ; приближение cos(x) = a0 - (x^2/2!) + (x^4/4!) - (x^6/6!) + ... 
        ; 1 часть
        movss xmm1, xmm0 ; 30
        mulss xmm1, xmm0  ; x^2
        movss xmm2, xmm1
        movss xmm3, [a0]
        ; x^2/2!
        divss xmm2, [factorial2]
        subss xmm3, xmm2  ; a0 - x^2/2!
        
        ; 2 часть
        movss xmm2, xmm1
        movss xmm4, [factorial4]
        ; x^4/4!
        divss xmm2, xmm4
        addss xmm3, xmm2  ; a0 - x^2/2! + x^4/4!
        
        ; 3 часть
        movss xmm2, xmm1
        mulss xmm2, xmm1  ; x^6
        movss xmm4, [factorial6]
        ; x^6/6!
        divss xmm2, xmm4
        subss xmm3, xmm2  ; a0 - x^2/2! + x^4/4! - x^6/6!
        
        ; 4 часть
        movss xmm2, xmm1
        movss xmm5, [factorial8]
        ; x^8/8!
        divss xmm2, xmm5
        addss xmm3, xmm2  ; a0 - x^2/2! + x^4/4! - x^6/6! + x^8/8!
        
        ; 5 часть
        movss xmm2, xmm1
        mulss xmm2, xmm1  ; x^10
        movss xmm5, [factorial10]
        ; x^10/10!
        divss xmm2, xmm5
        subss xmm3, xmm2  ; a0 - x^2/2! + x^4/4! - x^6/6! + x^8/8! - x^10/10!
        
        ; 6 часть
        movss xmm2, xmm1
        movss xmm6, [factorial12]
        ; x^12/12!
        divss xmm2, xmm6
        addss xmm3, xmm2  ; a0 - x^2/2! + x^4/4! - x^6/6! + x^8/8! - x^10/10! + x^12/12!
        
        ; 7 часть
        movss xmm2, xmm1
        mulss xmm2, xmm1  ; x^14
        movss xmm6, [factorial14]
        ; x^14/14!
        divss xmm2, xmm6
        subss xmm3, xmm2  ; a0 - x^2/2! + x^4/4! - x^6/6! + x^8/8! - x^10/10! + x^12/12! - x^14/14!
        
        ; 8 часть
        movss xmm2, xmm1
        movss xmm7, [factorial16]
        ; x^16/16!
        divss xmm2, xmm7
        addss xmm3, xmm2  ; a0 - x^2/2! + x^4/4! - x^6/6! + x^8/8! - x^10/10! + x^12/12! - x^14/14! + x^16/16!
        
        ; 9 часть
        movss xmm2, xmm1
        mulss xmm2, xmm1  ; x^18
        movss xmm7, [factorial18]
        ; x^18/18!
        divss xmm2, xmm7
        subss xmm3, xmm2  ; a0 - x^2/2! + x^4/4! - x^6/6! + x^8/8! - x^10/10! + x^12/12! - x^14/14! + x^16/16! - x^18/18!
        
        ; 10 часть
        movss xmm2, xmm1
        movss xmm8, [factorial20]
        ; x^20/20!
        divss xmm2, xmm8
        addss xmm3, xmm2  ; a0 - x^2/2! + x^4/4! - x^6/6! + x^8/8! - x^10/10! + x^12/12! - x^14/14! + x^16/16! - x^18/18! + x^20/20!
        
        ; 11 часть
        movss xmm2, xmm1
        mulss xmm2, xmm1  ; x^22
        movss xmm8, [factorial22]
        ; x^22/22!
        divss xmm2, xmm8
        subss xmm3, xmm2  ; a0 - x^2/2! + x^4/4! - x^6/6! + x^8/8! - x^10/10! + x^12/12! - x^14/14! + x^16/16! - x^18/18! + x^20/20! - x^22/22!
        
        ; 12 часть
        movss xmm2, xmm1
        movss xmm9, [factorial24]
        ; x^24/24!
        divss xmm2, xmm9
        addss xmm3, xmm2  ; a0 - x^2/2! + x^4/4! - x^6/6! + x^8/8! - x^10/10! + x^12/12! - x^14/14! + x^16/16! - x^18/18! + x^20/20! - x^22/22! + x^24/24!
        
        ; 13 часть
        movss xmm2, xmm1
        mulss xmm2, xmm1  ; x^26
        movss xmm9, [factorial26]
        ; x^26/26!
        divss xmm2, xmm9
        subss xmm3, xmm2  ; a0 - x^2/2! + x^4/4! - x^6/6! + x^8/8! - x^10/10! + x^12/12! - x^14/14! + x^16/16! - x^18/18! + x^20/20! - x^22/22! + x^24/24! - x^26/26!
        
        ; 14 часть
        movss xmm2, xmm1
        movss xmm10, [factorial28]
        ; x^28/28!
        divss xmm2, xmm10
        addss xmm3, xmm2  ; a0 - x^2/2! + x^4/4! - x^6/6! + x^8/8! - x^10/10! + x^12/12! - x^14/14! + x^16/16! - x^18/18! + x^20/20! - x^22/22! + x^24/24! - x^26/26! + x^28/28!
        
        ; 15 часть
        movss xmm2, xmm1
        mulss xmm2, xmm1  ; x^30
        movss xmm10, [factorial30]
        ; x^30/30!
        divss xmm2, xmm10
        subss xmm3, xmm2  ; a0 - x^2/2! + x^4/4! - x^6/6! + x^8/8! - x^10/10! + x^12/12! - x^14/14! + x^16/16! - x^18/18! + x^20/20! - x^22/22! + x^24/24! - x^26/26! + x^28/28! - x^30/30!
        
        PRINT_FLOAT xmm3
        ret
        
    main:
        call acos
        xor rax, rax
        ret
