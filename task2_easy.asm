section .text
extern access6
global main
main:
    push rbp
    mov rbp, rsp
    sub rsp, 32 ; 20h -> 32 в десятичной
    ;mov rcx, 3000000
    mov r9, 10000000000
    call access6
    mov rsp, rbp
    pop rbp
    xor rax, rax
    ret
