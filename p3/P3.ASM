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
    msg8 db "PRACTICA 3",10,13,10,13,"$"
    msg9 db 10,13,"MENU",10,13,"$"
    msg10 db "1)CARGAR TEXTO",10,13,"2)A MAYUSCULA",10,13,"3)A MINUSCULA",10,13,"4)A CAPITAL",10,13,"5)BUSCAR Y REEMPLAZAR",10,13,"6)INVERTIR PALABRAS",10,13,"7)REPORTE DIPTONGOS",10,13,"8)REPORTE HIATOS",10,13,"9)REPORTE TRIPTONGOS",10,13,"10)REPORT
E FINAL",10,13,"11)SALIR",10,13,10,13,"$"
    msg11 db "ESCOGA UNA OPCION: ",10,13,"$"
    
    ;MENSAJES VARIOS---------------------------------------------------------------------
    msgSalir db "==FIN DEL PROGRAMA, PRESIONE CUALQUIER TECLA PARA SALIR DEL PROGRAMA==",10,13,"$" 
    msgPath db "INGRESE EL PATH DEL ARCHIVO",10,13,"$" 
    msgPalBuscar db "INGRESE PALABRA A BUSCAR:",10,13,"$"
    msgPalRem db "INGRESE PALABRA A REEMPLAZAR: ",10,13,"$"
    saltoLinea db 10,13,"$"
     
    ;PARA OBTENER PATH, Y HANDLER--------------------------------------------------------- 
    textoArchivo db 2 dup("$")
    textoPivote db 2 dup("$")
    path db 100 dup(0)   
    path2 db "arc.txt",0,"$"
    PalabraBuscar db 75 dup("$") 
    PalabraReemplaza db 75 dup("$") 
    Recuperada db 75 dup("$") 
     
    PalabraHiato db 50 dup("$")
    PalabraDiptongo db 50 dup("$")
    PalabraTriptongo db 50 dup("$")
    
   ; PalabraInvertida db 75 dup("$")                    ;SE COMENTANDO PENSANDO QUE NO SE USA YA QUE SE USO LA PILA
    diaSistema db 5 dup("$"),"$"                       ;CON ESTA VARIABLE RECUPERAMOS DIA, MES Y ANIO 
    
    pathArcRF db "c:\RF.txt",0,"$"         ;PARA DOSBOX SE USA c:\....
    pathArcP  db "c:\AP.txt",0,"$"
    pathArcRH db "c:\RH.html",0,"$" 
    pathArcRD db "c:\RD.html",0,"$"
    pathArcRT db "c:\RT.html",0,"$"
                               
    limpiar db 75 dup("$")     
    handler dw ? 
    handlerAux dw ?
    hanlderArcRF dw ?
    handlerArcP dw ?
    handlerArcRH dw ?
    handlerArcRD dw ?
    handlerArcRT dw ?
    
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
    error1 db 10,13,"**LA OPCION INGRESADA NO ES VALIDA**",10,13,10,13,"$"
    error2 db 10,13,"**NO SE PUDO ABRIR EL ARCHIVO**",10,13,10,13,"$"  
    error3 db 10,13,"**NO SE PUDO LEER EL ARCHIVO**",10,13,10,13,"$"
    error4 db 10,13,"**ERROR POSICIONAR PUNTERO**",10,13,10,13,"$" 
    error5 db 10,13,"**ERROR AL ESCRIBIR ARCHIVO**",10,13,10,13,"$"
    error6 db 10,13,"**ERROR AL CREAR ARCHIVO**",10,13,10,13,"$" 
    error7 db 10,13,"**ERROR AL ESCRIBIR ARCHIVO P**",10,13,10,13,"$"
    
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
     
    
    
.code  

;MACRO QUE IMPRIME UNA CADENA
imprimir MACRO texto   
    XOR     DX,DX
    MOV     DX, OFFSET texto    
    MOV     AH, 09h
    INT     21h
ENDM  
;MACRO DONDE SE INGRESA UN NUMERO DE DOS DIGITOS Y COMPARA LAS DECENAS PARA AVERIGUAR LA OPCION ESCOGIDA
ingresaNumero MACRO 
 XOR        AX,AX
 MOV        AH,01h
 INT        21h
 SUB        AL,30h
 MOV        decenas, AL
 
 MOV        AH,01h
 INT        21h
 SUB        AL,30h
 MOV        unidades,AL 
 
 MOV        AL,decenas
 CMP        AL,num1
 
 JC         decenasCero
 JZ         decenasUno
 JNZ        numeroIncorrecto
 
ENDM 
;MACRO QUE RECIBE UNA CADENA ESCRITA DESDE EL TECLADO 
capturarCadena MACRO
    capturar:
        INT     21h
        CMP     AL,13               ;SI ES ENTER SE SALE Y MUESTRA EL PATH
        JZ      mostrarPath
        MOV     path[SI],AL
        INC     SI     
        JMP     capturar
ENDM 

capturaPalabraBuscar MACRO 
    palBus:
        INT     21h
        CMP     AL,13
        JZ      mostPalBuscar
        MOV     PalabraBuscar[SI],AL
        INC     SI
        JMP     palBus
ENDM 

capturaPalabraReemplazar MACRO 
    palRem:
        INT     21h
        CMP     AL,13
        JZ      mostPalReemplazar  
        MOV     PalabraReemplaza[SI],AL
        INC     SI
        JMP     palRem
        
ENDM  

limpiarPalabraBuscar MACRO
    XOR     DI,DI
    XOR     SI,SI 
    MOV     DI,CX
    MOV     CX,50
    MOV     SI,50
    limPalBus:      
        MOV     PalabraBuscar[SI],24h
        DEC     SI
        LOOP    limPalBus   
    
    MOV     CX,DI
    XOR     DI,DI
ENDM

limpiarPalabraReemplazar MACRO
    XOR     DI,DI
    XOR     SI,SI 
    MOV     DI,CX
    MOV     CX,50
    MOV     SI,50
    limPalRem:      
        MOV     PalabraReemplaza[SI],24h
        DEC     SI
        LOOP    limPalRem   
    
    MOV     CX,DI
    XOR     DI,DI
ENDM 

limpiarRecuperada MACRO
    XOR     DI,DI
    XOR     SI,SI 
    MOV     DI,CX
    MOV     CX,50
    MOV     SI,50
    limPalRep:      
        MOV     Recuperada[SI],24h
        DEC     SI
        LOOP    limPalRep   
    
    MOV     CX,DI
    XOR     DI,DI
ENDM 

limpiarPalabraHiato MACRO  ;SE CREO MACRO LIMPIAR HIATO Y SE COLOCO MACRO EN LA OPCION 8 DE HIATO
    XOR     DI,DI
    XOR     SI,SI
    MOV     DI,CX
    MOV     CX,30
    MOV     SI,30
    limPalHi:
        MOV     PalabraHiato[SI],24h
        DEC     SI
        LOOP    limPalHi
    MOV     CX,DI
    XOR     DI,DI
ENDM 

limpiarPalabraDiptongo MACRO  ;SE CREO MACRO LIMPIAR DIPTONGO Y SE COLOCO MACRO EN LA OPCION 7 DE DIPTONGO
    XOR     DI,DI
    XOR     SI,SI
    MOV     DI,CX
    MOV     CX,30
    MOV     SI,30
    limPalDIP:
        MOV     PalabraDiptongo[SI],24h
        DEC     SI
        LOOP    limPalDIP
    MOV     CX,DI
    XOR     DI,DI
ENDM 
;PalabraTriptongo 

limpiarPalabraTriptongo MACRO  ;SE CREO MACRO LIMPIAR TRIPTONGO Y SE COLOCO MACRO EN LA OPCION 9 DE TRIPTONGO
    XOR     DI,DI
    XOR     SI,SI
    MOV     DI,CX
    MOV     CX,30
    MOV     SI,30
    limPalTRIP:
        MOV     PalabraTriptongo[SI],24h
        DEC     SI
        LOOP    limPalTRIP
    MOV     CX,DI
    XOR     DI,DI
ENDM 

;MACRO QUE ABRIRA EL ARCHIVO
abrirArchivo MACRO     
   MOV  AH,3dh
   MOV  AL,0
   MOV  DX,offset path                         ;--------------------path
   INT  21h
   JC   errorAbrirArchivo
   MOV  handler, AX  
ENDM 

