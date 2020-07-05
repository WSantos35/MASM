
    ;-------------------VARIABLES USADAS POR EL MENU-----------------------------------------------------------------------
    msgerlex db '%%%%%%%%% ERROR LÉXICO %%%%%%%%%',13,10,'$',0
    msgerlex1 db 'Caracter no esperado:      $',0
    msgersin db '%%%%%%%%% ERROR SINTÁCTICO %%%%%%%%%',13,10,'$',0
    msgersin1 db 'Encontrado:   $',0
    msgersin2 db 'Esperado: $',0

    msger_seman db 'Error las etiquetas de cierre y apertura no coinciden',13,10,'$',0
    
    estado db 0,'$'
    Indexof dw 0,'$'    ;lleva el index del analizador lexico para que regrese el siguiente token
    token dw 0,'$'
    tipotoken db 0,'$'

    buff db 0,100 dup ('$'),0
    ptrbuff dw 0
    
    numtemp dw 0






;---------------------------------------------------------------------------------------------------------------------------------------
    ;verifica si es un símbolo
    isSimbol macro char,salida
        local EV
        local EF
        ;Si es menorque
        cmp char,'<'
        mov tipotoken,6d      
        je EV
        ;Si es mayorque        
        cmp char,'>'
        mov tipotoken,7d
        je EV    
        ;-----------------------------        
        ;Si es parentesis cerrado
        cmp char,')'
        mov tipotoken,8d
        je EV               
        ;Si es parentesis abierto
        cmp char,'('
        mov tipotoken,9d
        je EV    
        ;Si es resta             
        cmp char,'-'
        mov tipotoken,10d
        je EV            
        ;Si es suma
        cmp char,'+'
        mov tipotoken,11d
        je EV      
        ;Si es  por
        cmp char,'*'
        mov tipotoken,12d
        je EV

        ;Si es division 
        cmp char,'/'
        mov tipotoken,13d
        je EV            
        ;Si es modulo
        cmp char,'%'
        mov tipotoken,14d
        je EV              
        ;Si es potencia
        cmp char,'^'
        mov tipotoken,15d
        je EV    
        
        ;Si es signo igual
        cmp char,'='
        mov tipotoken,16d
        je EV             
        ; si no es un simbolo
        mov tipotoken,0d
        jmp EF
        EV:
        mov estado,0
        jmp salida
        EF:
endm


    ;verifica si bx es letra
    isleter macro char,est,salida
        local EF        
        local EV
        cmp char,'A'
        jb EF
        cmp char,'Z'
        jbe EV
        cmp char,'a'
        jb EF
        cmp char,'z'
        jbe EV

        jmp EF
        EV:
        mov estado,est
        jmp salida
        EF:

    endm
    ;verifica si char es un char en blanco
    isblank macro char,EV
        cmp char,32
        je EV        
        cmp char,31
        je EV               
        cmp char,10
        je EV              
        cmp char,09
        je EV   
        cmp char,13
        je EV                                       
    endm   

    ;verifica si char es un digito
    isDigit macro char,est,salida
        local EV
        local EF        
        cmp char,'0'
        jb EF
        cmp char,'9'        
        ja EF
        EV:
        mov estado,est
        jmp salida
        EF: 
    endm       
    
    ;------------------------------Macro que pausa el programa ------------------------------
    ;Macros para Copia de arhivo

