;=================MACRO QUE IMPRIME CADENA EN CONSOLA============
imprimir MACRO texto   
    XOR     DX,DX
    MOV     DX, OFFSET texto    
    MOV     AH, 09h
    INT     21h
ENDM 
;================ MACRO QUE VALIDA OPCIONES DEL MENU =============
ingresaNumero MACRO 
 XOR        AX,AX
 MOV        AH,01h
 INT        21h
 SUB        AL,30h
 MOV        unidades, AL
 
 MOV        AL,unidades
 CMP        AL,num6
 JC         decenasCero
 JNZ        numeroIncorrecto
ENDM 