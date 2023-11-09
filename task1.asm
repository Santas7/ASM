section .rodata
    two: dd 2.0
    x: db "", 0dh, 0
    a: db "%f", 0
    b: db "%f", 0

section .text
    global main
    extern printf, scanf, malloc, free

main:
    push rbp
    mov rbp, rsp 
    sub rsp, 40
    mov rcx, 8
    call malloc
    mov r12, rax
    push rbp
    mov rbp, rsp 
    sub rsp, 40
    lea rcx, [b]
    mov rdx, r12
    call scanf
    fld dword [b]
    leave
    push rbp
    mov rbp, rsp 
    sub rsp, 40
    mov rcx, r12
    call free
    leave
    fld dword [two]   
    fyl2x
    fld1
    fld st1
    fprem
    f2xm1
    fadd
    fscale
    fld st1
    fpatan
    push rbp
    mov rbp, rsp 
    sub rsp, 40
    mov rcx, 8
    call malloc
    mov r12, rax
    push rbp
    mov rbp, rsp 
    sub rsp, 40
    lea rcx, [a]
    mov rdx, r12
    call scanf
    fld dword [a]
    leave
    push rbp
    mov rbp, rsp 
    sub rsp, 40
    mov rcx, r12
    call free
    leave     
    fsub
    fabs
    fstp dword [x]
    push rbp
    mov rbp, rsp 
    sub rsp, 40
    lea rcx, [x]
    mov rdx, [r12]
    call printf
    leave
    push rbp
    mov rbp, rsp 
    sub rsp, 40
    mov rcx, r12
    call free
    leave
    ret
