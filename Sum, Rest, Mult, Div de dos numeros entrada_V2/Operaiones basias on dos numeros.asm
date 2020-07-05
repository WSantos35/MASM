
.model small

.stack

.data
    num1    db 0
    num2    db 0
    Resultado db 0
    mensaje0    db 10,13,"Suma es: ","$"
    mensaje1    db 10,13,"Resta es: ","$"
    mensaje2    db 10,13,"Multiplicacion es: ","$"
    mensaje3    db 10,13,"Division es: ","$"
    mensaje4    db 10,13,"Ingrese un numero: ","$" 

.code
    .startup  
    
    MOV     ah, 09h
    MOV     dx, offset mensaje4
    INT     21h
    
    MOV     ah, 01h
    INT     21h
    SUB     al, 30h
    MOV     num1, al
    
    MOV     ah, 09h
    MOV     dx, offset mensaje4
    INT     21h
    
    MOV     ah, 01h
    INT     21h
    SUB     al, 30h
    MOV     num2, al 
    
        ;SUMA
    MOV     al, num1
    ADD     al, num2
    MOV     Resultado, al
    
    MOV     ah, 09h
    MOV     dx, offset mensaje0
    INT     21h
    
    MOV     al, Resultado           ;en al se mueve el resultado que se encuentra en hexademal
    AAM                             ;desempaqueta lo que se encuentra en ax que es el resultado a demal
    MOV     bx, ax                  ;guarda en bx lo que esta en ax ya que se utilizara el registro ax para int21h
    MOV     ah, 02h                 ;salida de caracteres
    MOV     dl, bh                  ;pasa el numero mayor a dl, ya que lo que esta en dl es lo que va a salir
    ADD     dl, 30h                 ;le suma 30 ya que debe estar en ascii
    INT     21h                     ;llamda la int21h para ejecutar la funcion 02h para el primer digito
    
    MOV     ah, 02h                 ;realiza lo mismo con el segundo digito del resultado
    MOV     dl, bl                  ;el segundo digito se encuentra en el registro bl
    ADD     dl, 30h
    INT     21h   
    
    ;RESTA 
    
    MOV     al, num1
    SUB     al, num2
    MOV     Resultado, al
    
    MOV     ah, 09h
    MOV     dx, offset mensaje1
    INT     21h
    
    MOV     al, Resultado          
    AAM                            
    MOV     bx, ax                 
    MOV     ah, 02h                
    MOV     dl, bh                  
    ADD     dl, 30h                 
    INT     21h                     
    
    MOV     ah, 02h                 
    MOV     dl, bl                  
    ADD     dl, 30h
    INT     21h 
               
    ;MULT 
    
    MOV     al, num1  
    MOV     bl, num2
    MUL     bl
    MOV     Resultado, al
    
    MOV     ah, 09h
    MOV     dx, offset mensaje2
    INT     21h
    
    MOV     al, Resultado          
    AAM                            
    MOV     bx, ax                 
    MOV     ah, 02h                
    MOV     dl, bh                  
    ADD     dl, 30h                 
    INT     21h                     
    
    MOV     ah, 02h                 
    MOV     dl, bl                  
    ADD     dl, 30h
    INT     21h           
                
    ;DIV
    XOR     ax, ax                          ;limpiamos el registro ax 
    
    MOV     al, num1  
    MOV     bl, num2
    DIV     bl
    MOV     Resultado, al
    
    MOV     ah, 09h
    MOV     dx, offset mensaje2
    INT     21h
    
    MOV     al, Resultado          
    AAM                            
    MOV     bx, ax                 
    MOV     ah, 02h                
    MOV     dl, bh                  
    ADD     dl, 30h                 
    INT     21h                     
    
    MOV     ah, 02h                 
    MOV     dl, bl                  
    ADD     dl, 30h
    INT     21h 
    
    salir:
        MOV     ax, 0c07h
        INT     21h 
    .exit
    
end