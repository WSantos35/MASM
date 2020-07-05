;Programa que lee un digito
.model small

.stack

.data 
                                            
    msg db 10,13,"Ingrese un numero entre 0-9: ","$"
    cadena  db 10,13,"Numero ingresado: ","$"    
    num db ?

.code


    .startup
    
        MOV     dx, offset msg
        MOV     ah, 09h
        INT     21h
        
        ;LECTURA E IMPRESION DEL DIGITO
        MOV     ah, 01h
        INT     21h
        
        sub     al,30h
        MOV     num, al
        ;FIN LECTURA E IMPRESION DEL DIGITO
        
        MOV     ah, 09h
        MOV     dx, offset cadena
        INT     21h
                                    
                                    
        MOV     ah, 02h
        MOV     dl, num
       ; ADD     dl, 30h
        INT     21H
     
     
        MOV     ax, 0c07h
        INT     21h
     
    .exit
    
 end