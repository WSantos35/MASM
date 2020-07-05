    ms14 db  13,10,10,"===========Grafica 2D=========$"
    ms15 db  13,10,10,"1) X-Y$"
    ms16 db  13,10,"2) X-Z$"
    ms17 db  13,10,"3) Y-Z$"
    ms18 db  13,10,"4) Salir$"
    ms19 db  13,10,10,"Ingrese el numero de la accion$"       

HLINE db 40 dup (196d),'$'
VLINE db 179d,'$'

pos_ejex dW 0
pos_ejey dW 0
pos_ejez dW 0
PesoX dw 0
Pesoy dw 0
Pesoz dw 0

INI2D macro
    local fin
    local XY
    local XZ
    local YZ
    local menu
    ;--------------------------------------------
    ;Calculando PesoX
    ;--------------------------------------------    
    mov ax,limiteXb
    sub ax,limiteXa    
    cmp ax,0
    je fin    
    mov bx,ax
    mov ax,318d
    mov dx,0
    div bx
    mov PesoX,ax
    ;--------------------------------------------
    ;Calculando pesoY
    ;--------------------------------------------
    mov ax,limiteYb
    sub ax,limiteYa    
    cmp ax,0
    je fin    
    mov bx,ax
    mov ax,196d
    mov dx,0
    div bx
    mov Pesoy,ax
    ;--------------------------------------------
    ;Calculando pesoZ
    ;--------------------------------------------
    mov ax,limiteZb
    sub ax,limiteZa    
    cmp ax,0
    je fin    
    mov bx,ax
    mov ax,196d
    mov dx,0
    div bx
    mov Pesoz,ax        

    menu:
    limpia
    imprimir ms14
    imprimir ms15
    imprimir ms16
    imprimir ms17
    imprimir ms18
    imprimir ms19
    imprimir salto
    leer opcion       ;Leyendo opcion
    ;Switch para comparar valores    
    CompareString opcion+2,op1,1,XY
    CompareString opcion+2,op2,1,XZ
    CompareString opcion+2,op3,1,YZ
    CompareString opcion+2,op4,1,fin
    imprimir err1
    jmp menu

    XY:
        INIXY
        pause
        jmp fin
    XZ:
        INIXZ
        pause
        jmp fin    
    YZ:
        INIYZ
        pause    
        jmp fin    
    fin:
endm


INISCREEN macro ;Macro que configura la pantalla
    ;Seteando configuracion de video
    ;Estableciendo resolucion 400,200
    mov     ah,0
    mov     al, 013h
    ;mov     al, 10h
    int     10h
    ; blinking disabled for compatibility with dos,
    ; emulator and windows prompt do not blink anyway.
    mov     ax, 1003h
    mov     bx, 0      ; disable blinking.
    int     10h   
endm 


Contador1 dw 0
Contador2 dw 0

T_ejex db 'X$'
T_ejey db 'Y$'
T_ejeZ db 'Z$'


INIXY macro
    local conti1
    local etq
    local fin
    INISCREEN
    ;Seteando valor inicial a Z
    mov ax,limiteZb
    mov bx,pesoZ
    mul bx
    mov varZ,ax
    conti1:    
    ;------------------
    ;Dibujando grafica
    ;------------------ 
    CalcEje limiteXa,limiteXb,pos_ejey,pesoX,DrawVL    
    CalcEje limiteYa,limiteYb,pos_ejex,PesoY,DrawHL    
    PirntEjes limiteXa,limiteXb,limiteYa,limiteYb,T_ejex,T_ejey    
    GraphLeft  Varx,Vary,09h
    GraphRight  Varx,Vary,09h
    PirntEjes limiteXa,limiteXb,limiteYa,limiteYb,T_ejex,T_ejey    
    CalcEje limiteXa,limiteXb,pos_ejey,pesoX,DrawVL
    CalcEje limiteYa,limiteYb,pos_ejex,PesoY,DrawHL    
    fin:
endm

PirntEjes macro limXA,limXB,limYA,limYB,txtEjeA,txtEjeB
    mov ax,pos_ejey
    mov numero2,ax
    sub numero2,13d
    PrintVGA numero2,0,txtEjeB
    mov ax,196d
    sub ax,pos_ejex
    mov numero1,ax
    sub numero1,8 
    PrintVGA 0,numero1,txtEjeA

    HexToDec16 limXA,prb    
    add numero1,13d
    PrintVGA 0,numero1,prb
    HexToDec16 limXB,prb
    PrintVGA 295d,numero1,prb

    add numero2,20d
    HexToDec16 limYB,prb
    PrintVGA numero2,0,prb
    HexToDec16 limYA,prb
    PrintVGA numero2,185,prb
endm 


posx16 dw 0
posy16 dw 0
PrintVGA macro PosX,PosY,msg
    ;Recibe una posicion en pixeles y la pasa en un rango de letras
    local etq
    local etq2
    local conti1
    ;convirtinedo pixeles a espacios para chars
    mov dx,0
    mov ax,PosX
    mov bx,8d
    div bx
    mov posx16,ax

    mov dx,0
    mov ax,posY
    mov bx,8d
    div bx
    mov posy16,ax  

    mov cx,posx16
    mov dl,cl;posx
    mov cx,posy16
    mov dh,cl;posy
    mov ah,02h
    mov bh,0
    int 10h
    imprimir msg
endm



