;ENSAMBLADOR UTILIZADO: MASM611
;DEL CUAL SE EXTRAJO LA INFORMACION DE INSTALACION Y USO EN: https://www.youtube.com/watch?v=pIRd79UsHXA

.model large

.stack

.data
    msg1 db "UNIVERSIDAD DE SAN CARLOS DE GUATEMALA",10,13,"$" 
    msg2 db "FACULTAD DE INGENIERIA",10,13,"$"
    msg3 db "CIENCIAS Y SISTEMAS",10,13,"$"
    msg4 db "ARQUITECTURA DE COMPUTADORAS Y ENSAMBLADORES 1",10,13,"$"
    msg5 db "SECCION A",10,13,"$"
    msg6 db "NOMBRE: WILLIAM ALEXANDER SANTOS COLINDRES",10,13,"$"
    msg7 db "CARNET: 201700662",10,13,10,13,"$"
    msg8 db "PRACTICA 4",10,13,10,13,"$"
    msg9 db 10,13,"MENU",10,13,"$"
    msg10 db "1)Cargar Ecuacion",10,13,"2)Grafica 2D",10,13,"3)Grafica 3D",10,13,"4)Activar Control Movil",10,13,"5)Salir",10,13,10,13,"$"
    msg11 db "ESCOGA UNA OPCION: ",10,13,"$"
    msg12 db "1)Top 10 Puntos",10,13,"2) Top 10 Tiempo",10,13,"3) Salir y Regresar al Menu",10,13,10,13,"$"
    
    ;MENSAJES VARIOS---------------------------------------------------------------------
    msgSalir db "==FIN DEL PROGRAMA, PRESIONE CUALQUIER TECLA PARA SALIR DEL PROGRAMA==",10,13,"$"
    
    ;-------------------VARIABLES ESTATICAS-------------------------------------------------  
    saltoLinea db 10,13,"$"              
    textoArchivo db 2 dup("$") 
    vtext db 100 dup("$")
                      
    ;-----------------VARIABLES ESTATICAS BANDERAS -----------------------------------------
    Array_iguales db 0,"$"     
    
    ;-------------------VARIABLES ARCHIVOS ------------------------------------------------- 
    
    ;------------------------MENSAJES DE ERROR -----------------------------------------------------------
    errorNumero db 10,13,"=== LA OPCION SELECCIONADA NO ES CORRECTA ===",10,13,"$" 
    errorCA db 10,13,"=== NO SE PUDO CREAR EL ARCHIVO ===",10,13,"$"
    errorAA db 10,13,"=== NO SE PUDO ABRIR EL ARCHIVO ===",10,13,"$"
    errorEA db 10,13,"=== NO SE PUDO ESCRIBIR EN EL ARCHIVO ===",10,13,"$" 
    errorLA db 10,13,"=== NO SE PUDO LEER EL ARCHIVO===",10,13,"$" 
    errorPuntero db 10,13,"=== NO SE PUDO POSICIONAR EL PUNTERO===",10,13,"$"
    errorUsuarioIncorrecto db 10,13,"=== EL USUARIO NO ESTA REGISTRADO ===",10,13,"$"
    ;--LOS NUMEROS PARA REALIZAR LAS COMPARACIONES---------------------------------------------------------
    num0 db 0
    num1 db 1
    num2 db 2
    num3 db 3
    num4 db 4
    num5 db 5
    num6 db 6
    num7 db 7
    num8 db 8
    num9 db 9 
    unidades db 0
    decenas db 0 
    
    ;texto varios----------------------------------------------------------------------------------------
    text1 db "opcion 1",10,13,"$"
    text2 db "opcion 2",10,13,"$"
    text3 db "opcion 3",10,13,"$"
    text4 db "opcion 4",10,13,"$"
    text5 db "opcion 5",10,13,"$"
    text6 db "opcion 6",10,13,"$"
    text7 db "opcion 7",10,13,"$"
    text8 db "opcion 8",10,13,"$"
    text9 db "opcion 9",10,13,"$"
    text10 db "opcion 10",10,13,"$"
    text11 db "opcion 11",10,13,"$" 
    