leerArchivo MACRO
    ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
    escribirArchivoPivote saltoHtml,7,handlerArcP
    ;//////////////////////////////////////////////////////////////////////////////     
  leer:
    MOV     AH,3fh
    MOV     BX,handler
    XOR     DX,DX
    MOV     dx,offset textoArchivo
    MOV     CX, 1
    INT     21h
    JC      errorLeerArchivo 
    CMP     AX,0
    JZ      cerrarA
    imprimir textoArchivo
    ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
    escribirArchivoPivote textoArchivo,1,handlerArcP
    ;//////////////////////////////////////////////////////////////////////////////
    JMP     leer
   
ENDM  
;CON ESTA MACRO EMPIEZA LA CONVERSION DE MINUSCULA A MAYUSCULA
leerArchivoMayuscula MACRO
    ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
    escribirArchivoPivote saltoHtml,7,handlerArcP
    ;//////////////////////////////////////////////////////////////////////////////
    leerM:
        MOV     AH,3fh
        MOV     BX,handler
        XOR     DX,DX
        MOV     dx,offset textoArchivo
        MOV     CX, 1
        INT     21h
        JC      errorLeerArchivo 
        CMP     AX,0
        JZ      cerrarA 
        MOV     DH,[textoArchivo]
        CMP     DH,60H
        
        JA     verificacion2      ;SI ES MAYOR QUE 61 SIGNIFICA QUE ES UNA LETRA MINUSCULA SALTAMOS A CONVERTIRLA A MAYUSCULA
        
        imprimir textoArchivo
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote textoArchivo,1,handlerArcP
        ;////////////////////////////////////////////////////////////////////////////// 
        escribirArchivo
        JMP     leerM  
ENDM  

;CON ESTA MACRO EMPIEZA LA CONVERSION DE MAYUSCULA A MINUSCULA
leerArchivoMinuscula MACRO
    ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
    escribirArchivoPivote saltoHtml,7,handlerArcP
    ;//////////////////////////////////////////////////////////////////////////////
    leerMinus:
        MOV     AH,3fh
        MOV     BX,handler
        XOR     DX,DX
        MOV     DX,offset textoArchivo
        MOV     CX,1
        INT     21h
        JC      errorLeerArchivo
        CMP     AX,0
        JZ      cerrarA                 ;SI LLEGA AL FINAL ARCHIVO SE VA A CERRARLO
        MOV     DH,[textoArchivo]
        CMP     DH,40h
        
        JA      verificacion2Minuscula   ;VERFICAMOS SI ES MAYOR A 40H ES MAYUSCULA
        
        imprimir textoArchivo            ;SI NO LO ES LO IMPRIMIMOS
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote textoArchivo,1,handlerArcP
        ;//////////////////////////////////////////////////////////////////////////////
        escribirArchivo                  ;Y LO GUARDAMOS EN EL ARCHIVO
        JMP     leerMinus                ;SEGUIMOS LEYENDO MAYUSCULA
ENDM 
;CON ESTA MACRO EMPIEZA LA CONVERSION DE MINUSCULA A CAPITAL
leerArchivoCapital MACRO
    ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
    escribirArchivoPivote saltoHtml,7,handlerArcP
    ;//////////////////////////////////////////////////////////////////////////////
    leerCapi:
        MOV     AH,3fh
        MOV     BX,handler
        XOR     DX,DX
        MOV     DX, offset textoArchivo
        MOV     CX,1
        INT     21h
        JC      errorLeerArchivo
        CMP     AX,0
        JZ      cerrarA
        MOV     DH,[textoArchivo]
        CMP     DH,60h
        JA      verificacionCapital 
        CMP     DH,40h
        JA      imprmirCapi
        
        imprimir textoArchivo
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote textoArchivo,1,handlerArcP
        ;//////////////////////////////////////////////////////////////////////////////
        escribirArchivo
        XOR     DI,DI
        JMP     leerCapi 
        
     imprmirCapi:
     
        imprimir textoArchivo 
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote textoArchivo,1,handlerArcP
        ;//////////////////////////////////////////////////////////////////////////////
        escribirArchivo
        INC     DI
        JMP     leerCapi
    
ENDM 

leerArchivoInvertirPalabra MACRO
    ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
    escribirArchivoPivote saltoHtml,7,handlerArcP
    ;//////////////////////////////////////////////////////////////////////////////
    leerIP:
        MOV     AH,3fh
        MOV     BX,handler
        XOR     DX,DX
        MOV     DX,offset textoArchivo
        MOV     CX,1
        INT     21h
        JC      errorLeerArchivo
        CMP     AX,0
        JZ      final 
        MOV     DH,[textoArchivo]
        CMP     DH,20h
        JE      invertir2
        
        ;imprimir textoArchivo 
        PUSH    DX
        INC     DI
        JMP     leerIP    
        
    invertir2:
        POP     DX
        MOV     textoArchivo,DH
        imprimir textoArchivo 
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote textoArchivo,1,handlerArcP
        ;//////////////////////////////////////////////////////////////////////////////
        escribirArchivo
        DEC     DI
        CMP     DI,0
        JA      invertir2   
        MOV     DH,20h
        MOV     textoArchivo,DH
        imprimir textoArchivo
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote textoArchivo,1,handlerArcP
        ;////////////////////////////////////////////////////////////////////////////// 
        escribirArchivo
        JMP     leerIP 
        
    final:
        POP     DX
        MOV     textoArchivo,DH  
        imprimir textoArchivo
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote textoArchivo,1,handlerArcP
        ;//////////////////////////////////////////////////////////////////////////////
        escribirArchivo
        DEC     DI
        CMP     DI,0
        JA      final
        MOV     DH,20h
        MOV     textoArchivo,DH
        imprimir textoArchivo
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote textoArchivo,1,handlerArcP
        ;//////////////////////////////////////////////////////////////////////////////
        escribirArchivo
        JMP     cerrarA
    
ENDM 

;CON ESTA MACRO BUSCAMOS LA PALABRA Y LA REEMPLAZAMOS
leerArchivoBuscarReemplazar MACRO
    ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
    escribirArchivoPivote saltoHtml,7,handlerArcP
    ;////////////////////////////////////////////////////////////////////////////// 
   abrirArchivoPivote 3D01h,path,handlerAux                  ;--------------------path
   buscarReemplazar:            
        MOV     AH,3fh
        MOV     BX,handler
        XOR     DX,DX
        MOV     DX,offset textoArchivo
        MOV     CX,1
        INT     21h
        JC      errorLeerArchivo
        CMP     AX,0
        JZ      finalArchivo
        MOV     DH,[textoArchivo] 
        CMP     DH,20h
        JE      encontroEspacio
        CMP     DH,0Dh
        JE      buscarReemplazar
        CMP     DH,0Ah
        JE      encontroEspacio
        MOV     Recuperada[SI],DH
        INC     SI
        JMP     buscarReemplazar
        
   encontroEspacio:
        MOV     DL,[PalabraBuscar]
        CMP     DL,[Recuperada]
        JE      palabraEncontradaEspacio
        imprimir Recuperada
        imprimir espacio
        escribirArchivoPivote Recuperada,SI,handlerAux
        escribirArchivoPivote espacio,1,handlerAux
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote Recuperada,SI,handlerArcP
        ;////////////////////////////////////////////////////////////////////////////// 
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote espacio,1,handlerArcP
        ;//////////////////////////////////////////////////////////////////////////////
        XOR     SI,SI
        JMP     limpiarVariableRecuperada 
        
   finalArchivo:
        MOV     DL,[PalabraBuscar]
        CMP     DL,[Recuperada]
        JE      palabraEncontradaFinalArchivo   
        MOV     ES,AX
        imprimir Recuperada
        imprimir saltoLinea
        escribirArchivoPivote Recuperada,SI,handlerAux
        escribirArchivoPivote saltoArchivo,2,handlerAux  
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote Recuperada,SI,handlerArcP
        ;//////////////////////////////////////////////////////////////////////////////  
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote saltoArchivo,2,handlerArcP
        ;////////////////////////////////////////////////////////////////////////////// 
        cerrarArchivoPivote handlerAux
        JMP     limpiarVariableRecuperada
        
   limpiarVariableRecuperada:
        limpiarRecuperada 
        MOV     AX,ES
        CMP     AX,0
        JE      cerrarA
        JMP     buscarReemplazar
        
   palabraEncontradaEspacio:
        imprimir PalabraReemplaza
        imprimir espacio
        escribirArchivoPivote PalabraReemplaza,SI,handlerAux
        escribirArchivoPivote espacio,1,handlerAux
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote PalabraReemplaza,SI,handlerArcP
        ;//////////////////////////////////////////////////////////////////////////////
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote espacio,1,handlerArcP
        ;//////////////////////////////////////////////////////////////////////////////
        XOR     SI,SI
        JMP     limpiarVariableRecuperada
        
   palabraEncontradaFinalArchivo:
        MOV     ES,AX
        imprimir PalabraReemplaza
        imprimir saltoLinea
        escribirArchivoPivote PalabraReemplaza,SI,handlerAux
        escribirArchivoPivote saltoArchivo,2,handlerAux 
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote PalabraReemplaza,SI,handlerArcP
        ;////////////////////////////////////////////////////////////////////////////// 
        ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
        escribirArchivoPivote saltoArchivo,2,handlerArcP
        ;//////////////////////////////////////////////////////////////////////////////
        JMP     limpiarVariableRecuperada
