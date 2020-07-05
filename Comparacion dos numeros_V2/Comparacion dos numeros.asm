.model small

.stack

.data 
    msg1 db "el menor es bx",10,13,"$" 
    msg2 db "el menor es dx",10,13,"$"

.code

    .startup
    MOV     dx, 1
    MOV     bx, 3
                 
    MOV     ax, dx
    SUB     dx, bx   
    
    JS      menores_a
    
    MOV     ah, 09h
    MOV     dx, offset msg1 
    INT     21h 
    JMP     salir
    
    menores_a:  
    
        MOV     ah, 09h
        MOV     dx, offset msg2
        INT     21h
    
        JMP salir
   
    salir:
        MOV     ax, 0c07h
        INT     21h
    .exit
    
end