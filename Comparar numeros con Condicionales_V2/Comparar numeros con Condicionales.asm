;Programa que compara dos numeros para verificar cual es mayor, menor o igual y muestra un mensaje en pantalla
.model small

.data

    num1 db 5
    num2 db 8 
    msg1 db "Numeros iguales","$"
    msg2 db "Numero 1 mayor","$"
    msg3 db "Numero 2 mayor","$"

.code

    .startup
 
    MOV     al,num1
    
    CMP     al,num2 
    
    JC      menor 
    JZ      igual 
    JNZ     mayor       ;AL IGUAL QUE JA SOLO SE EJECUTA SI AL>NUM2
    JMP     salir
    
    igual:  
        MOV     ah, 09h
        MOV     dx, offset msg1 
        INT     21h
        JMP     salir  
        
    mayor:  
        MOV     ah, 09h
        MOV     dx, offset msg2 
        INT     21h
        JMP     salir
        
    menor:  
        MOV     ah, 09h
        MOV     dx, offset msg3 
        INT     21h
        
                
    salir:    
        MOV     ax, 0c07h
        INT     21h
    .exit
    
    
end