NextToken macro
    local anlex
    local E0
    local E1
    local E11
    local E12
    
    local E2
    local E21
    local E22
    local E3
    local E31
    local fin
    local break    
    local error  
    anlex:        
        ;leyendo 1 caracter en el handler del archivo
        mov ah,3fh
        mov bx,handler
        mov dx,offset letra
        mov cx,1;leyendo de 1 en 1
        int 21h
        ;jc error
        cmp ax,0 ;si ax=0 significa EndOfFile    
        jz fin 
    ;copiando char a buffer
    mov ah,letra
    mov si,ptrbuff
    mov byte ptr[si],ah
    mov byte ptr[si+1],'$'         
    inc indexof

        cmp estado,0
            jz E0    
        cmp estado,1
            jz E1      
        cmp estado,2
            jz E2          
        cmp estado,3
            jz E3

        E0:
    ;copiando char a numtemp
    mov ah,0
    mov al,letra
    sub al,30h
    mov numtemp,ax        
            ;mov ptrbuff,offset buff         ;Reiniciando putnero hacia buffer
            ;mov estado,0
            inc ptrbuff            
            ;comporbando si es sibmolo
            isSimbol  letra,E3
            ;comporbando si es letra
            isleter letra,2,anlex          
            ;comprobando si es digito
            isDigit letra,1,anlex   
            ;comprobando si es un espacio en blanco            
            mov ptrbuff,offset buff
            isblank letra,anlex
            jmp error

        E1:        
            ;ACEPTACION
            ;Estado de numero entero
            isDigit letra,1,E11
            jmp E12
            E11:
            mov ax,numtemp
            mov bx,10d
            mul bx             
            mov bh,0
            mov bl,letra
            sub bl,30h
            add ax,bx
            mov numtemp,ax
            mov tipotoken,1
            jmp anlex

            E12:
            ;-----------------------------            
            ;ingresanod numeor a la pila
            Apilartipo t_numero
            ApilarNum numtemp
            ;----------------------
            mov ptrbuff,offset buff
            mov estado,0 
            ;mov numtemp,0
            
            ;imprimir buff 
            isblank letra,fin
            dec indexof
            mov ah,42h
            mov al,00h
            mov bx,handler
            mov cx,0
            mov dx,indexof
            int 21h
            jmp fin

        E2:
            inc ptrbuff
            ;Estado para letra                        
            isleter letra,2,anlex            
            isDigit letra,2,anlex
            dec ptrbuff
            mov si,ptrbuff
            mov byte ptr[si],'$'
            ;imprimir salto
            mov estado,0;REINICIANDO ESTADO            
            mov byte ptr[ptrbuff+1],'$'
            mov ptrbuff,offset buff            

            mov tipotoken,17d
            CompareString R_py2+1,buff,3,E22
            mov tipotoken,18d
            CompareString R_ecuacion+1,buff,8,E22
            mov tipotoken,19d
            CompareString R_ejex+1,buff,4,E22
            mov tipotoken,20d
            CompareString R_ejey+1,buff,4,E22
            mov tipotoken,21d
            CompareString R_ejez+1,buff,4,E22
            mov tipotoken,22d
            CompareString R_linf+1,buff,4,E22
            mov tipotoken,23d
            CompareString R_lsup+1,buff,4,E22            
            mov ah,t_x
            mov tipotoken,ah
            CompareString t_x+1,buff,2,E21            
            CompareString t_x+3,buff,2,E21
            mov ah,t_y
            mov tipotoken,ah
            CompareString t_y+1,buff,2,E21
            CompareString t_y+3,buff,2,E21
            mov ah,t_z
            mov tipotoken,ah
            CompareString t_z+1,buff,2,E21
            CompareString t_z+3,buff,2,E21            

            mov tipotoken,24d
            jmp E22

            ;en este caso debe ser una letra [x],[y] o [z]
            E21:
                Apilartipo tipotoken    
            E22:                    
            isblank letra,fin
            dec indexof
            mov ah,42h
            mov al,00h
            mov bx,handler
            mov cx,0
            mov dx,indexof
            int 21h
            jmp fin
            
        E3: 
            mov ptrbuff,offset buff
            mov estado,0
            ;ingresando operador a la pila
            mov ah,tipotoken
            ;descartando simbolos < y >
            cmp ah,s_menorque
            je fin
            cmp ah,s_mayorque
            je fin
            cmp ah,s_igual
            jne E31
            ;Apilartipo s_igual
            Apilartipo s_menos
            Apilartipo2 s_para            


            
            jmp fin                       
            E31:
            Apilartipo tipotoken    
            jmp fin
            ;----------------------------------------
    break: 
    jmp fin
    error:
        mov si,offset msgerlex1;direccion de msgerlex1        
        imprimir msgerlex           
        imprimir salto   
        imprimir msgerlex1                        
        imprimir salto
        imprimir buff
        imprimir salto
        mov estado,7d        
    fin:
