.model small
.stack
.data
mensaje1 db 'Programa para Introducir datos','$'
mensaje2 db '1.¿Cual es tu nombre?: ','$'
mensaje3 db '2.¿Cual es tu edad?: ','$'
mensaje4 db '3.¿Te gusta la materia?: ','$'
mensaje5 db '4.¿Te gusta programar en ensamblador?: ','$'
mensaje6 db '5.¿Copiaste la Tarea?: ','$'
cadena1 db 30 dup(' ')
cadena2 db 04 dup(' ')
cadena3 db 10 dup(' ')
cadena4 db 10 dup(' ')
cadena5 db 10 dup(' ')
namepar label byte
maxlen   db    20
actlen   db    ?
namefld  db	20 dup(' ')
.code
iniciar:
mov ax,@data
mov ds,ax
;------------------------crear una pantalla
mov ax,0600h
mov bh,71h
mov cx,0000h
mov dx,184fh
int 10h
;------------------------mensaje inicial
;--------fijar el cursor
mov ah,02h
mov bh,00
mov dh,00
mov dl,20
int 10h
mov ah,09h
lea dx,mensaje1
int 21h
;-----------------------primera pregunta
;-------------fijar el cursor
mov ah,02h
mov bh,00
mov dh,03
mov dl,00
int 10h
mov ah,09h
lea dx,mensaje2
int 21h
;----------pausa
mov ah,08h
int 21h
;---------capturar cadena
mov ah,3fh
mov bx,00
mov cx,30 ;defines la longitud de la cadena
lea dx,cadena1 ; donde la guardaras
int 21h
;-------------------------termina primera pregunta
;-------------------------escribes la cadena en pantalla
;-------------fijas el cursor de nuevo
mov ah,02h
mov bh,00
mov dh,05
mov dl,00
int 10h
;---------escribir la cadena
;mov ah,40h
;mov bx,01
;mov cx,30
;lea dx,cadena1
;int 21h
mov ah,02h		;servicio para mostrar un caracter
mov cx,30		;longitud de la cadena
lea di,cadena1		;direccion de la cadena
repetir: mov dl,[di]	;caracter que se despliega
int 21h			;llama a dos
inc di			;incrementa para el siguiente caracter
loop repetir		;si aun no termina repide el ciclo
;-----------------------segunda pregunta
;-------------fijar el cursor
mov ah,02h
mov bh,00
mov dh,07
mov dl,00
int 10h
mov ah,09h
lea dx,mensaje3
int 21h
;----------pausa
mov ah,08h
int 21h
;---------capturar cadena
mov ah,3fh
mov bx,00
mov cx,04 ;defines la longitud de la cadena
lea dx,cadena2 ; donde la guardaras
int 21h
;-------------------------termina segunda pregunta
;-------------------------escribes la cadena en pantalla
;-------------fijas el cursor de nuevo
mov ah,02h
mov bh,00
mov dh,09
mov dl,00
int 10h
;---------escribir la cadena
;mov ah,40h
;mov bx,01
;mov cx,04
;lea dx,cadena1
;int 21h
mov ah,02h
mov cx,04
lea di,cadena2
repetir1: mov dl,[di]
int 21h
inc di
loop repetir1
;-----------------------tercera pregunta
;-------------fijar el cursor
mov ah,02h
mov bh,00
mov dh,11
mov dl,00
int 10h
mov ah,09h
lea dx,mensaje4
int 21h
;----------pausa
mov ah,08h
int 21h
;---------capturar cadena
mov ah,3fh
mov bx,00
mov cx,10 ;defines la longitud de la cadena
lea dx,cadena3 ; donde la guardaras
int 21h
;-------------------------termina tercera pregunta
;-------------------------escribes la cadena en pantalla
;-------------fijas el cursor de nuevo
mov ah,02h
mov bh,00
mov dh,13
mov dl,00
int 10h
;---------escribir la cadena
;mov ah,40h
;mov bx,01
;mov cx,04
;lea dx,cadena1
;int 21h
mov ah,02h
mov cx,10
lea di,cadena3
repetir2: mov dl,[di]
int 21h
inc di
loop repetir2
;-----------------------cuarta pregunta
;-------------fijar el cursor
mov ah,02h
mov bh,00
mov dh,15
mov dl,00
int 10h
mov ah,09h
lea dx,mensaje5
int 21h
;----------pausa
mov ah,08h
int 21h
;---------capturar cadena
mov ah,3fh
mov bx,00
mov cx,10 ;defines la longitud de la cadena
lea dx,cadena4 ; donde la guardaras
int 21h
;-------------------------termina cuarta pregunta
;-------------------------escribes la cadena en pantalla
;-------------fijas el cursor de nuevo
mov ah,02h
mov bh,00
mov dh,17
mov dl,00
int 10h
;---------escribir la cadena
;mov ah,40h
;mov bx,01
;mov cx,04
;lea dx,cadena1
;int 21h
mov ah,02h
mov cx,10
lea di,cadena4
repetir3: mov dl,[di]
int 21h
inc di
loop repetir3
;-----------------------quinta pregunta
;-------------fijar el cursor
mov ah,02h
mov bh,00
mov dh,19
mov dl,00
int 10h
mov ah,09h
lea dx,mensaje6
int 21h
;----------pausa
mov ah,08h
int 21h
;---------capturar cadena
mov ah,3fh
mov bx,00
mov cx,10 ;defines la longitud de la cadena
lea dx,cadena5 ; donde la guardaras
int 21h
;-------------------------termina quinta pregunta
;-------------------------escribes la cadena en pantalla
;-------------fijas el cursor de nuevo
mov ah,02h
mov bh,00
mov dh,21
mov dl,00
int 10h
;---------escribir la cadena
;mov ah,40h
;mov bx,01
;mov cx,04
;lea dx,cadena1
;int 21h
mov ah,02h
mov cx,10
lea di,cadena5
repetir4: mov dl,[di]
int 21h
inc di
loop repetir4
;-----------------------------salir
mov ax,4c00h
int 21h

end iniciar