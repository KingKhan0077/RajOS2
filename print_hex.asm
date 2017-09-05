print_hex :
; TODO : manipulate chars at HEX_OUT to reflect DX
mov bx , HEX_OUT
; print the string pointed to
call print_string ; by BX ret
; global variables
HEX_OUT : DB 0x0000,0
