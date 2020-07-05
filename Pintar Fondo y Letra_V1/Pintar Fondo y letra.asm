

.model tiny

.data
  
.code
    
    imprimir MACRO escribir,x,y
        MOV     dh, x
        MOV     dl, y          
        MOV     bh, 00d        
        MOV     ah, 02h
        INT     10h
        
        MOV     ah,9                                    
        LEA     dx,escribir
        INT     21h
    ENDM
    

    .startup
    
    
;    MOV     ax, 0600h  
;    MOV     bh, 50h             ;color fondo y letra
;    MOV     ch, 0               ;punto inicial hacia abajo
;    MOV     cl, 0               ;punto inicial hacia la derecha
;    MOV     dh, 5              ;punto final hacia abajo
;    MOV     dl, 79              ;punto final hacia la derecha  
;    INT     10h  
                                                                
                                                                
    ;Dibujando una Bandera
    
   
    ;1 franja (azul)
    MOV     ax, 0600h
    MOV     bh, 97h
    MOV     cx, 0000h
    MOV     dx, 034fh
    INT     10h  
    
        ;2 franja (blanca)
    MOV     ax, 0600h
    MOV     bh, 70h
    MOV     cx, 0400h
    MOV     dx, 074fh
    INT     10h
    
                
        ;3 franja (roja)
    MOV     ax, 0600h
    MOV     bh, 47h
    MOV     cx, 0800h
    MOV     dx, 0B4fh
    INT     10h
    
        ;4 franja (azul)
    MOV     ax, 0600h
    MOV     bh, 47h
    MOV     cx, 0c00h
    MOV     dx, 104fh
    INT     10h
              
               
        ;5 franja (azul)
    MOV     ax, 0600h
    MOV     bh, 70h
    MOV     cx, 1100h
    MOV     dx, 144fh
    INT     10h
    
        ;6 franja (azul)
    MOV     ax, 0600h
    MOV     bh, 97h
    MOV     cx, 1500h
    MOV     dx, 184fh
    INT     10h     
    
        
    MOV     ax, 0600h  
    MOV     bh, 50h            
    MOV     ch, 0              
    MOV     cl, 0              
    MOV     dh, 25             
    MOV     dl, 20             
    INT     10h  
                  
    
               
    MOV     ax,0c07h
    INT     21h   
    .exit
end