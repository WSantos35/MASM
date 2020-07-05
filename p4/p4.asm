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

    ;MENSAJES PARA EL JUEGO--------------------------------------------------------------
    msgJugar db "//========== JUGAR =========",10,13,"$"
    msgNombre db ">>NOMBRE:",10,13,"$"   
    msgRandom db ">>RANDOM? Y/N",10,13,"$"    
    msgIUsuario db 10,13,">>Ingrese el # Operacion:",10,13,"$"       
    msg_salida db 10,13,">>","$"         
    msg_pregunta db "?",10,13,"$"     
    resp_correcta db ">>CORRECTO!+","$"    
    resp_incorrecta db ">>INCORRECTO!+0",10,13,">>RESPUESTA=","$"  
    FECHA db "FECHA: ","$"
    HORA db "HORA: ","$"
    separador_Fecha db "/","$"     
    separador_hora db ":","$"     
    cant_nombre dw 0,"$" 
    pos_punt dw 245,"$"
    ;------------------------------------------------------------------------------------  
    saltoLinea db 10,13,"$"   
    textoArchivo db 2 dup("$")
     
    ;PARA OBTENER PATH, Y HANDLER--------------------------------------------------------- 
   ; path2 db "entrada.txt",0,"$" 
    path_ArchivoCarga db "C:\entrada.txt",0,"$"  ;PARA ASSEMBLER C:\entrada.txt    solo entrada va a ser minuscula el resto de archivo creados 
    path_ArchivoSintactico db "C:\A_SIN.txt",0,"$";de assembler tienen que ser mayusculas C:\A_SIN.txt   
    path_Err_AS db "C:\E_SIN.txt",0,"$"           ;C:\E_SIN.txt
    path_Err_AL db "C:\E_LEX.txt",0,"$"           ;C:\E_LEX.txt
    path_Operaciones db "C:\OP.txt",0,"$" 
    path_punteo db "C:\TOP.txt",0,"$"
    handler_ArchivoCarga dw ? 
    handler_ArchivoSintactico dw ?   
    handler_E_AS dw ?   
    handler_E_AL dw ? 
    handler_Operaciones dw ?  
    handler_punteo dw ?

 
    
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
    errorPuntero db 10,13,"=== ERROR AL POSICIONAR PUNTERO ===",10,13,"$"
    errorLEX db 10, 13,"%%%%% ERROR LEXICO %%%%%",10,13,"Caracter no esperado: ","$"
    errorSINT db 10,13,"%%%%% ERROR SINTACTICO %%%%",10,13,"$" 
    errorAnalisis db "OCURRIERON ERRORES EN EL ANALISIS",10,13,"$"
    errorEntradaRandom db 10,13,"== NO SE RECONOCE EL VALOR INGRESADO ==",10,13,"$"
    errorNumeroIngresado db 10,13,"=== LA OPERACION NO EXISTE ===",10,13,"$"
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
    comparar_arqui db "arqui","$"
    comparar_operacion db "Operacion","$"  
    cantidad_operaciones db 0
    operacion_seleccionada db 0   
    cantidad_operadores db 0 
    valor_operacion db 0 
   ; tmp_numero_AL db 0
   ; tmp_numero_AH db 0 
    tmp_numero_grande dw 00  
    texto_P_Operacion dw 00
    extra db 0,"$"
    extra16 dw 00
  ;  abierto db 0
  ;  cerrado db 1
  ;  punto_coma db 1
    palabra db 0 
      
    Estado db 0 
    IsLetter db 0   
    IsNum db 0   
    IsError db 0
    Array_iguales db 0 
    IsOperatorAritmetic db 0
    palabraVerificacion db 2 dup("$") 
    Nombre_jugador db 30 dup("$")  
    Operacion_Array db 30 dup("$")
    token_arqui db 30 dup ("$")   
    token_operacion db 30 dup("$")   
    Pivote_Operacion dw 30 dup("$$"),"$"
    Array_Precedencia dw 30 dup("$$"),"$"
    ;----------- BANDERAS PARA ARREGLO PRECEDENCIA------
    Pila_Operadores dw 30 dup("$$"),"$" 
    resultado_factorial dw 1
    cont_numeros db 0       ;contador normal para numeros
    cont_operadores db 0    ;contador normal operadores 
    V_op_pos0 db 0           ;va a contener el indice op_mayor
    V_op_pos1 db 0        ;va a contener el indice op_menor   
    b_is_menor db 0       ;1 activada bandera, 0 sin activar  
    b_is_menor_factorial db 0       ; 1 activada, 0 desactivada
   ; b_is_mayor db 0         ;1 es mayor, 0 sin usar
   ; b_is_menor db 0         ;1 es menor, 0 sin usar
   ; b_is_igual db 0         ;1 es igual, 0 sin usar 
    tmp_AX dw 00 
    tmp_AL db 0 
    tmp_BX dw 00
    tmp_CX dw 00 
    tmp_SI dw 00   
    tmp_DX dw 00
    var_num1 dw 00
    var_num2 dw 00
    var_resultado dw 00,"$"
    resultado_usario dw 00    
    puntos_acumulados dw 00   
    diaSistema db 0,"$"
    ;---------------------------------------------------   
    ;--------------------PARA EL ARBOL-----------------
    arbol dw 30 dup(00),"$$"  
    cont_Arch db 0,"$"
    path_arbol db "C:\ARB#.dot",0,"$"
    handler_arbol dw ?
    if_colocado db 0      
    inodo_arbol dw 00,"$"
    tmp_extra_dato dw 00,"$"    
    digraph db "digraph G{",10,13,"$" 
    cierredigraph db "}",10,13,"$"
    enlazador db "->","$"    
    label_abierto db "[label=",22h,"$"
    label_cerrado db 22h,"]",10,13,"$"
    label_etiqueta db "label","$" 
    num_etiqueta dw 00,"$"
    ;---------------------------------------------------
    
    
