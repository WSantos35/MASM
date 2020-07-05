.model tiny

.data

    h       db "hola mundo",13,10,"otra linea",13,10,"$"   
    g       db "hola mundo!!",13,10,"otra linea jajaja",13,10,"$"  
    
.code


    p macro string                          ;solo se le indica un parametro
        mov     dx,offset string
        mov     ah,9
        int     21h
        
    endm

    .startup

        p       h                           ;se dice que en assembler esta es una mala practica
        p       g
        
        mov     ax,0c07h
        int     21h           
        
    .exit
end