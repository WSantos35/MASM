
dir_cont dw 0
copia_num dw 0
HexToDec16 macro numHex,cont  
        ;dx:ax numerador
        ;bx denominador
        ;ax respuesta
        ;dx residuo
        local Et1
        local Et3
        local no_negativo
        push ax
        push bx
        push cx
        push dx
        push si

        mov dir_cont,offset cont
        mov ax,numHex
        mov copia_num,ax
        ;comprobando si es negativo
        cmp copia_num,32767
        jb no_negativo
        mov si,dir_cont
        mov byte ptr[si],'-'
        mov ax,0
        sub ax,copia_num
        mov copia_num,ax
        inc dir_cont

        no_negativo:
        mov dx,0
        mov ax,0
        mov bx,0        
        mov ax,copia_num                
        MOV Bx,0Ah ;seteando 10        
        mov si,0;              
        
        Et1: 
        DIV Bx                          
        ADD dx,30h ;pasando residuo a ascii   
        push dx   
        mov dx,0
        inc si    
        CMP ax,00h
        JA   Et1 
                 
        xor ax,ax
        mov cx,si        
        mov si,dir_cont
        Et3:
        ;---write to content------
        pop ax
        mov byte ptr[si],al
        ;------------------------        
        inc si
        dec cx
        cmp cx,0
        ja Et3
        mov byte ptr[si],'$'
        ;imprimir cont
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
    endm
    

    SPUNTO DB '.$',0
    SCERO DB '0$',0
    ;PASA UN NUMERO DE HEXADECIMAL A PUNTO DECIMAL CON DOS CIFRAS SIGNIFICATIVAS
HexToFRAC16 macro numHex,cont  
        ;dx:ax numerador
        ;bx denominador
        ;ax respuesta
        ;dx residuo
        local Et1
        local Et3
        local noprintcero
        push ax
        push bx
        push cx
        push dx
        imprimir SPUNTO        
        cmp numHex,100
        JA noprintcero;si es mayor a 100 no se imprime el cero
        imprimir SCERO

        noprintcero:
        ;dividiendo entre 10 para que queden dos digitos
        mov dx,0
        mov ax,numHex
        mov bx,10d
        div bx
        mov numHex,ax


        mov dx,0
        mov ax,0
        mov bx,0        
        mov ax,numHex                
        MOV Bx,0Ah ;seteando 10        
        mov si,0;              
        
        Et1: 
        DIV Bx                          
        ADD dx,30h ;pasando residuo a ascii   
        push dx   
        mov dx,0
        inc si    
        CMP  ax,00h
        JA   Et1 
                 
        xor ax,ax
        mov cx,si        
        mov si,offset cont        
        Et3:
        ;---write to content------
        pop ax
        mov byte ptr[si],al
        ;------------------------        
        inc si
        dec cx
        cmp cx,0
        ja Et3
        mov byte ptr[si],'$'
        imprimir cont
        pop dx
        pop cx
        pop bx
        pop ax
    endm
 
HexToDec8 macro numHex,cont                
        local Et1
        local Et3
        mov ah,0
        mov al,numHex        
        mov si,0
        Et1:         
        MOV BH,0Ah ;setenado 10
        DIV BH                  
        ADD AH,30h ;pasando residuo a ascii   
        xor cx,cx
        mov cl,ah
        push cx
        mov AH,0
        inc si    
        CMP  AL,00h
        JA   Et1 
                 
        xor ax,ax
        mov cx,si        
        mov si,offset cont
        Et3:
        ;---write to content------
        pop ax
        mov byte ptr[si],al
        ;------------------------        
        inc si
        dec cx
        cmp cx,0
        ja Et3        
        mov byte ptr[si],0
        mov byte ptr[si+1],'$'
        ;imprimir salto
        ;imprimir cont
    endm    


HexToSTr16 macro numHex,cont
        ;dx:ax numerador
        ;bx denominador
        ;ax respuesta
        ;dx residuo
        local Et1
        local Et3
        local conti
        push ax
        push bx
        push cx
        push dx
        push si
        
        mov dx,0
        mov ax,0
        mov bx,0        
        mov ax,numHex                
        MOV Bx,10h ;seteando 16 
        mov si,0;              
        
        Et1: 
        DIV Bx                          
        cmp dx,9d;si es mayor a 9 se le suma 11d para convertirlo aletra
        jbe conti
        add dx,11h

        conti:
        ADD dx,30h ;pasando residuo a ascii   
        push dx   
        mov dx,0
        inc si    
        CMP  ax,00h
        JA   Et1 
                 
        xor ax,ax
        mov cx,si        
        mov si,offset cont
        Et3:
        ;---write to content------
        pop ax
        mov byte ptr[si],al
        ;------------------------        
        inc si
        dec cx
        cmp cx,0
        ja Et3
        mov byte ptr[si],'$'
        ;imprimir cont
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
endm 



HexToSTr8 macro numHex,cont
        local Et1
        local Et3
        local conti
        push ax
        push bx
        push cx
        push si
        
        mov ah,0
        mov al,numHex        
        mov si,0
        Et1:         
        MOV BH,10h ;setenado 16
        DIV BH
        cmp ah,9h
        jbe conti
        add ah,7d
        conti:
        ADD AH,30h ;pasando residuo a ascii   
        xor cx,cx
        mov cl,ah
        push cx
        mov AH,0
        inc si    
        CMP  AL,00h
        JA   Et1 
                 
        xor ax,ax
        mov cx,si        
        mov si,offset cont
        Et3:
        ;---write to content------
        pop ax
        mov byte ptr[si],al
        ;------------------------        
        inc si
        dec cx
        cmp cx,0
        ja Et3        
        mov byte ptr[si],0
        mov byte ptr[si+1],'$'
        ;imprimir salto
        ;imprimir cont
        pop si
        pop cx
        pop bx
        pop ax
endm 