ENDM   

leerArchivoHiato MACRO
  leerHiato:
    MOV     AH,3fh
    MOV     BX,handler
    XOR     DX,DX
    MOV     dx,offset textoArchivo
    MOV     CX, 1
    INT     21h
    JC      errorLeerArchivo 
    CMP     AX,0
    JZ      finalHiato
    MOV     DH,[textoArchivo]
    CMP     DH,20h
    JE      encontroEspacioHiato
    ;imprimir textoArchivo
    MOV     PalabraHiato[SI],DH
    INC     SI
    JMP     leerHiato
   
    
  encontroEspacioHiato:
    ;imprimir PalabraHiato
    JMP verficarAEO
  
  
  finalHiato:
    MOV     ES,AX
    ;imprimir PalabraHiato 
    JMP verficarAEO
  
  
  limpPalabraHiato:
    limpiarPalabraHiato
    XOR     SI,SI
    XOR     DI,DI
    MOV     AX,ES
    CMP     AX,0
    JE      continuacionArchivoFinalRH
    JMP     leerHiato 
    
   
   verficarAEO:
    seguirVerificacion:
        CMP     [PalabraHiato[DI]],61h  ;COMPARA SI ES UNA "a"
        JE      encontroAEO
        CMP     [PalabraHiato[DI]],41h  ;COMPARA SI ES UNA "A"
        JE      encontroAEO
        CMP     [PalabraHiato[DI]],65h  ;COMPARA SI ES UNA "e"
        JE      encontroAEO
        CMP     [PalabraHiato[DI]],45h  ;COMPARA SI ES UNA "E"
        JE      encontroAEO 
        CMP     [PalabraHiato[DI]],6Fh  ;COMPARA SI ES UNA "o"
        JE      encontroAEO
        CMP     [PalabraHiato[DI]],4Fh  ;COMPARA SI ES UNA "O"
        JE      encontroAEO
        CMP     [PalabraHiato[DI]],69h  ;COMPARA SI ES UNA "i"
        JE      encontroI
        CMP     [PalabraHiato[DI]],49h  ;COMPARA SI ES UNA "I"
        JE      encontroI
        CMP     [PalabraHiato[DI]],75h  ;COMPARA SI ES UNA "u"
        JE      encontroU
        CMP     [PalabraHiato[DI]],55h  ;COMPARA SI ES UNA "U"
        JE      encontroU
        INC     DI
        CMP     SI,DI
        JE      limpPalabraHiato
        JMP     seguirVerificacion
        
   encontroAEO:
        INC     DI
        CMP     [PalabraHiato[DI]],6Fh   ;COMPARA SI ES UNA "o"
        JE      verificado
        CMP     [PalabraHiato[DI]],4Fh   ;COMPARA SI ES UNA "O"
        JE      verificado  
        CMP     [PalabraHiato[DI]],61h  ;COMPARA SI ES UNA "a"
        JE      verificado
        CMP     [PalabraHiato[DI]],41h  ;COMPARA SI ES UNA "A"
        JE      verificado
        CMP     [PalabraHiato[DI]],65h  ;COMPARA SI ES UNA "e"
        JE      verificado
        CMP     [PalabraHiato[DI]],45h  ;COMPARA SI ES UNA "E"
        JE      verificado 
        CMP     DI,SI                       ;SE AGREGO ESTO ES NUEVO FUNCIONABA BIEN SIN ESTO CUALQUIER PROBLEMA
        JE      limpPalabraHiato                 ;ESTE ES EL PROBLEMA
        JMP     seguirVerificacion
        
   encontroI:
        INC     DI
        CMP     [PalabraHiato[DI]],69h  ;COMPARA SI ES UNA "i"
        JE      verificado
        CMP     [PalabraHiato[DI]],49h  ;COMPARA SI ES UNA "I"
        JE      verificado 
        CMP     DI,SI                       ;SE AGREGO ESTO ES NUEVO FUNCIONABA BIEN SIN ESTO CUALQUIER PROBLEMA
        JNE     limpPalabraHiato                 ;ESTE ES EL PROBLEMA
        JMP     seguirVerificacion
        
   encontroU:
        INC     DI
        CMP     [PalabraHiato[DI]],75h  ;COMPARA SI ES UNA "u"
        JE      verificado
        CMP     [PalabraHiato[DI]],55h  ;COMPARA SI ES UNA "U"
        JE      verificado
        CMP     DI,SI                       ;SE AGREGO ESTO ES NUEVO FUNCIONABA BIEN SIN ESTO CUALQUIER PROBLEMA
        JNE     limpPalabraHiato                 ;ESTE ES EL PROBLEMA
        JMP     seguirVerificacion
        
   verificado:
        ;imprimir saltoLinea
        ;imprimir PalabraHiato
        ;/////////////////////////////////ESCRIBIENDO EN EL REPORTE DE HIATOS /////////////////// 
        escribirArchivoPivote trtdAbierto,10,handlerArcRH
        escribirArchivoPivote PalabraHiato,SI,handlerArcRH
        escribirArchivoPivote trtdCerrado,12,handlerArcRH
        JMP     limpPalabraHiato
    
ENDM



;////////////////////////////LEER ARCHIVO DIPTONGO ////////////////////////////////

leerArchivoDiptongo MACRO
  leerDiptongo:
    MOV     AH,3fh
    MOV     BX,handler
    XOR     DX,DX
    MOV     dx,offset textoArchivo
    MOV     CX, 1
    INT     21h
    JC      errorLeerArchivo 
    CMP     AX,0
    JZ      finalArchivoDiptongo
    MOV     DH,[textoArchivo]
    CMP     DH,20h
    JE      encontroEspacioDiptongo
    ;imprimir textoArchivo
    MOV     PalabraDiptongo[SI],DH
    INC     SI
    JMP     leerDiptongo
    
    encontroEspacioDiptongo:
        ;imprimir PalabraDiptongo
        JMP     VerificarIUEOA
        JMP     limpiarDiptongo
     
        
    finalArchivoDiptongo:
        MOV     ES,AX
        ;imprimir PalabraDiptongo
        JMP     VerificarIUEOA
        JMP     limpiarDiptongo
               
    
    VerificarIUEOA:
      SeguiVerificacionDiptongo:
        CMP     [PalabraDiptongo[DI]],69h       ;verifica si es i
        JE      EncontroIUDiptongo
        CMP     [PalabraDiptongo[DI]],49h       ;I
        JE      EncontroIUDiptongo
        CMP     [PalabraDiptongo[DI]],75h       ;u
        JE      EncontroIUDiptongo
        CMP     [PalabraDiptongo[DI]],55h       ;U
        JE      EncontroIUDiptongo
        CMP     [PalabraDiptongo[DI]],65h       ;e
        JE      EncontroAEODiptongo
        CMP     [PalabraDiptongo[DI]],45h       ;E
        JE      EncontroAEODiptongo 
        CMP     [PalabraDiptongo[DI]],6Fh       ;o
        JE      EncontroAEODiptongo
        CMP     [PalabraDiptongo[DI]],4Fh       ;O
        JE      EncontroAEODiptongo
        CMP     [PalabraDiptongo[DI]],61h       ;a
        JE      EncontroAEODiptongo
        CMP     [PalabraDiptongo[DI]],41h       ;A
        JE      EncontroAEODiptongo
        INC     DI
        CMP     DI,SI
        JE      limpiarDiptongo
        JMP     SeguiVerificacionDiptongo                                       
                                                
    EncontroIUDiptongo:
        INC     DI
        CMP     [PalabraDiptongo[DI]],61h       ;a
        JE     EsDiptongo
        CMP     [PalabraDiptongo[DI]],41h       ;A
        JE     EsDiptongo
        CMP     [PalabraDiptongo[DI]],65h       ;e
        JE     EsDiptongo
        CMP     [PalabraDiptongo[DI]],45h       ;E
        JE     EsDiptongo
        CMP     [PalabraDiptongo[DI]],6Fh       ;o
        JE     EsDiptongo
        CMP     [PalabraDiptongo[DI]],4Fh       ;O
        JE     EsDiptongo
        CMP     DI,SI
        JE      limpiarDiptongo
        JMP     SeguiVerificacionDiptongo
        
    EncontroAEODiptongo:
        INC     DI
        CMP     [PalabraDiptongo[DI]],69h       ;i
        JE      EsDiptongo                                        
        CMP     [PalabraDiptongo[DI]],49h       ;I
        JE      EsDiptongo
        CMP     [PalabraDiptongo[DI]],75h       ;u
        JE      EsDiptongo
        CMP     [PalabraDiptongo[DI]],55h       ;U
        JE      EsDiptongo
        CMP     DI,SI
        JE      limpiarDiptongo
        JMP     SeguiVerificacionDiptongo
               
    limpiarDiptongo:
        limpiarPalabraDiptongo
        XOR     SI,SI
        XOR     DI,DI
        MOV     AX,ES
        CMP     AX,0
        JE      continuacionArchivoFinalRD
        JMP     leerDiptongo
        
    EsDiptongo:                
        ;imprimir saltoLinea
        ;imprimir PalabraDiptongo
        ;imprimir saltoLinea
        ;imprimir PalabraHiato
        ;/////////////////////////////////ESCRIBIENDO EN EL REPORTE DE HIATOS /////////////////// 
        escribirArchivoPivote trtdAbierto,10,handlerArcRD
        escribirArchivoPivote PalabraDiptongo,SI,handlerArcRD
        escribirArchivoPivote trtdCerrado,12,handlerArcRD
        JMP limpiarDiptongo
        
    