endm

;Analizador sintáctico
esperado dw 0,50 dup ('$')




t_z db  2,'Z$z$'
t_y db  3,'Y$y$'
t_x db  4,'X$x$'
t_numero db  5,'Numero$'
s_menorque db 6,'<$'
s_mayorque db 7,'>$'


;Tipo,Precedencia,Cadena
s_elevado db 15d,'^$'

s_mod db 14d,'%$'
s_div db 13d,'/$'
s_por db 12d,'*$'

s_mas db 11d,'+$'
s_menos db 10d,'-$'

s_para db 9d,'($'
s_parc db 8d,')$'



s_igual db 16d,'=$'
R_py2 db 17d,'py2$'
R_ecuacion db 18d,'ecuacion$'
R_ejex db 19d,'ejex$'
R_ejey db 20d,'ejey$'
R_ejez db 21d,'ejez$'
R_linf db 22d,'linf$'
R_lsup db 23d,'lsup$'

limiteXa dw 0
limiteXb dw 0

limiteYa dw 0
limiteYb dw 0

limiteZa dw 0
limiteZb dw 0
;-------------------------------------------------------------------;-------------------------------------------------------------------
;-------------------------------------------------------------------;-------------------------------------------------------------------

INIPAREA macro regreso
    local ecuacion
    local L0    
    local linf
    local linf2
    local linf3
    resetPIla pila,2072d
    resetPIla pila2,2072d
    L0:    
        NextToken
        mov ah,R_ecuacion
        cmp tipotoken,ah
        jne L0    

    NextToken                
        ;guardando ecuacion
        ecuacion:
        NextToken
        mov ah,s_menorque
        cmp tipotoken,ah
        jne ecuacion
        Apilartipo s_parc
        ;Apilartipo '$'
        vaciarPila2
        Apilartipo '$'
        ;ver_pila;maxro que imprime la pila
        ;ExecEc;ejecuta las operaciones en la pila
        ;imprimir salto
        ;ExecEc;ejecuta las operaciones en la pila
        GTLINF limiteXa
        GTLSUP limiteXb

        GTLINF limiteYa
        GTLSUP limiteYb

        GTLINF limiteZa
        GTLSUP limiteZb        

        HexToDec16 limiteXa,prb
        imprimir prb
        imprimir tab
        HexToDec16 limiteXb,prb
        imprimir prb
        imprimir tab

        HexToDec16 limiteYa,prb
        imprimir prb
        imprimir tab
        HexToDec16 limiteYb,prb
        imprimir prb
        imprimir tab

        HexToDec16 limiteZa,prb
        imprimir prb
        imprimir tab
        HexToDec16 limiteZb,prb
        imprimir prb
        imprimir tab
        
        imprimir salto   
          
endm


GTLINF macro cont
    local linf
    local linf2
    local linf3
    local no_invertir
        linf:    
        NextToken                
        mov ah,R_linf
        cmp tipotoken,ah
        jne linf
        NextToken  
        NextToken  
        mov ah,0
        mov al,letra
        push ax
        linf2:    
        mov ax,numtemp
        mov cont,ax
        NextToken                        
        mov ah,s_menorque
        cmp tipotoken,ah
        jne linf2
        ;imprimir salto 
        linf3:      
        pop ax
        cmp al,'-'
        jne no_invertir
        mov ax,0
        sub ax,cont
        mov cont,ax
        
        no_invertir:

endm 
GTLSUP macro cont
    local linf
    local linf2
    local linf3
    local no_invertir
        linf:    
        NextToken                
        mov ah,R_lsup
        cmp tipotoken,ah
        jne linf
        NextToken  
        NextToken  
        mov ah,0
        mov al,letra
        push ax
        linf2:    
        mov ax,numtemp
        mov cont,ax
        NextToken                        
        mov ah,s_menorque
        cmp tipotoken,ah
        jne linf2
        ;imprimir salto 
        linf3:      
        pop ax
        cmp al,'-'
        jne no_invertir
        mov ax,0
        sub ax,cont
        mov cont,ax
        
        no_invertir:
     
