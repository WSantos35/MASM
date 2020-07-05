.model small
;Programa que lee una cadena escrita desde el teclado y lo imprime en pantalla
.stack

.data

    msg db 10,13,"Ingrese Cadena: ",10,13,"$"
    cadena db 100 dup("$")   ;SE CREA UNA CADENA DE 100 VALORES DE ESPACIO VACIO
    msg1 db 10,13,"la cadena escrita es: $"
    

.code 

;===================MACRO PARA IMPRIMIR TEXTO
imprimir MACRO texto
    MOV     dx, offset texto
    MOV     ah, 09h
    INT     21h
ENDM 

;==================MACRO QUE CAPTURA TEXTO DEL TECLADO LEYENDO CARACTER POR CARACTER
capturarCadena MACRO 
    capturar:
        INT     21h
        CMP     al, 13
        JZ      resultado
        MOV     cadena[si], al
        INC     si 
        JMP     capturar
ENDM

    .startup
    
    imprimir msg

    MOV     ah, 1           ;SE UTILIZA LA FUNCION 1 DE LA INT 21H
    XOR     si, si          ;YA QUE ES UNA FUNCION XOR, LO QUE HACE ES LIMPIAR EL REGISTRO

    capturarCadena
        
    resultado:       
        imprimir msg1
        imprimir cadena

    
    MOV     ax, 0c07h
    INT     21h
    
    .exit
    
end