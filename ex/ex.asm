                   ;ENSAMBLADOR UTILIZADO: MASM611
;DEL CUAL SE EXTRAJO LA INFORMACION DE INSTALACION Y USO EN: https://www.youtube.com/watch?v=pIRd79UsHXA

.model small

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
    msg10 db "1)CARGAR ARCHIVO",10,13,"2)JUGAR",10,13,"3)TOP 10 PUNTEOS",10,13,"4)GENERAR REPORTES",10,13,"5)SALIR",10,13,10,13,"$"
    msg11 db "ESCOGA UNA OPCION: ",10,13,"$"
    
    ;MENSAJES VARIOS---------------------------------------------------------------------
    msgSalir db "==FIN DEL PROGRAMA, PRESIONE CUALQUIER TECLA PARA SALIR DEL PROGRAMA==",10,13,"$" 
    msgPath db "INGRESE EL PATH DEL ARCHIVO",10,13,"$" 
    msgPalBuscar db "INGRESE PALABRA A BUSCAR:",10,13,"$"
    msgPalRem db "INGRESE PALABRA A REEMPLAZAR: ",10,13,"$"
    saltoLinea db 10,13,"$"   
    textoArchivo db 2 dup("$")
     
    ;PARA OBTENER PATH, Y HANDLER--------------------------------------------------------- 
   ; path2 db "entrada.txt",0,"$" 
    path_ArchivoCarga db "C:\entrada.txt",0,"$"  ;PARA ASSEMBLER C:\entrada.txt    solo entrada va a ser minuscula el resto de archivo creados 
    path_ArchivoSintactico db "C:\A_SIN.txt",0,"$";de assembler tienen que ser mayusculas C:\A_SIN.txt   
    path_Err_AS db "C:\E_SIN.txt",0,"$"           ;C:\E_SIN.txt
    path_Err_AL db "C:\E_LEX.txt",0,"$"           ;C:\E_LEX.txt
    handler_ArchivoCarga dw ? 
    handler_ArchivoSintactico dw ?   
    handler_E_AS dw ?   
    handler_E_AL dw ?
    
    
    

 
    
    ;PARA EL ARCHIVO HTML Y DEMAS----------------------------------------------------------
    corcheteAbierto db "[ ","$"
    separadorFecha db "/","$"
    separadorHora db ":","$"
    corcheteCerrado db "]","$"
    espacio db 32,"$"
    htmlAbierto db "<html>",10,13,"$"
    headAbierto db "<head>",10,13,"$"
    titleAbiertoRF db "<title> Reporte Final </title>",10,13,"$"
    bodyAbierto db "<body>",10,13,"$"
    bodyCerrado db "</body>",10,13,"$"
    headCerrado db "</head>",10,13,"$"
    htmlCerrado db "</html>",10,13,"$"
    DatoNombre db "WILLIAM SANTOS",10,13,"$"
    DatoCarnet db "201700662",10,13,"$"
    saltoHtml db "</br>",10,13,"$" 
    tableAbierto db "<table style='width:100%'>",10,13,"$"
    trtdAbierto db "<tr><td>",10,13,"$"
    trtdCerrado db "</tr></td>",10,13,"$"
    tableCerrado db "</table>",10,13,"$"
    styleAbierto db "<style>",10,13,"$"
    stilo1 db "table, th, td{",10,13,"$"
    stilo2 db "border: 1px solid black;",10,13,"$"
    stilo3 db "}",10,13,"$"
    styleCerrado db "</style>",10,13,"$"
    
    saltoArchivo db 0Dh,0Ah,"$"
     
    
    ;LOS MENSAJES DE ERROR--------------------------------------------------------------------------------
    errorNumero db 10,13,"==== OPCION INVALIDA ====",10,13,"$" 
    errorAperturaArchivo db 10,13,"==== OCURRIO ERROR AL ABRIR ARCHIVO ====",10,13,"$"
    errorLecturaArchivo db 10,13,"==== ERROR DE LECTURA EN EL ARCHIVO ====",10,13,"$"   
    errorCreacionArchivo db 10,13,"=== ERROR EN LA CREACION DEL ARCHIVO ====",10,13,"$"
    errorEscrituraArchivo db 10,13, "=== ERROR EN LA ESCRITURA DEL ARCHIVO ====",10,13,"$"
    errorLEX db 10, 13,"%%%%% ERROR LEXICO %%%%%",10,13,"Caracter no esperado: ","$"
    errorSINT db 10,13,"%%%%% ERROR SINTACTICO %%%%",10,13,"$" 
    errorAnalisis db "OCURRIERON ERRORES EN EL ANALISIS",10,13,"$"
   ; not_menorque db 10,13," se esperaba <",10,13,"$"
   ; not_punto_coma db 10,13,"se esperaba ;",10,13,"$" 
   
    not_estado1 db 10,13, "se esperaba /, Operacion y arqui ",10,13,"$"
    error_s1 db 10,13, "SE ESPERABA <",10,13,"$"  
    error_sv1 db 10,13,"SE ESPERABA arqui1",10,13,"$"
    error_s2 db 10,13,"SE ESPERABA >",10,13,"$"  
    error_s4 db 10,13,"SE ESPERABA Operacion",10,13,"$"    
    error_s6 db 10,13,"SE ESPERABA NUMERO[0-9]",10,13,"$"
    error_s7 db 10,13,"SE ESPERABA OPERADOR O FIN DE OPERACION",10,13,"$"
    error_s8 db 10,13,"SE ESPERABA * O NUMERO[0-9]",10,13,"$"  
    error_s10 db 10,13,"SE ESPERABA OPERADOR O ;",10,13,"$" 
    error_s12 db 10,13,"SE ESPERABA /",10,13,"$"  
    error_s14 db 10,13,"SE ESPERABA CERO O >",10,13,"$" 
    error_s16 db 10,13,"SE ESPERABA LETRA O /",10,13,"$"     
    confirmacion_s18 db 10,13,"SE ENCONTRO > FIN DE AUTOMATA SINTACTICO",10,13,"$"
    
     
    ;LOS NUMEROS PARA REALIZAR LAS COMPARACIONES----------------------------------------------------------
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
    
    ;VARIABLES BANDERAS-------------------------------------------------------------------------------- 
    
    ;STRUCTS ------------------------------------------------------------------------------------------
