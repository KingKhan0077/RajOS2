%include "print_string.asm"
%include "disk_load.asm"
%include "print_hex.asm"
%include "gdt.asm"
%include "print_string_pm.asm"
%include "swith_to_pm.asm"

[ org 0x7c00 ]
KERNEL_OFFSET equ 0x1000
mov [ BOOT_DRIVE ] , dl
mov bp , 0x9000
mov sp , bp
; Set - up the stack.
mov bx , MSG_REAL_MODE ; Announce that we are starting
call print_string
; booting from 16 - bit real mode
call load_kernel ; Load our kernel
call switch_to_pm ; Switch to protected mode , from which
; we will not return
jmp $

[ bits 16]
; load_kernel
load_kernel :
mov bx , MSG_LOAD_KERNEL
call print_string
mov bx , KERNEL_OFFSET
mov dh , 15
mov dl , [ BOOT_DRIVE ]
call disk_load
ret
[ bits 32]

BEGIN_PM :
mov ebx , MSG_PROT_MODE ; Use our 32 - bit print routine to
call p ri nt _s t ri ng _ pm
; announce we are in protected mode
call KERNEL_OFFSET ; Now jump to the address of our loaded
; kernel code , assume the brace position ,
; and cross your fingers. Here we go !
jmp $ ; Hang.
; Global variables
BOOT_DRIVE db 0

MSG_REAL_MODE db " Started in 16 - bit Real Mode " , 0

MSG_PROT_MODE db " Successfully landed in 32 - bit Protected Mode " , 0

MSG_LOAD_KERNEL db " Loading kernel into memory. " , 0




; Bootsector padding
times 510 -( $ - $$ ) db 0
dw 0 xaa55










