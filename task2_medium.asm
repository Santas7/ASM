section .data
    ; long, long, float, float
    array dd 0, 0, 1, 0

section .text
    extern _ZN6medium4var66accessERKNS0_1SEdi
    global main

main:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    lea rcx, [array]
    mov r8d, -1000000000
    call _ZN6medium4var66accessERKNS0_1SEdi
    mov rsp, rbp
    pop rbp
    xor rax, rax
    ret