endm 


ver_pila macro stk
    local print
    local fin
    local num16
    local conti
    push ax
    push si
    mov si,offset stk
    print:
        mov ah,byte ptr[si]
        cmp ah,'$'
        je fin
        mov prb2,ah
        cmp prb2,5d
        je num16
            HexToStr8 prb2,prb 
            imprimir prb
            imprimir salto
            jmp conti
        num16:
            HexToStr8 prb2,prb 
            imprimir prb
            imprimir salto
            inc si
            mov ax, word ptr[si]
            mov prb3,ax
            ;HexToStr16 prb3,prb
            ;imprimir prb
            ;imprimir salto
            inc si
        conti:        
        inc si
        jmp print
    fin:
    pop si
    pop ax
endm


prb db 20 dup ('$')
prb2 db 0
prb3 dw 0


    pila dw 2072 dup ('$$')
    endpila db 0 
    pila2 dw 2072 dup ('$$')
    endpila2 db 0

    ptrpila dw 0
    ptrpila2 dw 0
    tipo_temp db 0


Apilartipo macro tipo;inserta un elemento en la pila
    ;los tipo se apilaran segun su tipo
    local P1;para insertar tipo numero (8bit)+ 16 bit del numero apila1
    local P2;para insertar tipo a pila2
    local P3;para insertar tipo x,y o z a pila1
    local conti
    local despilar
    local findesapilar
    local D1
    local fin
    
    mov ah,tipo
    cmp ah,t_numero
    je P1
    cmp ah,s_parc
    je despilar   
    mov si,ptrpila2
    cmp ah,s_para
    je conti  
    cmp ah,t_x
    je P3  
    cmp ah,t_y
    je P3  
    cmp ah,t_z
    je P3               
    jmp P2
    P1:
    mov si,ptrpila
    mov ah,tipo
    mov byte ptr[si],ah
    inc si
    mov ptrpila,si
    jmp fin
    P2:
    mov si,ptrpila2
    cmp si,offset pila2
    je conti;saltando primer elemento cuando la pila esta vacia
    mov al,byte ptr[si-1]
    mov ah,tipo
    cmp ah,al  
    jae conti
        ;intercambiando parte superior de pilas
        dec si
        mov byte ptr[si],ah
        mov si,ptrpila
        mov byte ptr[si],al
        inc ptrpila

        jmp fin
    conti:
    mov byte ptr[si],ah
    inc si
    mov ptrpila2,si
    jmp fin
    P3:
    mov si,ptrpila
    mov ah,tipo
    mov byte ptr[si],ah
    inc si
    mov ptrpila,si    
    jmp fin
    despilar:
        mov si,ptrpila2
        mov bx,ptrpila
        D1:
        cmp si,offset pila2
        je findesapilar
        dec si
        mov ah,byte ptr[si]
        cmp ah,s_para
        je findesapilar
        mov byte ptr[bx],ah
        inc bx
        jmp D1
        findesapilar:
        mov ptrpila,bx
        mov ptrpila2,si
        
    fin:
endm

ApilarTipo2 macro tipo
    mov si,ptrpila2
    mov ah,tipo
    mov byte ptr[si],ah
    inc si
    mov ptrpila2,si    
endm

vaciarPila2 macro 
        mov si,ptrpila2
        mov bx,ptrpila
        D1:
        cmp si,offset pila2
        je findesapilar
        dec si
        mov ah,byte ptr[si]
        mov byte ptr[bx],ah
        inc bx
        jmp D1
        findesapilar:
        mov ptrpila,bx
        mov ptrpila2,si
endm


ApilarNum macro num16
    ;Los numero se apilaran sin reglas
    mov si,ptrpila
    mov ax,num16
    mov word ptr[si],ax
    add si,2
    mov ptrpila,si
