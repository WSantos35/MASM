;programa que divide dos numeros de un digito y muestra solo el resultado entero de la division
.model tiny

.data
  
    
    
.code
    

    .startup
             
    ;se asigna valores a los registros al y bl         
    MOV     al, 11
    MOV     bl, 3
                   
    ;se realiza la division al=al/bl
    DIV     bl  
    
    ;se mueve el resultado de al al registro dl, se le suma 48 y se imprime en pantalla
    MOV     dl, al
    
    ADD     dl, 48
    MOV     ah, 02h
    INT     21h          
 
    MOV     ax,0c07h
    INT     21h   
    .exit
end