ENDM

;///////////////////////// FIN LECTURA ARCHIVO DIPTONGO /////////////////////////// 

;/////////////////////////////////LEER ARCHIVO TRIPTONGO ////////////////////////////

 leerArchivoTriptongo MACRO
     leerTriptongo:
        MOV     AH,3fh
        MOV     BX,handler
        XOR     DX,DX
        MOV     dx,offset textoArchivo
        MOV     CX, 1
        INT     21h
        JC      errorLeerArchivo 
        CMP     AX,0
        JZ      finalArchivoTriptongo
        MOV     DH,[textoArchivo]
        CMP     DH,20h
        JE      encontroEspacioTriptongo
        ;imprimir textoArchivo 
        
        MOV     PalabraTriptongo[SI],DH
        INC     SI
        JMP     leerTriptongo
        
     encontroEspacioTriptongo: 
        ;imprimir PalabraTriptongo
        JMP     VerificarIUTriptongo
        JMP     limpTriptongo 
        
        
     finalArchivoTriptongo:
        MOV     ES,AX
        ;imprimir PalabraTriptongo
        JMP     VerificarIUTriptongo
        JMP     limpTriptongo
        
     
     VerificarIUTriptongo:
        SeguirVerificacionIUTrip:
            CMP     [PalabraTriptongo[DI]],69h      ;i
            JE      VerificarAEOTriptongo
            CMP     [PalabraTriptongo[DI]],49h      ;I
            JE      VerificarAEOTriptongo
            CMP     [PalabraTriptongo[DI]],75h      ;u
            JE      VerificarAEOTriptongo
            CMP     [PalabraTriptongo[DI]],55h      ;U
            JE      VerificarAEOTriptongo
            INC     DI
            CMP     DI,SI
            JE      limpTriptongo
            JMP     SeguirVerificacionIUTrip 
            
            
     VerificarAEOTriptongo:
        INC     DI
        CMP     [PalabraTriptongo[DI]],61h    ;a
        JE      VerificarIUTriptongoFinal
        CMP     [PalabraTriptongo[DI]],41h    ;A
        JE      VerificarIUTriptongoFinal
        CMP     [PalabraTriptongo[DI]],65h    ;e
        JE      VerificarIUTriptongoFinal
        CMP     [PalabraTriptongo[DI]],45h    ;E
        JE      VerificarIUTriptongoFinal
        CMP     [PalabraTriptongo[DI]],6Fh    ;o
        JE      VerificarIUTriptongoFinal
        CMP     [PalabraTriptongo[DI]],4Fh    ;O
        JE      VerificarIUTriptongoFinal
;        CMP     [PalabraTriptongo[DI]],0EFh    ;a acentuada
;        JE      VerificarIUTriptongoFinal
;        CMP     [PalabraTriptongo[DI]],0C3h    ;A acentudad
;        JE      VerificarIUTriptongoFinal
;        CMP     [PalabraTriptongo[DI]],0BBh    ;e acentuada
;        JE      VerificarIUTriptongoFinal
;        CMP     [PalabraTriptongo[DI]],0A9h    ;E acentuada
;        JE      VerificarIUTriptongoFinal
;        CMP     [PalabraTriptongo[DI]],0C3h    ;o acentuada
;        JE      VerificarIUTriptongoFinal
;        CMP     [PalabraTriptongo[DI]],0ADh    ;O acentuada
;        JE      VerificarIUTriptongoFinal
        CMP     DI,SI
        JE      limpTriptongo
        JMP     SeguirVerificacionIUTrip
      
        
      VerificarIUTriptongoFinal:
        INC     DI
        CMP     [PalabraTriptongo[DI]],69h      ;i
        JE      EsTriptongo
        CMP     [PalabraTriptongo[DI]],49h      ;I
        JE      EsTriptongo
        CMP     [PalabraTriptongo[DI]],75h      ;u
        JE      EsTriptongo
        CMP     [PalabraTriptongo[DI]],55h      ;U 
        JE      EsTriptongo
        CMP     DI,SI
        JE      limpTriptongo
        JMP     SeguirVerificacionIUTrip
        
     EsTriptongo:                
        ;imprimir saltoLinea
        ;imprimir PalabraTriptongo
        escribirArchivoPivote trtdAbierto,10,handlerArcRT
        escribirArchivoPivote PalabraTriptongo,SI,handlerArcRT
        escribirArchivoPivote trtdCerrado,12,handlerArcRT        
        JMP     limpTriptongo 
        
        
     limpTriptongo:
        limpiarPalabraTriptongo
        XOR     SI,SI
        XOR     DI,DI
        MOV     AX,ES
        CMP     AX,0
        JE      continuacionArchivoFinalRT
        JMP     leerTriptongo
        
 ENDM

;///////////////////////////////////////////////////////////

;CON ESTA MACRO POSICIONA EL PUNTERO DEL ARCHIVO DEL HANDLE QUE ESTA EN BX
posicionarPuntero MACRO
        MOV     AH,42h
        MOV     AL,00h            ;QUE EMPIEZE A CONTAR DESDE EL INICIO DEL ARCHIVO SEEK_SET
        ;MOV     BX,handler
        MOV     CX,0              ;CX DEBE SER CERO MITAD MAS SIGNIFICATIVA DEL DESPLAZAMIENTO
        MOV     DX,SI             ;DX EL VALOR A MOVERSE LA MITAD MENOS SIGNIFICATIVA DEL DESPLAZAMIENTO
        INT     21h
        JC      errorPunteroArchivo 
        ;JMP     leerM
ENDM
;ESTA MACRO ESCRIBE EN EL ARCHIVO EL NUEVO TEXTO QUE ESTE EN TEXTOARCHIVO
escribirArchivo MACRO 
       ;ABRE ARCHIVO EN MODO ESCRITURA
       MOV      AX,3D01h
       MOV      DX, offset path                ;----------------------path
       INT      21h
       JC       errorEscribriArchivo
       MOV      BX,AX 
       ;POSICIONA EL PUNTERO EN EL BYTE A ESCRIBIR   
       posicionarPuntero       
       
       ;ESCRIBE EN EL ARCHIVO EL VALOR DE TEXTOARCHIVO
       MOV      AX,BX
       MOV      DX,offset textoArchivo
       MOV      CX,1 
       MOV      AH,40h
       INT      21h
       JC       errorEscribriArchivo
       CMP      AX,CX
       JNE      errorEscribriArchivo
       ;CIERRA EL ARCHIVO QUE FUE ABIERTO
       MOV      AH,3eh
       INT      21h
       INC      SI     
ENDM

cerrarArchivo MACRO  
    MOV     AH,3eh
    MOV     BX,handler
    INT     21h
ENDM 
;MACROS QUE SON DE LA OPCION 10 