;    NodoLista STRUCT
;     DatosNodo db 20 dup("$")
;     ApuntSig db 0
;    NodoLista ENDS   
;    
;    ListaEnlazada LABEL PTR NodoLista
;    
;    listado1 NodoLista<'hola',5> 
    
    listado2 dw 2 dup("$"),"$"      ;va a trabajar con hexadecimal para reconocer operadore y numeros 
    listado3 dw 2 dup("$"),"$" 
    listado4 dw 4,2 dup("$"),"$"     ;cuatro filas de dos columnas
    arbol dw 30 dup("$"),"$"
    padre db 0
    izquierdo db 0
    derecho db 0
    
    contador dw 0
    
.code   



;MACROS QUE SON DE LA OPCION 10 

imprimir MACRO texto
     XOR        DX,DX
     MOV        DX,OFFSET texto
     MOV        AH,09h
     INT        21h
ENDM   

imprimirD MACRO num
    XOR         AH,AH
    MOV         AH,02h
    MOV         DL,num
    ADD         DL,30h
    INT         21h
ENDM

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

     
;crearArchivoPivote MACRO pArchivo,hArchivo
;        MOV     AH,3Ch
;        MOV     CX,0                       
;        MOV     DX,offset pArchivo
;        INT     21h
;        JC      errorCrearArchivo   
;        MOV     hArchivo,AX
;ENDM
;
;escribirArchivoPivote MACRO texto,cant,hArc
;        MOV     AH, 40h
;        MOV     BX, hArc
;        MOV     CX, cant
;        MOV     DX, offset texto 
;        INT     21h
;        JC      errorEscribirArchivoPivote  
;ENDM 
;
;cerrarArchivoPivote MACRO hArc2
;        MOV     AH,3Eh
;        MOV     BX,hArc2
;        INT     21h
;ENDM 
;


;leerArchivoPivote MACRO hArc5
;  leerArcP:
;    MOV     AH,3fh
;    MOV     BX,hArc5
;    XOR     DX,DX
;    MOV     dx,offset textoPivote
;    MOV     CX, 1
;    INT     21h
;    JC      errorLeerArchivo 
;    CMP     AX,0
;    JZ      continuacionAP 
;    
;    JMP     leerArcP
;   
;  continuacionAP:
;   
;ENDM


    .startup   
     ;MOV    AL,0fh
     ;MOV    AH,00
     ;INT    10h
     
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
        ;COMPARACION DE LA OPCION 4
        CMP     AL, num4
        JZ      opcion4
        ;COMPARACION DE LA OPCION 5
        CMP     AL, num5
        JZ      opcion5
        
        JMP numeroIncorrecto
        
        
     ;ETIQUETAS PARA ERRORES----------------------------------------------------------------------------
      numeroIncorrecto:
            imprimir errorNumero
            
            JMP imprimirMenu
        
     ;PARA LA VALIDACION DE LAS OPCIONES----------------------------------------------------------------
     opcion1:      
        imprimir saltoLinea  
        imprimir text1
        XOR     SI,SI
        XOR     DI,DI     
                               
        ;                                                      
;        MOV     [listado2[0]],5
;        MOV     [listado2[1]],offset listado2
;        
;        imprimir listado2
         MOV    padre,1
         
         imprimirD padre                   
                           
     
        JMP imprimirMenu
        
     opcion2:
        imprimir saltoLinea
        
        XOR     SI,SI
        XOR     DI,DI   
       
         
        JMP imprimirMenu
        
     opcion3: 
        imprimir saltoLinea 
        imprimir text3 
        
        XOR     SI,SI
        XOR     DI,DI
        
        JMP     imprimirMenu 
     
     opcion4:
        imprimir saltoLinea
        imprimir text4  
        
        XOR     SI,SI                       
        XOR     DI,DI
        
        JMP imprimirMenu
     
     opcion5:
        imprimir saltoLinea 
        
        imprimir msgSalir 
        JMP salir 
        
        JMP imprimirMenu
     
      
     ;ETIQUETA SALIR
     salir:
        MOV     ax,0c07h;ah,00
        INT     21h 
      
    .exit
end