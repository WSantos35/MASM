 
    ;-------------------VARIABLES USADAS POR EL MENU--------------------------
    ms1 db 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA $'
    ms2 db  13,10,'FACULTAD DE INGENIERIA',13,10,"CIENCIAS Y SISTEMAS $"    
    ms3 db  13,10,'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1 $'
    ms4 db  13,10,"SECCION A $"
    ms5 db  13,10,"INTEGRANTES: ALBERTO IXCHOP ORDOï¿½EZ $"
    ms6 db  13,10,"CARNET: 201700727 $"
    ms7 db  13,10,"TAREA PRACTICA 5$"
    ms8 db  13,10,10,"===========MENU PRINCIPAL=========$"
    ms9 db  13,10,10,"1) Cargar ecuacion$"
    ms10 db  13,10,"2) Grafica 2D$"
    ms11 db  13,10,"3) Grafica 3D$"
    ms12 db  13,10,"4) Control movil$"
    ms122 db  13,10,"5) Salir$"
    ms13 db  13,10,10,"Ingrese el numero de la accion$"       


    


    err1 db  13,10,10,"Opcion incorrecta, vuelva a intentar$"       
    salto db 13,10,'$'
    tab db 09,'$',0
    spacio db ' ','$',0
    Nulll db 'A','$'
    
    opcion DB 2,0,0,0,0,0,0 


    op1   db '1'
    op2   db '2'
    op3   db '3'
    op4   db '4'
    op5 db '5'

    wFecha db 'Fecha: ',0,'$'
    wHora db 'Hora :',0,'$'
    wsepf db '/',0,'$'
    wseph db ':',0,'$'
    saltohtml db '<br>'

;------------------------------Macro que imprime en pantalla------------
    imprimir macro string1
        push dx
        push ax
        mov dx,offset string1
        mov ah,9
        int 21h
        pop ax        
        pop dx
    endm      
    
    leer macro content
        lea dx,content         
        mov ah, 0ah
        int 21h        
        mov bx, dx
        mov ah, 0
        mov al,[bx+1]
        add bx, ax ; point to end of string.
        mov byte ptr [bx+2], 0 ; put dollar to the end.                 
        mov byte ptr [bx+3], '$' ; put dollar to the end.                 
        ;mov byte ptr [bx+2], '?' ; put dollar to the end.                 
    endm          

    ;------------------------------Macro que Compara 2 cadenas--------------------------
    CompareString macro string1,string2,size,EV
        ;----------------------------------------
        ;IF que compara dos cadenas             |
        ;   Donde:                              |
        ;   strin1  Cadena1                     |
        ;   strin2  Cadena2                     |
        ;   size   cantidad de texto a comparar |
        ;   EV    etiqueta verdadero            |
        ;----------------------------------------
        mov ax,@data
        mov ds,ax
        mov es,ax
        mov cx, size
        lea si, string1
        lea di, string2
        repe cmpsb    
        je EV
    endm

    CompareStringF macro string1,string2,size,EF
        ;----------------------------------------
        ;IF que compara dos cadenas             |
        ;   Donde:                              |
        ;   strin1  Cadena1                     |
        ;   strin2  Cadena2                     |
        ;   size   cantidad de texto a comparar |
        ;   EV    etiqueta verdadero            |
        ;----------------------------------------
        mov ax,@data
        mov ds,ax
        mov es,ax
        mov cx, size
        lea si, string1
        lea di, string2
        repe cmpsb
        jne EF
    endm        
        
    ;------------------------------Macro que finaliza el programa ------------------------------
    finalizar macro
        mov ax,0c07h
        int 21h
        .exit
    endm

    ;------------------------------Macro que pausa el programa ------------------------------
    pause macro
        push ax
        mov ax,0c07h
        int 21h
        pop ax
    endm    
    ;------------------------------Macro que imprime el menu ------------------------------
    print_menu macro
        imprimir ms1        
        imprimir ms2
        imprimir ms3
        imprimir ms4
        imprimir ms5
        imprimir ms6
        imprimir ms7
        imprimir ms8
        imprimir ms9
        imprimir ms10
        imprimir ms11
        imprimir ms12
        imprimir ms122        
        imprimir ms13
        imprimir salto
    endm  

;------------------------------Macro que limpia la pantalla------------------------------
    limpia macro 
    mov ah,00h
    mov al,03h
    int 10h    
    endm

;Macro que limpia una cadena y rellena con Null (0)
;el primer byte indica el tamaño total de la cadena
;el segundo byte indica el tamaño ocupado de la cadena
;este macro limpiara completamente la cadena dejando al final solo $,0
CLSTR MACRO ST
    local repetir
    local fin
    lea si,ST
    add si,2
    mov cx,st
    repetir
    mov [si],0
    loop repetir
ENDM




COPYSTR macro str1,str2
;copia la cadena del str2 al str1
local copiar
push ax
push bx
push cx
push si

mov bx, offset str1
mov si, offset str2
mov ch,0
mov cl,byte ptr[si]

copiar:
mov ah,byte ptr[si]
mov byte ptr[bx],ah
inc bx
inc si
loop copiar
mov byte ptr[bx],'$'
mov byte ptr[bx+1],0
pop si
pop cx
pop bx
pop ax
endm

;Macro que imprime en modo de video EGA, esdecir ah=0 al=Eh int21h
imprimirEGA macro txt,fila,col,color
    local fin
    local continue
    local contar
    push ax
    push bx
    push cx
    push si
    push es
    push bp





    mov cx,0    
    ;contando caracteres a imprimi
    lea si,txt
    contar:
    cmp byte ptr[si],'$'
    je continue
    cmp byte ptr[si],0
    je continue
    inc cx
    inc si
    jmp contar

    continue:
    cmp cx,0
    je fin    


	mov al, 1
	mov bh, 0
	mov bl, 255d;color blanco 255
	
	mov dl, col;columna
	mov dh, fila;fila

    mov si,@data
    mov es,si
	lea bp, txt

	mov ah, 13h
	int 10h

    
    fin:
    pop bp
    pop es
    pop si
    pop cx
    pop bx
    pop ax    
endm


imprimirVideo macro txt,fila,col,atr
    local loop1
    push ax
    push bx
    push cx
    push si
    push es
    push bp
    ;Posicionando cursor
    ;se supondra que se utiliza el modo de video DH
    ;resolucion:40x25
    ;espera variables de 8 bit para fila y columa
    mov ah,0
    mov al,fila
    mov bx,80d
    mul bx
    mov bx,0
    mov bl,col
    mov di,ax
    add di,bx
    add di,bx




    ;temp
    ;mov di,80d
  
  
  mov ax,0b800h
  mov es,ax
  mov si,offset txt 		; offset ofMessage string terminating with $
  ;mov di,420                              ; Make Destination Index point to B800:0000
    loop1:
        mov ah,atr              ;Atribute,color o subrayado        
        mov al,[si]				; Read First Character
        mov es:[di],ax                        ; Write to Video
        inc si                                ; Point to next character
        inc di
        ;mov es:[di],cx                       
        inc di                                ; Next Display Area
        mov al,[si]
        cmp al,'$'
    jne loop1                             ; if not '$' jump to loop1 				 


    pop bp
    pop es
    pop si
    pop cx
    pop bx
    pop ax    
endm