getTime MACRO handlerR  

    ;CON ESTE CODIGO RECUPERAMOS EL DIA DEL SISTEMA    
    MOV     AH,2Ah
    INT     21h
    XOR     SI,SI
    XOR     AX,AX
    MOV     AL,DL              ;LO DIVIDIMOS ENTRE 10, NOS IMPORTA EL RESTO DE LA DIVISIOIN
    MOV     BL,0Ah
    DIV     BL 
    XOR     CX,CX
    MOV     CL,AH
    PUSH    CX
    CMP     AL,00h
    JE      resultadoDia2
    JMP     dividirDia
    
    dividirDia:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirDia 
    resultadoDia:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoDia
    resultadoDia2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
    
    escribirArchivoPivote separadorFecha,1,handlerR
    ;CON ESTE CODIGO RECUPERAMOS EL MES DEL SISTEMA    
    MOV     AH,2Ah
    INT     21h
    XOR     SI,SI
    XOR     AX,AX
    MOV     AL,DH              ;LO DIVIDIMOS ENTRE 10, NOS IMPORTA EL RESTO DE LA DIVISIOIN
    MOV     BL,0Ah
    DIV     BL 
    XOR     CX,CX
    MOV     CL,AH
    PUSH    CX
    CMP     AL,00h
    JE      resultadoMes2
    JMP     dividirMes
    
    dividirMes:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirMes 
    resultadoMes:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoMes
    resultadoMes2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR             
            
    escribirArchivoPivote separadorFecha,1,handlerR
    ;LLAMAMOS LA INTERUPCION 2AH PARA RECUPERAR EL ANIO DEL SISTEMA
    MOV     AH,2Ah
    INT     21h
    XOR     SI,SI
    MOV     AX,CX              ;LO DIVIDIMOS ENTRE 10, NOS IMPORTA EL RESTO DE LA DIVISIOIN
    MOV     BL,0Ah
    DIV     BL 
    XOR     CX,CX
    MOV     CL,AH 
    PUSH    CX
    JMP     dividirAnio

    dividirAnio:   
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirAnio
    resultadoAnio:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoAnio
        
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        
     
     escribirArchivoPivote espacio,2,handlerR   
     ;RECUPERAMOS LA HORA DEL SISTEMA
     MOV    AH,2Ch
     INT    21h
     XOR    SI,SI
     XOR    AX,AX
     MOV    AL,CH
     MOV    BL,0Ah
     DIV    BL
     XOR     CX,CX
     MOV     CL,AH
     PUSH    CX
     CMP     AL,00h
     JE      resultadoHora2
     JMP     dividirHora
     
     dividirHora:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirHora
    resultadoHora:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoHora
    resultadoHora2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
    
    escribirArchivoPivote separadorHora,1,handlerR    
    ;RECUPERAMOS LOS MINUTOS
     MOV    AH,2Ch
     INT    21h
     XOR    SI,SI
     XOR    AX,AX
     MOV    AL,CL
     MOV    BL,0Ah
     DIV    BL
     XOR     CX,CX
     MOV     CL,AH
     PUSH    CX
     CMP     AL,00h
     JE      resultadoMinutos2
     JMP     dividirMinutos
     
     dividirMinutos:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirMinutos
    resultadoMinutos:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoMinutos
    resultadoMinutos2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        
     
     
ENDM  
    
;//////////////////////////INICIO TIME 2
getTime2 MACRO handlerR  

    ;CON ESTE CODIGO RECUPERAMOS EL DIA DEL SISTEMA    
    MOV     AH,2Ah
    INT     21h
    XOR     SI,SI
    XOR     AX,AX
    MOV     AL,DL              ;LO DIVIDIMOS ENTRE 10, NOS IMPORTA EL RESTO DE LA DIVISIOIN
    MOV     BL,0Ah
    DIV     BL 
    XOR     CX,CX
    MOV     CL,AH
    PUSH    CX
    CMP     AL,00h
    JE      resultadoDia22
    JMP     dividirDia2
    
    dividirDia2:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirDia2 
    resultadoDia32:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoDia32
    resultadoDia22:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
    
    escribirArchivoPivote separadorFecha,1,handlerR
    ;CON ESTE CODIGO RECUPERAMOS EL MES DEL SISTEMA    
    MOV     AH,2Ah
    INT     21h
    XOR     SI,SI
    XOR     AX,AX
    MOV     AL,DH              ;LO DIVIDIMOS ENTRE 10, NOS IMPORTA EL RESTO DE LA DIVISIOIN
    MOV     BL,0Ah
    DIV     BL 
    XOR     CX,CX
    MOV     CL,AH
    PUSH    CX
    CMP     AL,00h
    JE      resultadoMes22
    JMP     dividirMes2
    
    dividirMes2:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirMes2            ;dividirMes
    resultadoMes32:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoMes32
    resultadoMes22:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR             
            
    escribirArchivoPivote separadorFecha,1,handlerR
    ;LLAMAMOS LA INTERUPCION 2AH PARA RECUPERAR EL ANIO DEL SISTEMA
    MOV     AH,2Ah
    INT     21h
    XOR     SI,SI
    MOV     AX,CX              ;LO DIVIDIMOS ENTRE 10, NOS IMPORTA EL RESTO DE LA DIVISIOIN
    MOV     BL,0Ah
    DIV     BL 
    XOR     CX,CX
    MOV     CL,AH 
    PUSH    CX
    JMP     dividirAnio2

    dividirAnio2:   
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirAnio2
    resultadoAnio32:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoAnio32
        
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        
     
     escribirArchivoPivote espacio,2,handlerR   
     ;RECUPERAMOS LA HORA DEL SISTEMA
     MOV    AH,2Ch
     INT    21h
     XOR    SI,SI
     XOR    AX,AX
     MOV    AL,CH
     MOV    BL,0Ah
     DIV    BL
     XOR     CX,CX
     MOV     CL,AH
     PUSH    CX
     CMP     AL,00h
     JE      resultadoHora22
     JMP     dividirHora2
     
     dividirHora2:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirHora2    ;dividirHora
    resultadoHora32:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoHora32
    resultadoHora22:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
    
    escribirArchivoPivote separadorHora,1,handlerR    
    ;RECUPERAMOS LOS MINUTOS
     MOV    AH,2Ch
     INT    21h
     XOR    SI,SI
     XOR    AX,AX
     MOV    AL,CL
     MOV    BL,0Ah
     DIV    BL
     XOR     CX,CX
     MOV     CL,AH
     PUSH    CX
     CMP     AL,00h
     JE      resultadoMinutos22
     JMP     dividirMinutos2
     
     dividirMinutos2:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirMinutos2  ;dividirMinutos
    resultadoMinutos32:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI                                              
        CMP     SI,00h
        JA      resultadoMinutos32
    resultadoMinutos22:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
     
ENDM
;//////////////////////////FIN TIME 2


;////////////////////////////////////INICIO TIME 3 
getTime3 MACRO handlerR  

    ;CON ESTE CODIGO RECUPERAMOS EL DIA DEL SISTEMA    
    MOV     AH,2Ah
    INT     21h
    XOR     SI,SI
    XOR     AX,AX
    MOV     AL,DL              ;LO DIVIDIMOS ENTRE 10, NOS IMPORTA EL RESTO DE LA DIVISIOIN
    MOV     BL,0Ah
    DIV     BL 
    XOR     CX,CX
    MOV     CL,AH
    PUSH    CX
    CMP     AL,00h
    JE      resultadoDiaT2
    JMP     dividirDiaT
    
    dividirDiaT:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirDiaT 
    resultadoDia3T:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoDia3T
    resultadoDiaT2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
    
    escribirArchivoPivote separadorFecha,1,handlerR
    ;CON ESTE CODIGO RECUPERAMOS EL MES DEL SISTEMA    
    MOV     AH,2Ah
    INT     21h
    XOR     SI,SI
    XOR     AX,AX
    MOV     AL,DH              ;LO DIVIDIMOS ENTRE 10, NOS IMPORTA EL RESTO DE LA DIVISIOIN
    MOV     BL,0Ah
    DIV     BL 
    XOR     CX,CX
    MOV     CL,AH
    PUSH    CX
    CMP     AL,00h
    JE      resultadoMesT2
    JMP     dividirMesT
    
    dividirMesT:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirMesT 
    resultadoMes3T:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoMes3T
    resultadoMesT2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR             
            
    escribirArchivoPivote separadorFecha,1,handlerR
    ;LLAMAMOS LA INTERUPCION 2AH PARA RECUPERAR EL ANIO DEL SISTEMA
    MOV     AH,2Ah
    INT     21h
    XOR     SI,SI
    MOV     AX,CX              ;LO DIVIDIMOS ENTRE 10, NOS IMPORTA EL RESTO DE LA DIVISIOIN
    MOV     BL,0Ah
    DIV     BL 
    XOR     CX,CX
    MOV     CL,AH 
    PUSH    CX
    JMP     dividirAnioT

    dividirAnioT:   
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirAnioT
    resultadoAnio3T:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoAnio3T
        
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        
     
     escribirArchivoPivote espacio,2,handlerR   
     ;RECUPERAMOS LA HORA DEL SISTEMA
     MOV    AH,2Ch
     INT    21h
     XOR    SI,SI
     XOR    AX,AX
     MOV    AL,CH
     MOV    BL,0Ah
     DIV    BL
     XOR     CX,CX
     MOV     CL,AH
     PUSH    CX
     CMP     AL,00h
     JE      resultadoHoraT2
     JMP     dividirHoraT
     
     dividirHoraT:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirHoraT
    resultadoHora3T:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoHora3T
    resultadoHoraT2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
    
    escribirArchivoPivote separadorHora,1,handlerR    
    ;RECUPERAMOS LOS MINUTOS
     MOV    AH,2Ch
     INT    21h
     XOR    SI,SI
     XOR    AX,AX
     MOV    AL,CL
     MOV    BL,0Ah
     DIV    BL
     XOR     CX,CX
     MOV     CL,AH
     PUSH    CX
     CMP     AL,00h
     JE      resultadoMinutosT2
     JMP     dividirMinutosT
     
     dividirMinutosT:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirMinutosT
    resultadoMinutos3T:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI                                              
        CMP     SI,00h
        JA      resultadoMinutos3T
    resultadoMinutosT2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
     