INIXZ macro
    local conti1
    local fin
    INISCREEN
    ;Seteando valor inicial a Y
    mov ax,limiteYb
    mov bx,PesoY
    mul bx
    mov Vary,ax
    mov Vary,0
    conti1:    
    ;------------------
    ;Dibujando grafica
    ;------------------   
    CalcEje limiteXa,limiteXb,pos_ejey,pesoX,DrawVL
    CalcEje limiteZa,limiteZb,pos_ejex,pesoZ,DrawHL    
    PirntEjes limiteXa,limiteXb,limiteZa,limiteZb,T_ejex,T_ejeZ
    GraphLeft  Varx,varZ,0Ah
    GraphRight Varx,varZ,0Ah
    PirntEjes limiteXa,limiteXb,limiteZa,limiteZb,T_ejex,T_ejeZ
    CalcEje limiteXa,limiteXb,pos_ejey,pesoX,DrawVL
    CalcEje limiteZa,limiteZb,pos_ejex,pesoZ,DrawHL
    
    fin:
endm

INIYZ macro
    local conti1
    local fin
    INISCREEN
    ;Seteando valor inicial a X
    mov Varx,0
    ;--------------------------------------------
    ;Recalculando pesoY
    ;--------------------------------------------
    mov ax,limiteYb
    sub ax,limiteYa    
    cmp ax,0
    je fin    
    mov bx,ax
    mov ax,318d
    mov dx,0
    div bx
    mov Pesoy,ax
    ;------------------
    ;Dibujando grafica
    ;------------------    
    CalcEje limiteYa,limiteYb,pos_ejey,pesoY,DrawVL
    CalcEje limiteZa,limiteZb,pos_ejex,pesoZ,DrawHL
    PirntEjes limiteYa,limiteYb,limiteZa,limiteZb,T_ejey,T_ejeZ
    GraphLeft  Vary,varZ,0Bh
    GraphRight Vary,varZ,0Bh
    PirntEjes limiteYa,limiteYb,limiteZa,limiteZb,T_ejey,T_ejeZ
    CalcEje limiteYa,limiteYb,pos_ejey,pesoY,DrawVL
    CalcEje limiteZa,limiteZb,pos_ejex,pesoZ,DrawHL
    fin:
endm

GraphLeft macro VarA_X,VarB_Y,color
    local Repetir1
    local Repetir2
    local conti2
    local conti3
    mov Contador2,0d
    Repetir2:
    mov ax,196d
    sub ax,pos_ejex
    sub ax,Contador2
    mov VarB_Y,ax    
        mov ax,pos_ejey
        mov Contador1,ax
        Repetir1:
        mov ax,Contador1
        sub ax,pos_ejey
        mov VarA_X,ax
            mov Respuesta,0
            ExecEc  
            cmp Respuesta,32767
            ja conti2
                DrawPixel Contador1,Contador2,color
                jmp conti3
            conti2:
            mov Contador1,1
        conti3:
        dec Contador1
        cmp Contador1,0
        ja Repetir1
    inc Contador2
    cmp Contador2,196d
    jb Repetir2
endm
GraphRight macro VarA_X,VarB_Y,color
    local Repetir1
    local Repetir2
    local conti2
    local conti3
    mov Contador2,0d
    Repetir2:
    mov ax,196d
    sub ax,pos_ejex
    sub ax,Contador2    
    mov VarB_Y,ax    
        mov ax,pos_ejey
        mov Contador1,ax
        Repetir1:
        mov ax,Contador1
        sub ax,pos_ejey
        mov VarA_X,ax
            mov Respuesta,0
            ExecEc  
            cmp Respuesta,32767
            ja conti2
                DrawPixel Contador1,Contador2,color
                jmp conti3
            conti2:
            mov Contador1,317
        conti3:
        inc Contador1
        cmp Contador1,318d
        jb Repetir1
    inc Contador2
    cmp Contador2,196d
    jb Repetir2
endm

CalcEje macro limA,limB,pos_eje,peso_eje,MCR;enviar el limites opuestos a los del eje
    ;macro que alcula la posicion del eje
    local no_drawLv
    cmp limA,32767;comprobando si es negativo    
    jb no_drawLv        
    cmp limB,32767;comprobando si es positivo
    ja no_drawLv
        mov ax,0
        sub ax,limA
        mov bx,peso_eje
        mul bx
        ;dec al
        mov pos_eje,aX  
    MCR pos_eje
    no_drawLv:
endm

DrawPixel macro Px,Py,color
    push ax
    push cx
    push dx   
    mov cx, Px  ; column
    mov dx, Py     ; row
    mov al, color     ; color
    mov ah, 0ch    ; put pixel
    int 10h
    pop dx
    pop cx
    pop ax 
endm

w equ 317;limites 0-317
h equ 196;limites 0-196
DrawHL macro ROW16
    local u1
    mov cx,1+w  ; column
    mov dx,196d
    sub dx,ROW16     ; row
    mov al, 15     ; white
u1: mov ah, 0ch    ; put pixel
    int 10h    
    dec cx
    cmp cx, 1
    jae u1    
endm  
DrawVL macro COL16
    local u3
    mov cx, COL16    ; column
    mov dx, 1+h   ; row
    mov al, 15     ; white
u3: mov ah, 0ch    ; put pixel
    int 10h    
    dec dx
    cmp dx, 1
    ja u3 
endm