endm 



respuesta dw 0;contendra la respuesta de la operaion
VarX dw 1
VarY dw 2
VarZ dw 3

Numero1 dw 0
Numero2 dw 0

ipNum0 dw 0
ipNum1 dw 0
ipNum2 dw 0
ipPivote  dw 0

p_respuesta db 'Respuesta$'

ExecEc macro
    local print
    local fin
    local num16
    local numx
    local numy    
    local numz    
    local conti
    local copy
    local IniOp
    local fin2
    local EF
    push ax
    push bx
    push cx
    push dx
    push si


    ;copiando Pila original a pila2
    mov si,offset pila
    mov bx,offset pila2    
    mov cx,2072d
    copy:
    mov ah,byte ptr[si]
    mov byte ptr[bx],ah
    inc si
    inc bx
    loop copy

    ;limpia
        ;ver_pila pila2
        ;pause    
    IniOp:
    mov si,offset pila2    
    mov ipNum0,si
    mov ipNum1,si
    mov ipNum2,si
    mov ipPivote,si
    mov ptrpila2,offset pila2
    print:
        mov ah,byte ptr[si]
        push ax
        push si
        mov prb2,ah
        ;HexTostr8 prb2,prb
        ;imprimir prb        
        pop si
        pop ax

        cmp ah,'$'
        je fin
        mov prb2,ah
        cmp prb2,5d
        je num16
        cmp prb2,4d;varx
        je numx
        cmp prb2,3d;vary
        je numy
        cmp prb2,2d;varz
        je numz
            ;En esta parte solo entran operadores
            ;------------------      
            mov T_op,ah
            Operar T_op,EF
            mov si,ipPivote            
            jmp conti
            ;------------------
            EF:            
            mov ax,ipNum1
            mov ipNum0,ax
            mov ax,ipNum2
            mov ipNum1,ax
            mov ipNum2,si            
            jmp conti
        num16:
            ;imprimir prb
            ;imprimir salto
            mov ax,ipNum1
            mov ipNum0,ax            
            mov ax,ipNum2
            mov ipNum1,ax            
            mov ipNum2,si
            inc si
            ;mov ax, word ptr[si]
            ;mov prb3,ax
            ;el numero esta en x
            inc si
            jmp conti
        numx:        
            ;HexToStr16 varx,prb
            ;el numeor esta en varx
            mov ax,ipNum1
            mov ipNum0,ax            
            mov ax,ipNum2
            mov ipNum1,ax            
            mov ipNum2,si
            jmp conti
        numy:
            ;HexToStr16 vary,prb
            ;el numeor esta en vary
            mov ax,ipNum1
            mov ipNum0,ax            
            mov ax,ipNum2
            mov ipNum1,ax            
            mov ipNum2,si
            jmp conti            
        numz:
            ;HexToStr16 varz,prb
            ;el numeor esta en varz
            mov ax,ipNum1
            mov ipNum0,ax            
            mov ax,ipNum2
            mov ipNum1,ax            
            mov ipNum2,si
            jmp conti
    conti:   
        inc si  
        mov ipPivote,si              
        jmp print
    fin:


        ;limpia
        ;ver_pila pila2
        ;pause

        mov si,offset pila2
        add si,3d        
        mov ah,byte ptr[si]
        cmp ah,36d
        je fin2
        inc si
        mov ah,byte ptr[si]
        cmp ah,36d
        je fin2
        jmp IniOp

        fin2:
        ;imprimir salto        
        ;HexToDec16 respuesta,prb
        ;imprimir prb       
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
endm


plop db 'Operando',13,10,'$'
T_op db 0
prb16 dw 0
A1 db 0,'$'