.code   

    INCLUDE macros.asm


;MACROS QUE SON DE LA OPCION 10 

     
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
      
      errorAbrirArchivo:
            imprimir errorAperturaArchivo
            JMP imprimirMenu
            
      errorLeerArchivo:
            imprimir errorLecturaArchivo
            JMP imprimirMenu          
            
      errorCrearArchivo:
            imprimir errorCreacionArchivo
            JMP imprimirMenu    
      errorEscribirArchivoPivote:
            imprimir errorEscrituraArchivo
            JMP imprimirMenu   
      ERROR_ANALISIS:
            imprimir errorAnalisis
            JMP imprimirMenu 
      error_numeroIngresado:
            imprimir errorNumeroIngresado
            JMP imprimirMenu
        
     ;PARA LA VALIDACION DE LAS OPCIONES----------------------------------------------------------------
     opcion1:      
        imprimir saltoLinea  
        imprimir text1
        XOR     SI,SI
        XOR     DI,DI     
        ;-------------------SE SETEA EL BOOLEANO QUE VERIFICA ERROR------------------
        MOV     [IsError],0 
        ;------------------ CREA Y ABRE EL ARCHIVO DE TOKENS LEXICOS CORRECTOS ------
        crearArchivo path_ArchivoSintactico, handler_ArchivoSintactico     
        cerrarArchivo handler_ArchivoSintactico
        abrirArchivo 3d01h, path_ArchivoSintactico, handler_ArchivoSintactico
        ;---------------------------------------------------------------------------- 
        ;------------------ CREA Y ABRE EL ARCHIVO DE ERRORES LEXICOS ---------------
        crearArchivo path_Err_AL, handler_E_AL
        cerrarArchivo handler_E_AL
        abrirArchivo 3d01h, path_Err_AL, handler_E_AL
        ;----------------------------------------------------------------------------
        ;------------------ ABRE Y LEE EL ARCHIVO DE ENTRADA PRINCIPAL --------------
        abrirArchivo 3D00h, path_ArchivoCarga,handler_ArchivoCarga
        
        leerArchivoAnalisis textoArchivo, handler_ArchivoCarga 
        ;----------------------------------------------------------------------------        
       ; imprimir text11                    
        ;----------------- ABRE Y CREA EL ARCHIVO DE ERRORES SINTACTICOS ------------
        crearArchivo path_Err_AS, handler_E_AS 
        cerrarArchivo handler_E_AS         
        abrirArchivo 3d01h, path_Err_AS, handler_E_AS        
        ;--------------INICIALIZA EL ESTADO DE AUTOMATA SINTACTICO EN ESTADO 0---    
        MOV     [Estado],0
        ;----------------------------------------------------------------------------   
        ;-----------------CREA Y ABRE EL ARCHIVO DE OPERACIONES ---------------------  
        crearArchivo path_Operaciones, handler_Operaciones
        cerrarArchivo handler_Operaciones
        abrirArchivo 3d01h, path_Operaciones,handler_Operaciones
        ;----------------------------------------------------------------------------
        ;----------------- ABRE Y LEE EL ARCHIVO DE TOKENS LEXICOS CORRECTOS --------
        abrirArchivo 3D00h, path_ArchivoSintactico,handler_ArchivoSintactico
        leerArchivoSintactico textoArchivo, handler_ArchivoSintactico      
        ;---------------------------------------------------------------------------- 
        JMP imprimirMenu
        
     opcion2:
        imprimir saltoLinea
        XOR     SI,SI
        XOR     DI,DI   
        
        CMP     [IsError],0             ;VERIFICA QUE NO HALLA OCURRIDO ERRORES EN EL ANALISIS
        JNE     ERROR_ANALISIS 
        
        imprimir msgJugar               ;IMPRIME MENSAJE JUGAR
        imprimir msgNombre              ;IMPRIME MENSAJE INGRESO NOMBRE
                     
        MOV     AH,1             
        capturarCadena Nombre_jugador   ;CAPTURA EL NOMBRE DEL JUGADOR
        ;XOR     AX,AX
        ;MOV     AX,SI
        MOV     [cant_nombre],SI
        ;----------- EN ESTA PARTE DEL CODIGO SE DEBE RECUPERAR CUANTAS OPERACIONES EXISTEN ------
        abrirArchivo 3D00h, path_Operaciones, handler_Operaciones 
            ;----------- SETEA EL CONTADOR DE OPERACIONES --------------------------------------------
        MOV     [cantidad_operaciones],0
        CantidadOperaciones textoArchivo, handler_Operaciones
        ;----------------------------------------------------------------------------------------- 
        imprimir msgRandom 
        ;----------------------VERIFICA QUE EL USUAIRO INGRE Y/N O SUS MINUSCULAS -----------
        MOV     AH,1
        INT     21h
        CMP     AL,59h              ;compara si Y
        JE      obtener_num_random
        CMP     AL,79h              ;compara si y
        JE      obtener_num_random
        CMP     AL,4Eh              ;compara si N
        JE      obtener_num_normal
        CMP     AL,6Eh              ;compara si n
        JE      obtener_num_normal    
        
        imprimir errorEntradaRandom ;este mensaje de error si no se escogio bien
        BORRAR_ARREGLO Nombre_jugador
        JMP     imprimirMenu
        ;-------------------- OPERACION RANDOM ----------------------------------------------
        obtener_num_random:         ;INGRESA AQUI PARA OBTENER NUMERO RANDOM
            imprimir text9   
            imprimir Nombre_jugador
            BORRAR_ARREGLO Nombre_jugador
            JMP     imprimirMenu
        ;-------------------- USUARIO ESCOGE OPERACION --------------------------------------
        obtener_num_normal:         ;INGRESA AQUI PARA OBTENER NUMERO ESCOGIDO POR EL USUARIO
            imprimir msgIUsuario    ;IMPRIME MENSAJE DE INGRESAR NUMERO OPERACION  
            capturarNumero operacion_seleccionada ;OBTIENE EL NUMERO INGRESADO POR EL USUARIO      
            CMP     operacion_seleccionada,0      ;COMPARA SI ES 0, NO PERMITIDO
            JE      error_numeroIngresado
            MOV     BH,[cantidad_operaciones]
            CMP     operacion_seleccionada,BH
            JBE      continuar_operacion2         ;COMPARA QUE SEA MENOR O IGUAL, VALOR PERMITIDO
            BORRAR_ARREGLO Nombre_jugador
            JMP     error_numeroIngresado         ;SI LLEGA AQUI ES MAYOR QUE CANT_OPERACIONES, NO PERMITIDO
        
        continuar_operacion2:
        imprimir saltoLinea        
        MOV     [cantidad_operaciones],0 ;REUTILIZAMOS LA VARIABLE CANTIDAD_OPERACIONES COMO CONTADOR
        INC     [cantidad_operaciones]
        ;--------------- ABRE Y LEE EL ARCHIVO PARA RECUPERAR LA OPERACION SELECCINADA-----
        abrirArchivo 3D00h, path_Operaciones,handler_Operaciones
        RecuperarOperacion textoArchivo,handler_Operaciones
        ;---------------------------------------------------------------------------------- 
        imprimir Operacion_Array 
        ;------------------SETEAMOS LA CANTIDAD OPERADORES --------------------------------
        MOV     [cantidad_operadores],0  
        ;----------LLAMA A MACRO QUE CALCULA LA CANTIDAD DE OPERADORES DE LA OPERACION----- 
        ;----------Y LUEGO DE RECUPERAR SU VALOR OBTIENE EL VALOR PARA CADA PUNTEO --------
        Obt_Cant_Operadores Operacion_Array
       ; imprimir text5
        XOR     AX,AX  
        MOV     AL,100
        MOV     BL,[cantidad_operadores]
        DIV     BL                      
        MOV     [valor_operacion],AL       ;valor operacion tiene el punteo para cada operador,operacion
        ;CMP     [valor_operacion],33        
        ;JE     ir_directo_menu
        ;----------------------------------------------------------------------------------
        ;-----PASA LOS DATOS DEL ARRAY TIPO DB A UN ARRAY DW CON SU VALOR ENTERO EXACTO---- 
        BORRAR_ARREGLO_16bits Pivote_Operacion
        Actualizar_Array_Pivote Pivote_Operacion,Operacion_Array,textoArchivo 
        ;BORRAR_ARREGLO_16bits Pivote_Operacion
        ;----------------------------------------------------------------------------------  
        ;------------DE AQUI EN ADELANTE LA MAYORIA DE  MACROS USARAN 16BITS --------------
        ;-----------MACRO QUE ORDENA OPERACIONES A CALCULAR POR PRECEDENCIA ---------------
        MOV     [IsOperatorAritmetic],0         ;SETEAMOS EL VALOR BOOLEANO A FALSE 
        Ord_Precedencia Pivote_Operacion,Array_Precedencia,texto_P_Operacion
        ;----------------------------------------------------------------------------------
        imprimir Array_Precedencia   
        ;------------ REALIZA Y MUESTRA EL CALCULO QUE HARA POR PRECEDENCIA --------------- 
        MOV     [puntos_acumulados],0000
        CALCULO_PRECEDENCIA Array_Precedencia , texto_P_Operacion
        ;----------------------------------------------------------------------------------  
       ; imprimir saltoLinea
       ; imprimir Pivote_Operacion                                                                         
       ; imprimir saltoLinea
       ; imprimir Nombre_jugador
       ; imprimir saltoLinea
       ; imprimir Array_Precedencia   
        
        ;-------------------- SE ESCRIBE EL NOMBRE DEL JUGADOR EN EL ARCHIVO CON SU PUNTEO ----------
        abrirArchivo 3D01h, path_punteo, handler_punteo
        posicionarPuntero handler_punteo,pos_punt
        escribirArchivo Nombre_jugador,cant_nombre,handler_punteo
        escribirArchivo separadorHora,1,handler_punteo 
        IMPRIMIR_NUM16BITS_V3 puntos_acumulados, handler_punteo
        escribirArchivo saltoLinea,2,handler_punteo
        cerrarArchivo handler_punteo    
        XOR     BX,BX
        ;MOV     BX,[pos_punt]
        MOV     BX,[cant_nombre]
        ADD     [pos_punt],BX
        ADD     [pos_punt],0006
        
        
        ;--------------------------------------------------------------------------------------------
       ; posicionarPuntero handler_punteo,cant_nombre
       ; XOR     AX,AX
       ; MOV     AX,SI
        
        ir_directo_menu:
            BORRAR_ARREGLO Nombre_jugador 
            BORRAR_ARREGLO Operacion_Array
            BORRAR_ARREGLO_16bits Pivote_Operacion
            BORRAR_ARREGLO_16bits Array_Precedencia    
            BORRAR_ARREGLO_16bits Pila_Operadores
            JMP imprimirMenu
        
     opcion3: 
        imprimir saltoLinea 
        ;imprimir text3 
        XOR     SI,SI
        XOR     DI,DI      
        ;--------- ACTUALIZA LA FECHA/HORA -----------
        abrirArchivo 3D01h,path_punteo,handler_punteo
        getTime handler_punteo   
        cerrarArchivo handler_punteo   
       ; posicionarPuntero handler_punteo,207
        ;--------- ABRE EL ARCHIVO DE PUNTEOS --------
        abrirArchivo 3D00h,path_punteo,handler_punteo
        ;--------------------------------------------- 
        ;-------- LEE EL ARCHIVO DE PUNTEO --------            
        LEER_MAX_PUNTEO handler_punteo,textoArchivo
        ;---------------------------------------------
        JMP     imprimirMenu 
     
     opcion4:
        imprimir saltoLinea
        imprimir text4  
        XOR     SI,SI                       
        XOR     DI,DI
        BORRAR_ARREGLO_16bits Pivote_Operacion
        ;----------------ABRE Y LEE EL ARCHIVO OPERACION---------- 
        abrirArchivo 3D00h,path_Operaciones,handler_Operaciones
        RECUPERAR_OPERACIONES  Operacion_Array, handler_Operaciones,textoArchivo 
        ;---------------------------------------------------------  
        
       ; ir_directo_menu_op4:
           BORRAR_ARREGLO Operacion_Array 
        
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