ENDM
;////////////////////////////////////////FIN TIME 3 



;//////////////////////////////////////INICIO TIME 4
getTime4 MACRO handlerR  

    ;CON ESTE CODIGO RECUPERAMOS EL DIA DEL SISTEMA    
    MOV     AH,2Ah
    INT     21h
    XOR     SI,SI
    XOR     AX,AX
    MOV     AL,DL              ;LO DIVIDIMOS ENTRE 10, NOS IMPORTA EL RESTO DE LA DIVISIOIN
    MOV     BL,0Ah
    DIV     BL 
    XOR     CX,CX
    MOV     CL,AH
    PUSH    CX
    CMP     AL,00h
    JE      resultadoDiaD2
    JMP     dividirDiaD
    
    dividirDiaD:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirDiaD 
    resultadoDia3D:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoDia3D
    resultadoDiaD2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
    
    escribirArchivoPivote separadorFecha,1,handlerR
    ;CON ESTE CODIGO RECUPERAMOS EL MES DEL SISTEMA    
    MOV     AH,2Ah
    INT     21h
    XOR     SI,SI
    XOR     AX,AX
    MOV     AL,DH              ;LO DIVIDIMOS ENTRE 10, NOS IMPORTA EL RESTO DE LA DIVISIOIN
    MOV     BL,0Ah
    DIV     BL 
    XOR     CX,CX
    MOV     CL,AH
    PUSH    CX
    CMP     AL,00h
    JE      resultadoMesD2
    JMP     dividirMesD
    
    dividirMesD:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirMesD 
    resultadoMes3D:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoMes3D
    resultadoMesD2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR             
            
    escribirArchivoPivote separadorFecha,1,handlerR
    ;LLAMAMOS LA INTERUPCION 2AH PARA RECUPERAR EL ANIO DEL SISTEMA
    MOV     AH,2Ah
    INT     21h
    XOR     SI,SI
    MOV     AX,CX              ;LO DIVIDIMOS ENTRE 10, NOS IMPORTA EL RESTO DE LA DIVISIOIN
    MOV     BL,0Ah
    DIV     BL 
    XOR     CX,CX
    MOV     CL,AH 
    PUSH    CX
    JMP     dividirAnioD

    dividirAnioD:   
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirAnioD
    resultadoAnio3D:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoAnio3D
        
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        
     
     escribirArchivoPivote espacio,2,handlerR   
     ;RECUPERAMOS LA HORA DEL SISTEMA
     MOV    AH,2Ch
     INT    21h
     XOR    SI,SI
     XOR    AX,AX
     MOV    AL,CH
     MOV    BL,0Ah
     DIV    BL
     XOR     CX,CX
     MOV     CL,AH
     PUSH    CX
     CMP     AL,00h
     JE      resultadoHoraD2
     JMP     dividirHoraD
     
     dividirHoraD:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirHoraD
    resultadoHora3D:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoHora3D
    resultadoHoraD2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
    
    escribirArchivoPivote separadorHora,1,handlerR    
    ;RECUPERAMOS LOS MINUTOS
     MOV    AH,2Ch
     INT    21h
     XOR    SI,SI
     XOR    AX,AX
     MOV    AL,CL
     MOV    BL,0Ah
     DIV    BL
     XOR     CX,CX
     MOV     CL,AH
     PUSH    CX
     CMP     AL,00h
     JE      resultadoMinutosD2
     JMP     dividirMinutosD
     
     dividirMinutosD:
        INC     SI
        XOR     BX,BX 
        MOV     BL,AL
        XOR     AX,AX
        MOV     AX,BX
        MOV     BL,0Ah
        DIV     BL  
        XOR     CX,CX
        MOV     CL,AH
        PUSH    CX
        CMP     AL,00h
        JA      dividirMinutosD
    resultadoMinutos3D:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
        DEC     SI                                              
        CMP     SI,00h
        JA      resultadoMinutos3D
    resultadoMinutosD2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
        imprimir saltoLinea
        imprimir diaSistema
        escribirArchivoPivote diaSistema,1,handlerR
     
ENDM
;//////////////////////////////////////FIN TIME 4   
    
crearArchivoPivote MACRO pArchivo,hArchivo
        MOV     AH,3Ch
        MOV     CX,0
        MOV     DX,offset pArchivo
        INT     21h
        JC      errorCrearArchivo   
        MOV     hArchivo,AX
ENDM

escribirArchivoPivote MACRO texto,cant,hArc
        MOV     AH, 40h
        MOV     BX, hArc
        MOV     CX, cant
        MOV     DX, offset texto 
        INT     21h
        JC      errorEscribirArchivoPivote  
ENDM 

cerrarArchivoPivote MACRO hArc2
        MOV     AH,3Eh
        MOV     BX,hArc2
        INT     21h
ENDM 

abrirArchivoPivote MACRO modo,pArchivo2,hAr4
       ;ABRE ARCHIVO EN MODO ESCRITURA
       MOV      AX,modo
       MOV      DX, offset pArchivo2                
       INT      21h
       JC       errorAbrirArchivo
       MOV      hAr4,AX
ENDM

leerArchivoPivote MACRO hArc5
  leerArcP:
    MOV     AH,3fh
    MOV     BX,hArc5
    XOR     DX,DX
    MOV     dx,offset textoPivote
    MOV     CX, 1
    INT     21h
    JC      errorLeerArchivo 
    CMP     AX,0
    JZ      continuacionAP
    ;/////////////////////////////ESCRIBIENDO EN EL REPORTE///////////////////////////
    escribirArchivoPivote textoPivote,1,hanlderArcRF
    ;/////////////////////////////////////////////////////////////////////////////////////////
    JMP     leerArcP
   
  continuacionAP:
   