Operar macro tipoOP,EF
    local exec
    local fin

    local resta    
    local suma
    local multi
    local divid
    local poten
    local modulo    
    local conti
    local correr1
    local crr1
    local correr2
    local falso
    push si   
    push ax
    push bx
    push cx

    
    mov si,ipNum1
    mov ah,byte ptr[si]
    mov prb2,ah
    cmp ah,2d
    jb falso
    cmp ah,5d
    ja falso

    mov si,ipNum2
    mov ah,byte ptr[si]
    mov prb2,ah
    cmp ah,2d
    jb falso
    cmp ah,5d
    ja falso


    exec:
    
    leer_op ipNum1,Numero1
    leer_op ipNum2,Numero2
    mov ah,tipoOP
    cmp ah,s_mas
    je suma
    cmp ah,s_por
    je multi
    cmp ah,s_div
    je divid
    cmp ah,s_elevado
    je poten
    cmp ah,s_mod
    je modulo         

    resta:
        Restar numero1,Numero2,respuesta
        jmp conti    
    suma:
        Sumar numero1,Numero2,respuesta
        jmp conti
    multi:
        Multiplicar numero1,Numero2,respuesta
        jmp conti
    divid:
        jmp conti
    poten:
        Potencia numero1,Numero2,respuesta
        jmp conti
    modulo:
        jmp conti  
    conti:
            
            ;moviendo respuesta a ipnum1
            mov si,ipnum1
            mov byte ptr[si],5d
            inc si
            mov ax,respuesta
            mov word ptr[si],ax
            inc si
            inc si 
            


            mov bx,si
            inc ipPivote
            mov si,ipPivote

            mov cx,offset pila2
            add cx,100d
            sub cx,ptrpila2
            mov cx,100d
            correr1:               
                mov ah,byte ptr[si]
                mov byte ptr[bx],ah
                inc si                
                inc bx                
            loop correr1

            ;dec ipnum1;se decrementa por que en la siguiente iteracion se incrementara automatiamente
            mov ax,ipNum1
            dec ax
            mov ipPivote,ax            
            
            mov ax,offset A1
            mov ipNum2,ax
            mov ipNum1,ax
            mov ipnum0,ax
    jmp fin
    falso:
    pop cx
    pop bx    
    pop ax
    pop si
    jmp EF             
    fin:
    pop cx
    pop bx    
    pop ax
    pop si
endm

leer_op macro dirtipo,cont16
    local numero
    local lvarx
    local lvary
    local lvarz
    local fin

    mov si,dirtipo
    mov ah,byte ptr[si]
    cmp ah,5d
    je numero
    cmp ah,3d
    je lvary 
    cmp ah,2d
    je lvarz       
    lvarx:
        mov ax,VarX
        mov cont16,ax
        jmp fin
    lvary:
        mov ax,VarY
        mov cont16,ax    
        jmp fin 
    lvarz:
        mov ax,VarZ
        mov cont16,ax    
        jmp fin
    numero:
        inc si
        mov ax,word ptr[si]
        mov cont16,ax
    fin:
endm


Dividir macro Op1,Op2,cont
endm

Potencia macro Op1,Op2,cont
    local multi
    local fin
    push ax
    push bx
    push cx
    push dx
    mov ax,1
    cmp op2,0
    je fin    
    mov ax,Op1
    mov bx,Op1
    cmp op2,1
    je fin
    mov cx,Op2
    dec cx
    multi:
    mul bx
    loop multi
    fin:
    mov cont,ax
    pop dx
    pop cx 
    pop bx
    pop ax   
endm

Restar macro Op1,Op2,cont
    push ax
    mov ax,Op1
    sub ax,op2
    mov cont,ax
    pop ax   
endm


Sumar macro Op1,Op2,cont
    push ax
    mov ax,Op1
    add ax,op2
    mov cont,ax
    pop ax   
endm

Multiplicar macro Op1,Op2,cont
    push ax
    push bx
    push cx
    push dx
        mov ax,Op1
        mov bx,op2
        mul bx
        mov cont,ax
    pop dx
    pop cx
    pop bx
    pop ax
endm


resetPIla macro pila,tam
    local repetir
    push si
    push cx
    mov si,offset pila
    mov cx,tam
    repetir:
        mov byte ptr[si],'$'
        inc si
    loop repetir
    pop cx
    pop si
endm

