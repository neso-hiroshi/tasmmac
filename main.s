format ELF64 object
processor cpu64_v8

public start as '_main'

segment readable executable
align 4

start:
    ; 1. Подготовка аргументов для write(1, msg, 19)
    mov     x0, #1                  ; Куда: stdout (1)
    adr     x1, msg                 ; Что: адрес строки (в FASMARM используем adr)
    mov     x2, #19                 ; Сколько байт: длина строки

    ; 2. Системный вызов write
    mov     x16, #4                 ; Номер вызова write = 4
    movk    x16, #0x0200, lsl #16   ; Накладываем маску класса BSD (0x02000000)
    svc     #0x80                   ; Вызов ядра в macOS

    ; 3. Системный вызов exit(0)
    mov     x0, #0                  ; Код возврата = 0
    mov     x16, #1                 ; Номер вызова exit = 1
    movk    x16, #0x0200, lsl #16   ; Накладываем маску класса BSD (0x02000000)
    svc     #0x80                   ; Вызов ядра

segment readable writeable
msg db 'Hello, macOS ARM64!', 10