ENDM


    .startup   
     ;MOV    AL,0fh
     ;MOV    AH,00
     ;INT    10h
     
     ;IMPRIMIENDO EL ENCABEZADO HASTA LLEGAR AL MENU
     crearArchivoPivote pathArcP,handlerArcP
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
              MOV   SI,0700h
              MOV   ES,SI
              XOR   SI,SI
              limpiarPalabraBuscar              ;SIEMPRE CUANDO SE MUESTRA EL MENU SE LIMPIA BUSCAR Y REMMPLAZAR PALABRA
              limpiarPalabraReemplazar
                     
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
        ;COMPARACION DE LA OPCION 6
        CMP     AL, num6
        JZ      opcion6
        ;COMPARACION DE LA OPCION 7
        CMP     AL, num7
        JZ      opcion7
        ;COMPARACION DE LA OPCION 8
        CMP     AL, num8
        JZ      opcion8
        ;COMPARACION DE LA OPCION 9
        CMP     AL, num9
        JZ      opcion9  
        
        JMP numeroIncorrecto
     
     decenasUno: 
        MOV     AL,unidades
        ;COMPARACION DE LA OPCION 0, UNIDADES 1, OPCION 10
        CMP     AL,num0
        JZ      opcion10
        ;COMPARACION DE LA OPCION 1, UNIDADES 1, OPCION 11
        CMP     AL,num1
        JZ      opcion11        
        
        JMP numeroIncorrecto 
        
     ;ETIQUETAS PARA ERRORES
     numeroIncorrecto:
        imprimir error1
        JMP imprimirMenu 
     
     errorAbrirArchivo:
        imprimir error2
        JMP imprimirMenu 
    
     errorLeerArchivo:
        imprimir error3
        JMP imprimirMenu 
                 
     errorPunteroArchivo:
        imprimir error4
        JMP imprimirMenu 
        
     errorEscribriArchivo:
        imprimir error5
        JMP leerM       
        
     errorCrearArchivo:
        imprimir error6
        JMP imprimirMenu 
        
     errorEscribirArchivoPivote:
        imprimir error7
        JMP imprimirMenu
        
     ;PARA LA VALIDACION DE LAS OPCIONES
     opcion1:      
        imprimir saltoLinea  
        imprimir msgPath
        ;imprimir text1
        MOV     AH,1
        XOR     SI,SI                               ;LIMPIAMOS EL REGISTRO SI 
        
        capturarCadena 
        
        mostrarPath:  
           imprimir saltoLinea
           abrirArchivo 
           imprimir saltoLinea  
           leerArchivo
             
           cerrarA:
               cerrarArchivo 
               imprimir saltoLinea
               JMP imprimirMenu
        
     opcion2:
        imprimir saltoLinea
        abrirArchivo 
        XOR     SI,SI
        leerArchivoMayuscula
        
        ;ETIQUETAS PARA HACER LAS TRANSFORMACION 
        verificacion2:
            CMP     DH,7bh
            JB      convMayuscula                ;SALTAMOS UNICAMENTE SI ES MENOR 7B POR LO TANTO ES UNA LETRA MINUSCULA
            imprimir textoArchivo                ;EN CASO IMPRMIMOS SU VALOR ACTUAL 
            ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
            escribirArchivoPivote textoArchivo,1,handlerArcP
            ;//////////////////////////////////////////////////////////////////////////////
            escribirArchivo
            JMP     leerM                        ;Y REGRESAMOS A LEER Y ENCONTRAR MAS LETRAS MINUSCULAS
            
        convMayuscula:
            SUB     DH,20h                       ;LE RESTAMOS 20H PARA PASARLO A MAYUSCULA
            MOV     textoArchivo,DH              ;LE COLOCAMOS A LA VARIABLE EL NUEVO VALOR
            ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
            escribirArchivoPivote textoArchivo,1,handlerArcP
            ;//////////////////////////////////////////////////////////////////////////////
            escribirArchivo
            imprimir textoArchivo                ;LO IMPRIMO
            JMP     leerM                        ;REGRESAMOS A LEER Y ENCONTRAR MAS MINUSCULAS
         
        JMP imprimirMenu
        
     opcion3: 
        imprimir saltoLinea 
        abrirArchivo
        XOR     SI,SI                           ;LIMPIAMOS EL REGISTRO SI
        leerArchivoMinuscula                    ;VAMOS AL PROCEDIMIENTO LEERARCHIVOMINUSCULA
        
        
        verificacion2Minuscula:
            CMP     DH,5bh                      ;VERICAMOS QUE SEA MENOR A 5HB
            JB      convMinuscula               ;SI ES MENOR SALTAMOS A CONVERTIR MINUSCULA YA QUE ES MAYUSCULA
            
            imprimir textoArchivo               ;EN CASO CONTRARIO IMPRIMIMOS EN PANTALLA
            ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
            escribirArchivoPivote textoArchivo,1,handlerArcP
            ;//////////////////////////////////////////////////////////////////////////////
            escribirArchivo                     ;Y ESCRIBIMOS EN EL ARCHIVO EL NUEVO VALOR
            JMP     leerMinus                   ;REGRESAMOS A SEGUIR LEYENDO MAS LETRAS MAYUSCULAS
        
        convMinuscula:
            ADD     DH,20h                      ;SI ENTRA A ESTA ETIQUETA SE LE SUMA 20H
            MOV     textoArchivo,DH             ;LE ASIGNAMOS EL REGISTRO AL VALOR DE TEXTOARCHIVO
            
            imprimir textoArchivo               ;IMPRIMIMOS EN PANTALLA
            ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
            escribirArchivoPivote textoArchivo,1,handlerArcP
            ;//////////////////////////////////////////////////////////////////////////////
            escribirArchivo                     ;Y LO GUARDAMOS EN EL ARCHIVO
            JMP     leerMinus                   ;REGRESAMOS A SEGUIR LEYENDO MAYUSCULA
        
        JMP     imprimirMenu 
     
     opcion4:
        imprimir saltoLinea
        abrirArchivo 
        XOR     SI,SI                       ;CONTADOR SEEK_SET ARCHIVO
        XOR     DI,DI                       ;CONTADOR PARA SABER SI LA LETRA ES CAPITAL
        leerArchivoCapital
        
        
        verificacionCapital:                ;VERIFICA QUE LA LETRA SEA MINUSCULA SI ES ASI
            CMP     DH,7bh                  ;PASAMOS A VERIFICAR SU POSICION PARA AVERIGUAR SI ES CAPITAL
            JB      convCapital
            
            imprimir textoArchivo 
            ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
            escribirArchivoPivote textoArchivo,1,handlerArcP
            ;//////////////////////////////////////////////////////////////////////////////
            escribirArchivo
            INC     DI
            JMP     leerCapi
        
        convCapital:
            CMP     DI,0                    ;SI EL CONTADOR ES 0 SIGNIFICA QUE ES LA PRIMERA PALABRA
            JE      convCapital2            ;SALTAMOS A CONVERTIRLA A MAYUSCULA EN CASO CONTRARIO NO ES 
                                            ;LA PRIMERA POR LO TANTO SOLO LA MOSTRAMOS GUARDAMOS EN ARCHIVO
            imprimir textoArchivo           ;Y REGRESAMOS A COLOCARLO EN EL ARCHIVO
            ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
            escribirArchivoPivote textoArchivo,1,handlerArcP
            ;//////////////////////////////////////////////////////////////////////////////
            escribirArchivo
            INC     DI
            JMP     leerCapi 
            
        convCapital2:
            SUB     DH,20h
            MOV     textoArchivo,DH
            
            imprimir textoArchivo  
            ;///////////////////////////////ESCRIBIENDO EN ARCHIVO PIVOTE////////////////////
            escribirArchivoPivote textoArchivo,1,handlerArcP
            ;//////////////////////////////////////////////////////////////////////////////
            escribirArchivo
            INC     DI
            JMP     leerCapi
        
        
        JMP imprimirMenu
     
     opcion5:
        imprimir saltoLinea 
        imprimir msgPalBuscar
        
        XOR     SI,SI
        MOV     AH,1
        
        capturaPalabraBuscar
        
        mostPalBuscar: 
            imprimir saltoLinea
            imprimir PalabraBuscar
            imprimir saltoLinea                  
            imprimir msgPalRem 
            XOR     SI,SI
            MOV     AH,1
            
            capturaPalabraReemplazar
            
                               
        mostPalReemplazar:
            imprimir saltoLinea
            imprimir PalabraReemplaza
            imprimir saltoLinea
            imprimir PalabraBuscar 
            imprimir saltoLinea
            ;HASTA ESTE PUNTO YA OBTUVIMOS LA PALABRA A BUSCAR Y LA PALABRA A REEMPLAZAR   
            abrirarchivo
            XOR     SI,SI
            XOR     DI,SI 
            
            leerArchivoBuscarReemplazar
              
                                  
        ;limpiarPalabraBuscar
        ;limpiarPalabraReemplazar
        JMP imprimirMenu
     
     
     opcion6: 
        imprimir saltoLinea
        abrirarchivo
        XOR     SI,SI
        XOR     DI,DI
        
        leerArchivoInvertirPalabra
        
        
        JMP imprimirMenu
     
     opcion7: 
        imprimir saltoLinea
        imprimir text7  
        abrirarchivo
        XOR SI,SI
        XOR DI,DI
        
        ;handlerArcRD
        
        
            crearArchivoPivote pathArcRD, handlerArcRD 
           ;5555 
            escribirArchivoPivote htmlAbierto,8,handlerArcRD                
            escribirArchivoPivote headAbierto,8,handlerArcRD
            escribirArchivoPivote titleAbiertoRF,32,handlerArcRD
           
            escribirArchivoPivote corcheteAbierto,1,handlerArcRD 
            
            ;getTime2 handlerArcRH
            getTime4 handlerArcRD
            
            escribirArchivoPivote corcheteCerrado,1,handlerArcRD 
            
            escribirArchivoPivote saltoHtml,5,handlerArcRD
            escribirArchivoPivote DatoNombre,16,handlerArcRD
            escribirArchivoPivote DatoCarnet,11,handlerArcRD 
            
            escribirArchivoPivote saltoHtml,5,handlerArcRD
            ;APLICANDO EL STYLE
            escribirArchivoPivote styleAbierto,9,handlerArcRD
            
            escribirArchivoPivote stilo1,16,handlerArcRD 
            
            escribirArchivoPivote stilo2,26,handlerArcRD 
            
            escribirArchivoPivote stilo3,3,handlerArcRD 
            
            escribirArchivoPivote styleCerrado,10,handlerArcRD
            
            escribirArchivoPivote saltoHtml,5,handlerArcRD 
             
            escribirArchivoPivote headCerrado,9,handlerArcRD
             
            escribirArchivoPivote bodyAbierto,8,handlerArcRD 
            
            ;aqui se llama el texto a escribir 
            
            escribirArchivoPivote tableAbierto,28,handlerArcRD
            
            ;leerArchivoHiato 
            leerArchivoDiptongo
            
            continuacionArchivoFinalRD: 
            
                escribirArchivoPivote tableCerrado,10,handlerArcRD
                
                escribirArchivoPivote bodyCerrado,9,handlerArcRD
                escribirArchivoPivote htmlCerrado,9,handlerArcRD
                
                cerrarArchivoPivote handlerArcRD 
                
                JMP cerrarA
                
        ;leerArchivoDiptongo
        
        
        JMP imprimirMenu
     
     opcion8:
        imprimir saltoLinea 
        abrirarchivo
        XOR     SI,SI
        XOR     DI,DI
        ;handlerArcRH   
        ;pathArcRH 
        
        crearArchivoPivote pathArcRH, handlerArcRH 
       ;5555 
        escribirArchivoPivote htmlAbierto,8,handlerArcRH                
        escribirArchivoPivote headAbierto,8,handlerArcRH
        escribirArchivoPivote titleAbiertoRF,32,handlerArcRH
       
        escribirArchivoPivote corcheteAbierto,1,handlerArcRH 
        
        getTime2 handlerArcRH
        
        escribirArchivoPivote corcheteCerrado,1,handlerArcRH 
        
        escribirArchivoPivote saltoHtml,5,handlerArcRH
        escribirArchivoPivote DatoNombre,16,handlerArcRH
        escribirArchivoPivote DatoCarnet,11,handlerArcRH 
        
        escribirArchivoPivote saltoHtml,5,handlerArcRH
        ;APLICANDO EL STYLE
        escribirArchivoPivote styleAbierto,9,handlerArcRH
        
        escribirArchivoPivote stilo1,16,handlerArcRH 
        
        escribirArchivoPivote stilo2,26,handlerArcRH 
        
        escribirArchivoPivote stilo3,3,handlerArcRH 
        
        escribirArchivoPivote styleCerrado,10,handlerArcRH
        
        escribirArchivoPivote saltoHtml,5,handlerArcRH 
         
        escribirArchivoPivote headCerrado,9,handlerArcRH
         
        escribirArchivoPivote bodyAbierto,8,handlerArcRH 
        
        ;aqui se llama el texto a escribir 
        
        escribirArchivoPivote tableAbierto,28,handlerArcRH
        
        leerArchivoHiato
        
        continuacionArchivoFinalRH: 
        
            escribirArchivoPivote tableCerrado,10,handlerArcRH
            
            escribirArchivoPivote bodyCerrado,9,handlerArcRH
            escribirArchivoPivote htmlCerrado,9,handlerArcRH
            
            cerrarArchivoPivote handlerArcRH 
            
            JMP cerrarA
        
        JMP imprimirMenu
     
     opcion9: 
        imprimir saltoLinea
        imprimir text9
        abrirArchivo
        XOR     SI,SI
        XOR     DI,DI
        ;handlerArcRT
        
        
        crearArchivoPivote pathArcRT, handlerArcRT 
       ;5555 
        escribirArchivoPivote htmlAbierto,8,handlerArcRT                
        escribirArchivoPivote headAbierto,8,handlerArcRT
        escribirArchivoPivote titleAbiertoRF,32,handlerArcRT
       
        escribirArchivoPivote corcheteAbierto,1,handlerArcRT 
        
        ;getTime2 handlerArcRH
        getTime3  handlerArcRT
        
        escribirArchivoPivote corcheteCerrado,1,handlerArcRT 
        
        escribirArchivoPivote saltoHtml,5,handlerArcRT
        escribirArchivoPivote DatoNombre,16,handlerArcRT
        escribirArchivoPivote DatoCarnet,11,handlerArcRT 
        
        escribirArchivoPivote saltoHtml,5,handlerArcRT
        ;APLICANDO EL STYLE
        escribirArchivoPivote styleAbierto,9,handlerArcRT
        
        escribirArchivoPivote stilo1,16,handlerArcRT 
        
        escribirArchivoPivote stilo2,26,handlerArcRT 
        
        escribirArchivoPivote stilo3,3,handlerArcRT 
        
        escribirArchivoPivote styleCerrado,10,handlerArcRT
        
        escribirArchivoPivote saltoHtml,5,handlerArcRT 
         
        escribirArchivoPivote headCerrado,9,handlerArcRT
         
        escribirArchivoPivote bodyAbierto,8,handlerArcRT 
        
        ;aqui se llama el texto a escribir 
        
        escribirArchivoPivote tableAbierto,28,handlerArcRT
        
        ;leerArchivoHiato
        leerArchivoTriptongo
        
        continuacionArchivoFinalRT: 
        
            escribirArchivoPivote tableCerrado,10,handlerArcRT
            
            escribirArchivoPivote bodyCerrado,9,handlerArcRT
            escribirArchivoPivote htmlCerrado,9,handlerArcRT
            
            cerrarArchivoPivote handlerArcRT 
            
            JMP cerrarA
            
        
        JMP imprimirMenu
     
     opcion10: 
        imprimir saltoLinea       
        imprimir text10
        XOR     SI,SI
        XOR     DI,DI 
        
        ;CERRANDO EL ARCHIVO PIVOTE
        cerrarArchivoPivote handlerArcP
        
        ;CREANDO EL ARCHIVO DEL REPORTE FINAL
        
        crearArchivoPivote pathArcRF ,hanlderArcRF 
        
        ;ESCRIBIENDO EN EL ARCHIVO EL REPORTE FINAL 
   ;     escribirArchivoPivote htmlAbierto,8,hanlderArcRF                
   ;     escribirArchivoPivote headAbierto,8,hanlderArcRF
   ;     escribirArchivoPivote titleAbiertoRF,32,hanlderArcRF
       
        escribirArchivoPivote corcheteAbierto,1,hanlderArcRF 
        
        getTime hanlderArcRF
        
        escribirArchivoPivote corcheteCerrado,1,hanlderArcRF 
        
   ;     escribirArchivoPivote saltoHtml,5,hanlderArcRF
        escribirArchivoPivote DatoNombre,16,hanlderArcRF
        escribirArchivoPivote DatoCarnet,11,hanlderArcRF 
        
   ;     escribirArchivoPivote saltoHtml,5,hanlderArcRF 
        
        abrirArchivoPivote 3D00h,pathArcP,handlerArcP
        
        leerArchivoPivote handlerArcP
        
   ;     escribirArchivoPivote saltoHtml,5,hanlderArcRF
        
        cerrarArchivoPivote handlerArcP 
        
  ;      escribirArchivoPivote saltoHtml,5,hanlderArcRF 
         
  ;      escribirArchivoPivote headCerrado,9,hanlderArcRF 
  ;      escribirArchivoPivote bodyAbierto,8,hanlderArcRF
  ;      escribirArchivoPivote bodyCerrado,9,hanlderArcRF
  ;      escribirArchivoPivote htmlCerrado,9,hanlderArcRF 
        
       ;CERRAMOS EL ARCHIVO
        cerrarArchivoPivote hanlderArcRF
        
        
        ;ABRIMOS OTRA VEZ EL ARCHIVO PIVOTE EN MODO ESCRITURA
        ;abrirArchivoPivote 3D01h,pathArcP,handlerArcP
        crearArchivoPivote pathArcP,handlerArcP
        JMP imprimirMenu
     
     opcion11:
        imprimir saltoLinea
        imprimir msgSalir 
        JMP salir  
     
      
     ;ETIQUETA SALIR
     salir:
        MOV     ax,0c07h;ah,00
        INT     21h 
      
    .exit
