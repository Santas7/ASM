section .data
    array: dq 1, 1
    
section .text
    extern _ZN4hard4var61C6accessERNS0_1SE
    global main

main:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    lea rcx, [array]
    ; т к rcx - массив (по факту сравнение указателей)
    mov [rdx], rcx
    call _ZN4hard4var61C6accessERNS0_1SE
    mov rsp, rbp
    pop rbp
    xor rax, rax
    ret
