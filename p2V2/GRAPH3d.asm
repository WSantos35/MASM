CalcularPeso macro limA,limB,Cont,Flag
    local conti
    local fin
    mov Flag,0
    mov ax,limB
    sub ax,limA
    cmp ax,32767
    ja fin
    cmp ax,8d
    ja conti
        mov bx,ax
        mov ax,8d
        mov dx,0
        div bx
        mov Cont,ax
        jmp fin
    conti:
        mov bx,8d
        mov dx,0
        div bx
        mov Cont,ax        
        mov Flag,1     
        cmp dx,0
        je fin
        inc Cont
        jmp fin
    fin:
endm 





INI3D macro
    local fin
    local XY
    local XZ
    local YZ
    local menu
    ;ResetPUntos
    ;--------------------------------------------
    ;Calculando PesoX
    ;--------------------------------------------    
    CalcularPeso limiteXa,limiteXb,PesoX,Flagx
    ;--------------------------------------------
    ;Calculando pesoY
    ;--------------------------------------------
    CalcularPeso limiteYa,limiteYb,pesoY,Flagy
    ;--------------------------------------------
    ;Calculando pesoZ
    ;--------------------------------------------
    CalcularPeso limiteZa,limiteZb,pesoZ,Flagz
    ;Calculando Ejes
    CalcEje3D limiteXa,limiteXb,PesoX,pos_ejex,Flagx
    CalcEje3D limiteYa,limiteYb,pesoY,pos_ejey,Flagy
    CalcEje3D limiteZa,limiteZb,pesoZ,pos_ejez,Flagz

    ;HexToDec16 pos_ejex,prb
    ;imprimir prb
    ;imprimir salto
;
    ;HexToDec16 pos_ejey,prb
    ;imprimir prb
    ;imprimir salto    

    GXY3D
    fin:
endm


CalcularValor macro Val,limA,Cont,pos_eje,Flag
    local Et1
    local fin
    ;mov ax,Flag
    ;cmp Flag,0
    ;je Et1
        mov ax,Val
        sub ax,pos_eje        
        mov bx,limA
        mul bx     
        mov Cont,ax                    
    ;Et1:
    fin:
endm 

GXY3D macro
    local etq
    local fin
    ;INISCREEN
    mov     ah,0
    mov     al, 00h
    ;mov     al, 10h
    int     10h
    ; blinking disabled for compatibility with dos,
    ; emulator and windows prompt do not blink anyway.
    mov     ax, 1003h
    mov     bx, 0      ; disable blinking.
    int     10h    
    ;------------------
    ;Dibujando grafica
    ;------------------
    ;limpia
    mov cx,0
    etq:
        GraphLeft3d cx
        inc cx    
    cmp cx,8
    jb etq
    fin:
endm

bloque db 219,'$'
kolor db 0
aux81 db 0
aux82 db 0
Flagx db 0
Flagy db 0
Flagz db 0
size_ejex dw 0
size_ejey dw 0
size_ejez dw 0
auxz dw 0
ptrtx512 dw 0

GraphLeft3d macro valZ
    local For1
    local For2
    local conti
    push cx

    ;mov kolor,al
    ;Calculando valor de variableZ
        mov ax,valZ
        mov auxz,ax
        mov kolor,al
        CalcularValor auxz,limiteZa,varZ,pos_ejez,Flagz

;apuntador txt512
lea si,cadenaEnviar

 
mov ptrtx512,si 

    mov Contador1,0
    For1:
    CalcularValor Contador1,limiteYa,VarY,pos_ejey,Flagy
        mov Contador2,0
        mov letra,0
        For2:
        ;********************************************************************
        mov letra,'0'
        ;********************************************************************
        CalcularValor Contador2,limiteXa,VarX,pos_ejex,Flagx

        mov ax,Contador2 
        mov aux81,al
        mov ax,Contador1
        mov aux82,al   
           mov Respuesta,0
           ExecEc
           cmp Respuesta,32767
           ja conti
           imprimirVideo bloque,aux81,aux82,kolor
           mov letra,'1'
    ;limpia
    ;HexToDec16 VarX,prb
    ;imprimir prb
    ;imprimir salto
    ;HexToDec16 VarY,prb
    ;imprimir prb
    ;imprimir salto
    ;HexToDec16 VarZ,prb
    ;imprimir prb
    ;imprimir salto
    ;imprimir salto
    ;pause

            conti:            
        ;********************************************************************
	mov si,ptrtx512	
	mov al,letra
	mov byte ptr[si],al
	inc ptrtx512
        
        ;********************************************************************
        inc Contador2
        cmp Contador2,8
        jb For2
    inc Contador1
    cmp Contador1,8
    jb For1
	ENVIAR_CADENA_ARDUINO cadenaEnviar
    ;mov ax,pos_ejey
    ;mov aux81,al
    ;mov ax,pos_ejex
    ;mov aux82,al    
    ;imprimirVideo bloque,aux81,aux82,0FH

;    pause
    pop cx 

endm 

CalcEje3D macro limA,limB,peso,pos_eje,Flag
    ;macro que alcula la posicion del eje
    local no_drawLv
    local mayor8
    cmp limA,32767;comprobando si es negativo
    jb no_drawLv
    cmp limB,32767;comprobando si es positivo
    ja no_drawLv
        mov ax,0
        sub ax,limA
        mov bx,peso        
        cmp Flag,0
        jne mayor8
            mul bx  
            mov pos_eje,aX  
            jmp no_drawLv
        mayor8:
            mov dx,0
            div bx
            mov pos_eje,aX          
    no_drawLv:
endm
