;Programa que resta dos numeros para un solo digito, cuando existen datos negativos
;el programa guarda el resultado en los registros como complemento a 2
.model tiny

.data
  

    
.code
    


    .startup
    
    ;se asigna valores a los registro al y bl
    MOV     al, 4
    MOV     bl, 1
    ;se realiza la resta al=al-bl
    SUB     al, bl  
    
    ;se mueve el resultado de al al registro dl, se le suma 48 y se muestra en pantalla
    MOV     dl, al
    ADD     dl, 48
    MOV     ah, 02h
    INT     21h

 
 
    MOV     ax,0c07h
    INT     21h   
    .exit
end