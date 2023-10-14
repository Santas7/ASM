%include "io64_float.inc"
%include "io64.inc"

section .data
    ; :value: - вещественное число которое нужно ввести (8 байт)
    ; :res_round: - результат округления вверх (4 байт)
    value: dq 0.0
    mode: dd 0

section .text
    global main
    fpu87:
        READ_DOUBLE value
        ; сохраняем CW FPU в mode
        fstcw [mode] 
        mov al, [mode+1]
        or al, 8
        mov [mode+1], al
        ; загрузка CW FPU
        fldcw [mode] 
        fld qword[value] ; ST(0)
        fistp qword[value]
        mov rax, [value]
        PRINT_DEC 8, rax
        ; обнуление значений
        mov word [mode], 0
        xor rax, rax
        ret

    sse:
        READ_DOUBLE xmm0
        ; сохраняем состояния регистра MXCSR в mode
        stmxcsr [mode] 
        or qword[mode], 0x00004000
        ; загрузка CW
        ldmxcsr [mode]
        ; в целое число
        cvtss2si rax, xmm0
        PRINT_DEC 8, rax
        xor rax, rax
        ret

    main:
        ; 1 часть FPUx87
        PRINT_STRING "Result FPUx87: "
        call fpu87
        ; 2 часть SSE
        NEWLINE
        PRINT_STRING "Result SSE: "
        call sse
        ret
