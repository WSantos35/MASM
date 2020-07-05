;Programa que imprime 10 veces una cadena como un ciclo for
.model small

.stack

.data
   cont db 0
   msg  db 10,13,"!Hola mundo","$"
.code
    .startup  
    
    ciclo:
        CMP     cont,10
        JE      salir
        MOV     ah, 09h
        MOV     dx, offset msg
        INT     21h
        INC     cont
        JMP     ciclo
            
    
    salir:
        MOV     ax, 0c07h
        INT     21h 
    .exit
    
end