.code   

     INCLUDE MB.asm

    .startup
     
     ;IMPRIMIENDO EL ENCABEZADO HASTA LLEGAR AL MENU
     imprimir msg1
     imprimir msg2
     imprimir msg3 
     imprimir msg4
     imprimir msg5
     imprimir msg6
     imprimir msg7
     imprimir msg8   
     
     ;ETIQUETA QUE IMPRIMIRA EL MENU, SALTAMOS AQUI CUANDO SE QUIERA PRESENTAR DE 
     ;NUEVO ESTA OPCION
     imprimirMenu:    
           imprimir msg9
           imprimir msg10   
           imprimir msg11 
           ingresaNumero 
     ;ESTAS ETIQUETAS ME VERIFICAN EL NUMERO INGRESADO PARA VALIDACION DE LA OPCION ESCOGIDA
     decenasCero:
        MOV     AL, unidades
        ;COMPARACION DE LA OPCION 0
        CMP     AL, num0
        JZ      numeroIncorrecto
        ;COMPARACION DE LA OPCION 1
        CMP     AL, num1
        JZ      opcion1
         ;COMPARACION DE LA OPCION 2
        CMP     AL, num2
        JZ      opcion2
        ;COMPARACION DE LA OPCION 3
        CMP     AL, num3
        JZ      opcion3
        CMP     AL, num4
        JZ      opcion4
        CMP     AL, num5
        JZ      opcion5
        
        
        JMP numeroIncorrecto
        
        
     ;ETIQUETAS PARA ERRORES----------------------------------------------------------------------------
      numeroIncorrecto:
            imprimir errorNumero
            JMP imprimirMenu
        
     ;PARA LA VALIDACION DE LAS OPCIONES----------------------------------------------------------------
     opcion1:;CARGAR ECUACION      
        imprimir saltoLinea  
        imprimir text1
        XOR     SI,SI
        XOR     DI,DI 
        
        JMP imprimirMenu
        
     opcion2:;GRAFICAR EN 2D
        imprimir saltoLinea
        ;imprimir text2  
        
        
 ;       MOV     AH,00 
;        MOV     AL,227d
;        MOV     DX,00
;        INT     14H 
;        
;        MOV     AH,01
;        MOV     AL,'H'
;        MOV     DX,00
;        INT     14h
;        
;        MOV     [textoArchivo],AH
;        imprimir textoArchivo
;        
        MOV     AH,00 
        MOV     AL,11100011b
        MOV     DX,00
        INT     14H 
        
;        MOV     AL,'P'
;        OUT     00,AL 
        MOV     [vtext[0]],62h
        MOV     AH,01
        MOV     AL,[vtext[0]]
        MOV     DX,00
        INT     14h
        
        MOV     [textoArchivo],AH
        imprimir textoArchivo 
         
;        MOV     AH,03
;        MOV     DX,00 ;com1
;        INT     14h
;        
;        MOV     [textoArchivo],AL
;        imprimir textoArchivo
;        imprimir saltoLinea 
;        
;        MOV     AH,03
;        MOV     DX,01;com2
;        INT     14h
;        
;        MOV     [textoArchivo],AL
;        imprimir textoArchivo
;        imprimir saltoLinea
;        
;        MOV     AH,03
;        MOV     DX,02 ;com3
;        INT     14h
;        
;        MOV     [textoArchivo],AL
;        imprimir textoArchivo 
;        imprimir saltoLinea
;        
;        MOV     AH,03
;        MOV     DX,03 ;com4?
;        INT     14h
;        
;        MOV     [textoArchivo],AL
;        imprimir textoArchivo  
;        imprimir saltoLinea


        
        XOR     SI,SI
        XOR     DI,DI
        
        JMP imprimirMenu
        
     opcion3:;GRAFICAR EN 3D 
        imprimir saltoLinea 
        imprimir text3  
        
        JMP     imprimirMenu  
        
     opcion4:;CONTROL MOVIL  
        imprimir saltoLinea 
        imprimir text4
         
        XOR     SI,SI
        XOR     DI,DI
        
        JMP      imprimirMenu 
        
     opcion5:;SALIR
        imprimir saltoLinea
        ;imprimir text5   
        
        imprimir msgSalir
        JMP     salir
        
        XOR     SI,SI
        XOR     DI,DI
        
        JMP     imprimirMenu
      
     ;ETIQUETA SALIR
     salir:
        MOV     ax,0c07h;ah,00
        INT     21h 
      
    .exit
end     