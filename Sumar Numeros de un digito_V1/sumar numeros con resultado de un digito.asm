;Programa donde se suma dos numeros de un digito y obtener tambien el resultado de un digito para 
;luego mostrarlo en pantalla
.model tiny

.data
  
    
    
.code
    


    .startup
        
        ;haciendo la sumatoria
        MOV     al, 1
        MOV     bl, 5
        ADD     al, bl       
        
        
        ;mostrando en pantalla (se puede hacer con una macro)  
        MOV     dl, al              ;//no se puede usar 'MOD    dl,al+48' da error
        ADD     dl, 48              ;//lo mejor que se puede hacer es usar ADD para sumarle 48
                                    ;//e imprimir en pantalla
        MOV     ah,02h  
        INT     21h
        
        

        MOV     ax, 0c07h
        INT     21h
    .exit
end