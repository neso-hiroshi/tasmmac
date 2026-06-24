.global _main
.align 2

_main:
    ; 1. Подготовка аргументов для write(1, msg, 14)
    mov     x0, #1                  ; Куда: stdout (1)
    adrp    x1, msg@PAGE            ; Что: адрес строки (страница)
    add     x1, x1, msg@PAGEOFF     ; Смещение строки
    mov     x2, #14                 ; Сколько байт: длина строки

    ; 2. Системный вызов write
    mov     x16, #4                 ; Номер вызова write = 4
    movk    x16, #0x0200, lsl #16   ; Накладываем маску класса BSD (0x02000000)
    svc     #0x80                   ; Вызов ядра (в macOS используется svc #0x80)

    ; 3. Системный вызов exit(0)
    mov     x0, #0                  ; Код возврата = 0
    mov     x16, #1                 ; Номер вызова exit = 1
    movk    x16, #0x0200, lsl #16   ; Накладываем маску класса BSD (0x02000000)
    svc     #0x80                   ; Вызов ядра

.data
msg: .ascii "Hello, macOS!\n"
