;Programa que obtiene el Maximo comun divisor de dos numeros  
;usando el algoritmo de Euclides
.model small

.stack

.data

.code

    MOV     ax, 20          ;ax va a ser el numero mayor
    MOV     bx, 12          ;bx va a ser el menor 
    
    ;determinando el mayor de los numeros
    CMP     ax, bx
    JS      intercambiar
    JMP     calcular_MCD
    
    intercambiar:
        XCHG    ax, bx      ;intercambiando los registros
        
        
    calcular_MCD:
        PUSH    bx 
        XOR     dx, dx      ;limpiando el registro
        DIV     bx          ;dividir ax entre bx
        CMP     dx, 0       ;comparando si el residuo es cero
        JZ      resultado
        ;MOV     ax, bx      ;el numero menor ahora va a ser el mayor
        MOV     bx, dx      ;el residuo ahora sera el menor
        POP     ax
        JMP     calcular_MCD;Vuelve a repetir el proceso
        
    resultado:
        POP     dx          ;saca de la pila el ultimo numero menor el cual es el resultado
        
    
    salir:
        MOV     ax, 0c07h
        INT     21h
    
    .exit
    
end