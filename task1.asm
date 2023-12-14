section .rodata
    two: dd 2.0
    format: db "%f", 0

section .text
    global main
    extern printf
    extern scanf
    extern malloc
    extern free

main:
    push rbx 
    push rbp
    mov rbp, rsp 
    sub rsp, 56

    ; malloc - выделение памяти на переменную, в которую считаем значение (её адрес в rbx)
    lea rbx, [rbp - 8]

    ; Вызов scanf
    lea rdi, [format]
    mov rsi, rbx
    call scanf

    fld dword [rbx]

    lea rbx, [rbp - 8]

    lea rdi, [format]
    mov rsi, rbx
    call scanf

    fld dword [two]   
    fyl2x ; вычисляем показатель
    fld1 ; загружаем +1.0 в стек
    fld st1 ; дублируем показатель в стеке
    fprem ; получаем дробную часть
    f2xm1 ; возводим в дробную часть показателя
    fadd ; прибавляем 1 из стека
    fscale ; возводим в целую 
    fld st1
    fpatan ; arctan(2^b) 
    fld dword [rbx]               
    fsub ; arctan(2^b) - a
    fabs 
    fstp qword [rbx]

    ; printf с параметром для float
    lea rdi, [format]
    mov rax, 1
    movsd xmm0, qword [rbx]
    call printf

    leave
    pop rbx ; Восстановление неизменяемого регистра
    xor rax, rax
    ret
