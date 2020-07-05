;MACRO QUE NOS PERMITE MANDAR A IMPRIMIR EN CONSOLA
imprimir MACRO texto   
    XOR     DX,DX
    MOV     DX, OFFSET texto    
    MOV     AH, 09h
    INT     21h
ENDM 
;CON ESTA MACRO INGRESAMOS UNA DE LAS OPCIONES ESCOGIDAS
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
;ABRE UN ARCHIVO EN EL MODO QUE SE LE INDIQUE, LA RUTA DEL ARCHIVO Y EL HANDLER DEL ARCHIVO 
;AH:3DH
;AL:0 READ, 1 WRITE, 2 READ/WRITE
;AHAL=AX
abrirArchivo MACRO modo,pArchivo2,hAr4
       MOV      AX,modo
       MOV      DX, offset pArchivo2                
       INT      21h
       JC       errorAbrirArchivo
       MOV      hAr4,AX
ENDM
;MACRO PARA LEER ARCHIVO ---HASTA EL MOMENTO NO UTILIZADO LO DEJAMOS COMO EXTRA ---
leerArchivo MACRO  variableTexto , hArchivo
    LOCAL leer, cerrarA     ;LE INDICAMOS QUE ETIQUETAS SON LOCALES DE LA MACRO
   leer:
        MOV     AH,3fh
        MOV     BX,hArchivo
        XOR     DX,DX
        MOV     dx,offset variableTexto
        MOV     CX, 1
        INT     21h
        JC      errorLeerArchivo 
        CMP     AX,0
        JZ      cerrarA
        imprimir textoArchivo
        JMP     leer

     cerrarA:
         cerrarArchivo hArchivo
         imprimir saltoLinea
        JMP imprimirMenu
ENDM 
;ESCRIBIR EN UN ARCHIVO -------------------------------------------------
escribirArchivo MACRO texto,cant,hArc
        MOV     AH, 40h
        MOV     BX, hArc
        MOV     CX, cant
        MOV     DX, offset texto 
        INT     21h
        JC      errorEscribirArchivoPivote  
ENDM 
;------------------------------------------------------------------------
;----------------------------------- CREAR ARCHIVO ---------------------
crearArchivo MACRO pArchivo,hArchivo
        MOV     AH,3Ch
        MOV     CX,0                       
        MOV     DX,offset pArchivo
        INT     21h
        JC      errorCrearArchivo   
        MOV     hArchivo,AX
ENDM
;=================== LEER ARCHIVO ANALISIS LEXICO ===================
leerArchivoAnalisis MACRO  variableTexto , hArchivo
    LOCAL leer, cerrarA     ;LE INDICAMOS QUE ETIQUETAS SON LOCALES DE LA MACRO
   leer:
        MOV     AH,3fh
        MOV     BX,hArchivo
        XOR     DX,DX
        MOV     dx,offset variableTexto
        MOV     CX, 1
        INT     21h
        JC      errorLeerArchivo 
        CMP     AX,0
        JZ      cerrarA
        imprimir textoArchivo
        AnalisisLexico variableTexto
       
        JMP     leer

     cerrarA:
         cerrarArchivo hArchivo
         cerrarArchivo handler_ArchivoSintactico
         cerrarArchivo handler_E_AL
         imprimir saltoLinea
        ;JMP imprimirMenu
ENDM 
;============================= CERRAR ARCHIVO =========================
cerrarArchivo MACRO hcerrarA
    MOV     AH,3eh
    MOV     BX,hcerrarA
    INT     21h
ENDM 
;==========================ANALIZADOR LEXICO ============================
AnalisisLexico MACRO letra
    LOCAL verificado_exitoso,errorLexico,inicioMayuscula,inicioMinuscula,mayor_igual_cero
    LOCAL fin_analisis
    CMP     [letra],3ch     ;comparando con <
    JE      verificado_exitoso
    CMP     [letra],3eh     ;comparando con >
    JE      verificado_exitoso
    CMP     [letra],2bh     ;comparando con +
    JE      verificado_exitoso
    CMP     [letra],2eh     ;comparando con .
    JE      verificado_exitoso        
    CMP     [letra],2ah     ;comparando con *
    JE      verificado_exitoso
    CMP     [letra],25h     ;comparando con %
    JE      verificado_exitoso       
    CMP     [letra],3bh     ;comparando con ;
    JE      verificado_exitoso
    CMP     [letra],21h     ;comparando con !
    JE      verificado_exitoso   
    CMP     [letra],2fh     ;comparandon con /
    JE      verificado_exitoso
    CMP     [letra],2dh     ;comparando con -
    JE      verificado_exitoso
    CMP     [letra],0Dh     ;comparando con retorno de carry
    JE      verificado_exitoso       
    CMP     [letra],0Ah     ;comparando con salto de linea
    JE      verificado_exitoso
    CMP     [letra],20h     ;comparando con espacios en blanco 
    JE      verificado_exitoso
    CMP     [letra],09h     ;comparando con tabulacion
    JE      verificado_exitoso
    CMP     [letra],40h     ;verificamos si es >=A
    JA      inicioMayuscula   
    CMP     [letra],2fh     ;comparando si es mayor o igual a 0
    JA      mayor_igual_cero
    JMP     errorLexico

    inicioMayuscula:
        CMP     [letra],5bh     ;comparamos que sea <=Z
        JB      verificado_exitoso
        CMP     [letra],60h     ;comparamos si es >=a
        JA      inicioMinuscula
        JMP     errorLexico

    inicioMinuscula:
        CMP     [letra],7bh     ;comparamos que sea <=z
        JB      verificado_exitoso
        JMP     errorLexico

    mayor_igual_cero:
        CMP     [letra],3ah     ;comparando si es menor o igual a 9
        JB      verificado_exitoso
        JMP     errorLexico

    errorLexico:
        ;----------------ESCRIBIENDO EN EL ARCHIVO DE ERRORES LEXICOS ---------
        escribirArchivo errorLEX,50,handler_E_AL
        escribirArchivo letra,1,handler_E_AL
        ;----------------------------------------------------------------------
        ;-------------SI OCURRIO ERROR HABILITA BANDER ISERROR ----------------
        MOV     [IsError],1
        ;----------------------------------------------------------------------
        imprimir saltoLinea
        imprimir errorLEX
        imprimir letra
        imprimir saltoLinea
        imprimir saltoLinea
        JMP     fin_analisis

    verificado_exitoso:
        escribirArchivo letra,1,handler_ArchivoSintactico
        JMP     fin_analisis

    fin_analisis:
ENDM
;===================LEER ARCHIVO PARA ANALISIS SINTACTICO ==============
leerArchivoSintactico MACRO variable, h_sintactico
    LOCAL leer, cerrarA     ;LE INDICAMOS QUE ETIQUETAS SON LOCALES DE LA MACRO
   leer:
        MOV     AH,3fh
        MOV     BX,h_sintactico
        XOR     DX,DX
        MOV     dx,offset variable
        MOV     CX, 1
        INT     21h
        JC      errorLeerArchivo 
        CMP     AX,0
        JZ      cerrarA
        imprimir variable
        AnalisisSintactico variable
        JMP     leer

     cerrarA:
         cerrarArchivo h_sintactico     ;cierra el archivo para analisis sintactico
         cerrarArchivo handler_E_AS     ;cierra el archivo de errores sintacticos
         cerrarArchivo handler_Operaciones ;cierra el archivo de Operaciones
         imprimir saltoLinea
        ;JMP imprimirMenu
ENDM
;===========================ANALIZADOR SINTACTICO =================
AnalisisSintactico MACRO letra
    LOCAL ESTADO_0, FIN_ANALISIS, ERROR_SINTACTICO_E0, OK_ESTADO_0
    LOCAL ESTADO_1, ES_LETRA_E1, OK_ESTADO_1, ERROR_SINTACTICO_E1
    LOCAL ESTADO_2, OK_ESTADO_2, ERROR_SINTACTICO_E2, ESTADO_3, OK_ESTADO_3, ERROR_SINTACTICO_E3, ESTADO_4, ES_LETRA_E4, OK_ESTADO_4, ERROR_SINTACTICO_E4
    LOCAL ESTADO_5, OK_ESTADO_5, ERROR_SINTACTICO_E5, ESTADO_6, OK_ESTADO_6, ERROR_SINTACTICO_E6, ESTADO_7, ENCONTRO_OPERADOR, IR_ESTADO_8, IR_ESTADO_10, IR_ESTADO_11, ENCONTRO_NUMERO, ERROR_SINTACTICO_E7
    LOCAL ESTADO_8, REGRESAR_ESTADO_7, OK_ESTADO_8, ERROR_SINTACTICO_E8, ESTADO_9, OK_ESTADO_9, ERROR_SINTACTICO_E9, ESTADO_10, ENCONTRO_OPERADOR_E10, OK_ESTADO_10, IR_ESTADO_8_E10, ERROR_SINTACTICO_E10
    LOCAL ESTADO_11, OK_ESTADO_11, ERROR_SINTACTICO_E11,ESTADO_12, OK_ESTADO_12, ERROR_SINTACTICO_E12, ESTADO_13, ES_LETRA_E13, OK_ESTADO_13, ERROR_SINTACTICO_E13
    LOCAL ESTADO_14, ENCONTRO_CERO_14, OK_ESTADO_14, ERROR_SINTACTICO_E14,ESTADO_15, OK_ESTADO_15, ERROR_SINTACTICO_E15, ESTADO_16, ENCONTRO_LETRA_E16, OK_ESTADO_16,ERROR_SINTACTICO_16
    LOCAL ESTADO_17, ES_LETRA_E17, OK_ESTADO_17, ERROR_SINTACTICO_E17, ESTADO_18, OK_ESTADO_18, ERROR_SINTACTICO_E18
;----------------- NO VALIDACIONES ---------------------------------------
;NO DEBE TOMAR EN CUENTA NUEVA LINEA, ESPACIOS, TABULACIONES
;Y RETORNO DE CARRY
    CMP     [letra],09h         ;validando tabulacion
    JE      FIN_ANALISIS
    CMP     [letra],0Ah         ;validando new line
    JE      FIN_ANALISIS
    CMP     [letra],20h         ;validando espacio
    JE      FIN_ANALISIS          
    CMP     [letra],0Dh         ;validando retorno de carry
    JE      FIN_ANALISIS
;----------------HACIENDO LAS VALIDACIONES DE ESTADO--------------------
    CMP     [Estado],0
    JE      ESTADO_0
    CMP     [Estado],1
    JE      ESTADO_1
    CMP     [Estado],2
    JE      ESTADO_2
    CMP     [Estado],3
    JE      ESTADO_3
    CMP     [Estado],4
    JE      ESTADO_4
    CMP     [Estado],5
    JE      ESTADO_5
    CMP     [Estado],6
    JE      ESTADO_6
    CMP     [Estado],7
    JE      ESTADO_7
    CMP     [Estado],8
    JE      ESTADO_8
    CMP     [Estado],9
    JE      ESTADO_9
    CMP     [Estado],10
    JE      ESTADO_10
    CMP     [Estado],11
    JE      ESTADO_11
    CMP     [Estado],12
    JE      ESTADO_12
    CMP     [Estado],13
    JE      ESTADO_13
    CMP     [Estado],14
    JE      ESTADO_14
    CMP     [Estado],15
    JE      ESTADO_15
    CMP     [Estado],16
    JE      ESTADO_16
    CMP     [Estado],17
    JE      ESTADO_17
    CMP     [Estado],18
    JE      ESTADO_18

    JMP     FIN_ANALISIS
;---------------- VALIDACION ESTADO S0-----------------------------
    ESTADO_0:
        XOR     SI,SI
        CMP     [letra],3ch     ;validando que sea <
        JE      OK_ESTADO_0       
        JMP     ERROR_SINTACTICO_E0

    OK_ESTADO_0:
        MOV     [Estado],1
        JMP FIN_ANALISIS

    ERROR_SINTACTICO_E0:
        imprimir saltoLinea
        imprimir errorSINT
        imprimir error_s1
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s1,17,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................       
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;-----------------------------------------------------------------
;------------------------- VALIDANDO ESTADO S1--------------------
    ESTADO_1:
        ES_CARACTER letra
        CMP    [IsLetter],1         ;verifica si es una letra
        JE     ES_LETRA_E1  
        CMP    [letra],31h          ;verifica si es 1
        JE      OK_ESTADO_1
        JMP    ERROR_SINTACTICO_E1

    ES_LETRA_E1:
        MOV     [IsLetter],0     ;ya validamos que sea letra colocamos isletter en false
        MOV     DH,[letra]
        MOV     token_arqui[SI],DH
        INC     SI
        JMP     FIN_ANALISIS 

    OK_ESTADO_1:
        COMPARAR_ARREGLOS token_arqui,comparar_arqui,SI
        CMP     [Array_iguales],0
        JNE     ERROR_SINTACTICO_E1
        MOV     [Array_iguales],0
        BORRAR_ARREGLO token_arqui
        XOR     SI,SI
        MOV     [Estado],2
        JMP     FIN_ANALISIS

    ERROR_SINTACTICO_E1:
        MOV      [Array_iguales],0  
        BORRAR_ARREGLO token_arqui
        XOR     SI,SI
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_sv1,22,handler_E_AS
        ;................................................................. 
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................       
        imprimir saltoLinea
        imprimir error_sv1
        imprimir saltoLinea
        JMP FIN_ANALISIS
;------------------------------------------------------------------
;-----------------------VALIDANDO ESTADO 2 ------------------------
    ESTADO_2:
        XOR     SI,SI
        CMP     [letra],3eh        ;valida que sea >
        JE      OK_ESTADO_2
        JMP     ERROR_SINTACTICO_E2

    OK_ESTADO_2:
        MOV     [Estado],3
        JMP     FIN_ANALISIS

    ERROR_SINTACTICO_E2:
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s2,17,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s2
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;--------------------------------------------------------------------
;------------------------ VALIDANDO ESTADO 3 -------------------------
    ESTADO_3:
        XOR     SI,SI
        CMP     [letra],3cH     ;verifica si es <
        JE      OK_ESTADO_3
        JMP     ERROR_SINTACTICO_E3

    OK_ESTADO_3:
        MOV     [Estado],4
        JMP     FIN_ANALISIS   

    ERROR_SINTACTICO_E3:
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s1,17,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s1
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;--------------------------------------------------------------------

;----------------------- VALIDANDO ESTADO 4 -------------------------
    ESTADO_4:
        ES_CARACTER letra
        CMP     [IsLetter],1
        JE      ES_LETRA_E4
        ES_NUMERO   letra
        CMP     [IsNum],1
        JE      OK_ESTADO_4
        JMP     ERROR_SINTACTICO_E4

    ES_LETRA_E4:
        MOV     [IsLetter],0
        MOV     DH,[letra]
        MOV     token_operacion[SI],DH
        INC     SI
        JMP     FIN_ANALISIS

    OK_ESTADO_4:
        MOV     [IsNum],0
        COMPARAR_ARREGLOS token_operacion,comparar_operacion,SI
        CMP     [Array_iguales],0
        JNE     ERROR_SINTACTICO_E4
        BORRAR_ARREGLO token_operacion
        XOR     SI,SI
        MOV     [Estado],5
        JMP     FIN_ANALISIS
    
    ERROR_SINTACTICO_E4:
        MOV     [Array_iguales],0
        BORRAR_ARREGLO token_operacion
        XOR     SI,SI
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s4,25,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s4
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;--------------------------------------------------------------------
;--------------------------VALIDACION ESTADO 5-----------------------
    ESTADO_5:
        XOR     SI,SI
        CMP     [letra],30h     ;compara si es cero
        JE      FIN_ANALISIS
        CMP     [letra],3eh     ;compara con >
        JE      OK_ESTADO_5
        JMP     ERROR_SINTACTICO_E5

    OK_ESTADO_5:
        MOV     [Estado],6
        JMP FIN_ANALISIS

    ERROR_SINTACTICO_E5:
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s2,17,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s2
        imprimir saltoLinea
        JMP FIN_ANALISIS
;--------------------------------------------------------------------
;-------------------------VALIDANDO ESTADO 6-------------------------
    ESTADO_6:
        XOR     SI,SI
        ES_NUMERO letra
        CMP     [IsNum],1
        JE      OK_ESTADO_6
        CMP     [letra],30h         ;lo comparamos con 0 ya que esNum no compara con cero
        JE      OK_ESTADO_6
        JMP     ERROR_SINTACTICO_E6

    OK_ESTADO_6:
        MOV     [IsNum],0
        MOV     [Estado],7
        ;--------------escribiendo en el archivo operaciones.............
        escribirArchivo letra,1,handler_Operaciones
        ;................................................................
        JMP     FIN_ANALISIS

    ERROR_SINTACTICO_E6:
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s6,27,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s6
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;--------------------------------------------------------------------
;-------------------------VALIDANDO ESTADO 7-------------------------
    ESTADO_7:
        XOR     SI,SI
        ES_OPERADOR_ARITMETICO letra
        CMP     [IsOperatorAritmetic],1
        JE      ENCONTRO_OPERADOR
        CMP     [letra],2eh         ;compara si es .
        JE      ENCONTRO_OPERADOR
        ES_NUMERO letra
        CMP     [IsNum],1
        JE      ENCONTRO_NUMERO
        CMP     [letra],30h         ;comparamos si es 0
        JE      ENCONTRO_NUMERO
        CMP     [letra],2ah         ;encontro *
        JE      IR_ESTADO_8
        CMP     [letra],21h         ;COMPARANDO CON !
        JE      IR_ESTADO_10
        CMP     [letra],3bh         ;COMPARANDO CON ;
        JE      IR_ESTADO_11
        JMP     ERROR_SINTACTICO_E7

    ENCONTRO_OPERADOR:
        MOV     [IsOperatorAritmetic],0
        MOV     [Estado],6
        ;--------------escribiendo en el archivo operaciones.............
        escribirArchivo letra,1,handler_Operaciones
        ;................................................................        
        JMP     FIN_ANALISIS

    IR_ESTADO_8:
        MOV     [Estado],8
        ;--------------escribiendo en el archivo operaciones.............
        escribirArchivo letra,1,handler_Operaciones
        ;................................................................        
        JMP     FIN_ANALISIS

    IR_ESTADO_10:
        MOV     [Estado],10
        ;--------------escribiendo en el archivo operaciones.............
        escribirArchivo letra,1,handler_Operaciones
        ;................................................................        
        JMP     FIN_ANALISIS

    IR_ESTADO_11:
        MOV     [Estado],11
        ;--------------escribiendo en el archivo operaciones.............
        escribirArchivo saltoLinea,2,handler_Operaciones
        ;................................................................        
        JMP     FIN_ANALISIS

    ENCONTRO_NUMERO:
        MOV     [IsNum],0
        ;--------------escribiendo en el archivo operaciones.............
        escribirArchivo letra,1,handler_Operaciones
        ;................................................................        
        JMP     FIN_ANALISIS

    ERROR_SINTACTICO_E7:
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s7,43,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s7
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;--------------------------------------------------------------------
;---------------------VALIDANDO ESTADO 8-----------------------------
    ESTADO_8:
        XOR     SI,SI
        CMP     [letra],2ah         ;comparo con *
        JE      OK_ESTADO_8
        ES_NUMERO letra
        CMP     [IsNum],1           ;verifica si es num 1-9
        JE      REGRESAR_ESTADO_7
        CMP     [letra],30h         ;compara con 0
        JE      REGRESAR_ESTADO_7
        JMP     ERROR_SINTACTICO_E8

    REGRESAR_ESTADO_7:
        MOV     [IsNum],0
        MOV     [Estado],7
        ;--------------escribiendo en el archivo operaciones.............
        escribirArchivo letra,1,handler_Operaciones
        ;................................................................        
        JMP     FIN_ANALISIS

    OK_ESTADO_8:
        MOV     [Estado],9
        ;--------------escribiendo en el archivo operaciones.............
        escribirArchivo letra,1,handler_Operaciones
        ;................................................................        
        JMP     FIN_ANALISIS

    ERROR_SINTACTICO_E8:
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s8,31,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s8
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;--------------------------------------------------------------------
;---------------------------VALIDANDO ESTADO 9-----------------------
    ESTADO_9:
        XOR     SI,SI
        ES_NUMERO letra             ;validando numeros
        CMP     [IsNum],1
        JE      OK_ESTADO_9
        CMP     [letra],30h         ;validando 0
        JE      OK_ESTADO_9
        JMP     ERROR_SINTACTICO_E9

    OK_ESTADO_9:
        MOV     [IsNum],0
        MOV     [Estado],7
        ;--------------escribiendo en el archivo operaciones.............
        escribirArchivo letra,1,handler_Operaciones
        ;................................................................        
        JMP     FIN_ANALISIS

    ERROR_SINTACTICO_E9:
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s6,27,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s6
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;--------------------------------------------------------------------
;---------------------VALIDANDO ESTADO 10----------------------------
    ESTADO_10:
        XOR     SI,SI
        ES_OPERADOR_ARITMETICO letra
        CMP     [IsOperatorAritmetic],1
        JE      ENCONTRO_OPERADOR_E10
        CMP     [letra],3bh         ;comparando con ;
        JE      OK_ESTADO_10
        CMP     [letra],2ah
        JE      IR_ESTADO_8_E10
        JMP     ERROR_SINTACTICO_E10
    
    ENCONTRO_OPERADOR_E10:
        MOV     [IsOperatorAritmetic],0
        MOV     [Estado],6
        ;--------------escribiendo en el archivo operaciones.............
        escribirArchivo letra,1,handler_Operaciones
        ;................................................................        
        JMP     FIN_ANALISIS

    OK_ESTADO_10:
        MOV     [Estado],11
        ;--------------escribiendo en el archivo operaciones.............
        escribirArchivo saltoLinea,2,handler_Operaciones
        ;................................................................        
        JMP     FIN_ANALISIS

    IR_ESTADO_8_E10:
        MOV     [Estado],8
        ;--------------escribiendo en el archivo operaciones.............
        escribirArchivo letra,1,handler_Operaciones
        ;................................................................        
        JMP     FIN_ANALISIS

    ERROR_SINTACTICO_E10:
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s10,28,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s10
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;--------------------------------------------------------------------
;-------------------------VALIDANDO ESTADO 11------------------------
    ESTADO_11:
        XOR     SI,SI
        CMP     [letra],3ch     ;comparando con <
        JE      OK_ESTADO_11
        JMP     ERROR_SINTACTICO_E11

    OK_ESTADO_11:
        MOV     [Estado],12
        JMP     FIN_ANALISIS

    ERROR_SINTACTICO_E11:
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s1,17,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s1
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;---------------------------------------------------------------------
;------------------------VALIDANDO ESTADO 12--------------------------
    ESTADO_12:
        XOR     SI,SI
        CMP     [letra],2fh     ;validando /
        JE      OK_ESTADO_12
        JMP     ERROR_SINTACTICO_E12
    
    OK_ESTADO_12:
        MOV     [Estado],13        ;    MAL FUNCIONAMIENTO ESTADO 13 VERIFICAR DI, NO PARA CON SI=9
        JMP     FIN_ANALISIS

    ERROR_SINTACTICO_E12:
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s12,17,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s12
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;---------------------------------------------------------------------
;-------------------------VALIDANDO ESTADO 13 ------------------------
    ESTADO_13:
        ES_CARACTER letra
        CMP     [IsLetter],1
        JE      ES_LETRA_E13
        ES_NUMERO   letra
        CMP     [IsNum],1
        JE      OK_ESTADO_13
        JMP     ERROR_SINTACTICO_E13

    ES_LETRA_E13:
        MOV     [IsLetter],0
        MOV     DH,[letra]
        MOV     token_operacion[SI],DH
        INC     SI
        JMP     FIN_ANALISIS

    OK_ESTADO_13:
        MOV     [IsNum],0
        COMPARAR_ARREGLOS token_operacion,comparar_operacion,SI
        CMP     [Array_iguales],0
        JNE     ERROR_SINTACTICO_E13
        BORRAR_ARREGLO token_operacion
        XOR     SI,SI
       MOV     [Estado],14
        JMP     FIN_ANALISIS
    
    ERROR_SINTACTICO_E13:
        MOV     [Array_iguales],0
        BORRAR_ARREGLO token_operacion
        XOR     SI,SI
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s4,25,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s4
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;----------------------------------------------------------------------
;-------------------------VALIDANDO ESTADO 14--------------------------
    ESTADO_14:
        XOR     SI,SI
        CMP     [letra],30h     ;verifica si es cero
        JE      ENCONTRO_CERO_14
        CMP     [letra],3eh     ;encontro >
        JE      OK_ESTADO_14
        JMP     ERROR_SINTACTICO_E14

    ENCONTRO_CERO_14:
        ;SE QUEDA EN 14
        JMP     FIN_ANALISIS

    OK_ESTADO_14:
        MOV     [Estado],15
        JMP     FIN_ANALISIS

    ERROR_SINTACTICO_E14:
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s14,24,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s14
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;----------------------------------------------------------------------
;------------------------VALIDANDO ESTADO 15---------------------------
    ESTADO_15:
        XOR     SI,SI
        CMP     [letra],3ch         ;verificando que sea <
        JE      OK_ESTADO_15
        JMP     ERROR_SINTACTICO_E15
    
    OK_ESTADO_15:
        MOV     [Estado],16
        JMP     FIN_ANALISIS

    ERROR_SINTACTICO_E15:
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s1,17,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s1
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;----------------------------------------------------------------------
;----------------------VALIDANDO ESTADO 16-----------------------------
    ESTADO_16:
        ES_CARACTER letra
        CMP     [IsLetter],1        ;valida si es letra
        JE      ENCONTRO_LETRA_E16
        CMP     [letra],2fh         ;encontro /
        JE      OK_ESTADO_16
        JMP     ERROR_SINTACTICO_16

    ENCONTRO_LETRA_E16:
        MOV     [IsLetter],0
        MOV     [Estado],4
        MOV     DH,[letra]
        MOV     token_operacion[SI],DH
        INC     SI
        JMP     FIN_ANALISIS

    OK_ESTADO_16:
        XOR     SI,SI
        MOV     [Estado],17
        JMP     FIN_ANALISIS

    ERROR_SINTACTICO_16:
        XOR     SI,SI
        BORRAR_ARREGLO token_operacion
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s16,25,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s16
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;----------------------------------------------------------------------
;---------------------------VALIDANDO ESTADO 17------------------------
    ESTADO_17:
        ES_CARACTER letra
        CMP    [IsLetter],1         ;verifica si es una letra
        JE     ES_LETRA_E17  
        CMP    [letra],31h          ;verifica si es 1
        JE      OK_ESTADO_17
        JMP    ERROR_SINTACTICO_E17

    ES_LETRA_E17:
        MOV     [IsLetter],0     ;ya validamos que sea letra colocamos isletter en false
        MOV     DH,[letra]
        MOV     token_arqui[SI],DH
        INC     SI
        JMP     FIN_ANALISIS 

    OK_ESTADO_17:
        COMPARAR_ARREGLOS token_arqui,comparar_arqui,SI
        CMP     [Array_iguales],0
        JNE     ERROR_SINTACTICO_E17
        MOV     [Array_iguales],0
        BORRAR_ARREGLO token_arqui
        XOR     SI,SI
        MOV     [Estado],18
        JMP     FIN_ANALISIS

    ERROR_SINTACTICO_E17:
        MOV      [Array_iguales],0  
        BORRAR_ARREGLO token_arqui
        XOR     SI,SI
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_sv1,22,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_sv1
        imprimir saltoLinea
        JMP FIN_ANALISIS
;----------------------------------------------------------------------
;----------------------VALIDANDO ESTADO 18-----------------------------
    ESTADO_18:
        XOR     SI,SI
        CMP     [letra],3eh     ;comparando con >
        JE      OK_ESTADO_18
        JMP     ERROR_SINTACTICO_E18

    OK_ESTADO_18:
        ;...........escribiendo en el archivo de errores sintacticos.....       
        escribirArchivo confirmacion_s18,44,handler_E_AS
        ;.................................................................
        imprimir saltoLinea
        imprimir confirmacion_s18
        imprimir saltoLinea
        JMP     FIN_ANALISIS

    ERROR_SINTACTICO_E18:
        ;...........escribiendo en el archivo de errores sintacticos.....
        escribirArchivo errorSINT,31,handler_E_AS           
        escribirArchivo error_s2,17,handler_E_AS
        ;.................................................................
        ;..........SI OCURRIO ERROR HABILITA BANDER ISERROR ..............
        MOV     [IsError],1
        ;.................................................................
        imprimir saltoLinea
        imprimir error_s2
        imprimir saltoLinea
        JMP     FIN_ANALISIS
;-----------------------------------------------------------------------

    FIN_ANALISIS:     
ENDM
;==================== MACRO QUE VERIFICA QUE SEA UNA LETRA ==========
ES_CARACTER MACRO   char
    LOCAL ENCONTRO_MAYUSCULA, ENCONTRO_MINUSCULA, ENCONTRO_LETRA, SALIR_ES_CARACTER
    CMP     [char], 40h       ;verifica si es >=A
    JA      ENCONTRO_MAYUSCULA
    JMP     SALIR_ES_CARACTER

    ENCONTRO_MAYUSCULA:
        CMP     [char],5bh    ;verifica que sea <=Z
        JB      ENCONTRO_LETRA
        CMP     [char],60h    ;verifica que sea >=a
        JA      ENCONTRO_MINUSCULA
        JMP     SALIR_ES_CARACTER

    ENCONTRO_MINUSCULA:
        CMP     [char],7bh    ;verifica que sea <=z
        JB      ENCONTRO_LETRA
        JMP     SALIR_ES_CARACTER

    ENCONTRO_LETRA:
        MOV     [IsLetter],1
        JMP     SALIR_ES_CARACTER

    SALIR_ES_CARACTER:
ENDM
;=========================MACRO QUE BORRA EL ARREGLO =================0
BORRAR_ARREGLO MACRO Arreglo
    LOCAL limpiar
    XOR     DI,DI
    limpiar:
        MOV     Arreglo[DI],24h
        INC     DI
        CMP     DI,30
        JB      limpiar
    XOR     DI,DI
ENDM
;======================MACRO QUE COMPARA DOS ARREGOS ==================
COMPARAR_ARREGLOS MACRO Arreglo1, Arreglo2, CANT
    LOCAL continuar, not_iguales, FINALIZAR
    XOR     DI,DI
    continuar:
        XOR     DX,DX
        MOV     DH,[Arreglo1[DI]]
        MOV     DL,[Arreglo2[DI]]
        CMP     DH,DL
        JNE     not_iguales
        INC     DI
        CMP     DI,CANT
        JE      FINALIZAR
        JMP     continuar

    not_iguales:
        MOV     [Array_iguales],1
        JMP     FINALIZAR

    FINALIZAR:
        XOR     DI,DI
ENDM
;====================== MACRO QUE VERIFICA SI ES UN NUMERO ============
ES_NUMERO MACRO num
    LOCAL ES_MAYOR_UNO, ES_MENOR_NUEVE, SALIR_ES_NUMERO
    CMP     [num],30h   ;verifica que sea >=1
    JA      ES_MAYOR_UNO
    JMP     SALIR_ES_NUMERO

    ES_MAYOR_UNO:
        CMP     [num],3ah   ;verficia que sea <=9
        JB      ES_MENOR_NUEVE
        JMP     SALIR_ES_NUMERO

    ES_MENOR_NUEVE:
        MOV     [IsNum],1
        JMP     SALIR_ES_NUMERO

    SALIR_ES_NUMERO:
ENDM
;=============MACRO QUE VERIFICA SI ES OPERADOR ARITMETICO ============
ES_OPERADOR_ARITMETICO MACRO ope
    LOCAL ENCONTRO_OPERADOR_ARITMETICO, SALIR_ES_OPERADOR_ARITMETICO
    CMP     [ope],25h       ;comparando con %
    JE      ENCONTRO_OPERADOR_ARITMETICO
    CMP     [ope],2fh       ;comparando con /
    JE      ENCONTRO_OPERADOR_ARITMETICO
    CMP     [ope],2bh       ;comparando con +
    JE      ENCONTRO_OPERADOR_ARITMETICO
    CMP     [ope],2dh       ;comparando con -
    JE      ENCONTRO_OPERADOR_ARITMETICO
    JMP     SALIR_ES_OPERADOR_ARITMETICO
    
    ENCONTRO_OPERADOR_ARITMETICO:
        MOV     [IsOperatorAritmetic],1
        JMP     SALIR_ES_OPERADOR_ARITMETICO

    SALIR_ES_OPERADOR_ARITMETICO:
ENDM
;=========== MACRO QUE CAPTURA TEXTO DEL USUARIO EN UN ARREGLO =========
capturarCadena MACRO cadena
    LOCAL capturar, terminar_captura
    XOR     SI,SI
    capturar:
        INT     21h
        CMP     AL,13               ;SI ES ENTER SE SALE Y MUESTRA EL PATH
        JZ      terminar_captura
        MOV     cadena[SI],AL
        INC     SI     
        JMP     capturar

    terminar_captura:
ENDM 
;===== MACRO QUE LEE EL ARCHIVO OP.TXT PARA SABER CUANTAS OPERACIONES SE TIENEN ===
CantidadOperaciones MACRO variableTexto,hArchivo
    LOCAL leer,cerrarA,incrementar_contador
    leer:
        MOV     AH,3fh
        MOV     BX,hArchivo
        XOR     DX,DX
        MOV     DX,offset variableTexto
        MOV     CX,1
        INT     21h
        JC      errorLeerArchivo
        CMP     AX,0
        JZ      cerrarA
        CMP     [variableTexto],0Ah     ;verifica si es salto de linea
        JE      incrementar_contador
        imprimir variableTexto
        JMP     leer
    
    incrementar_contador:
        INC     [cantidad_operaciones]
       ; imprimir saltoLinea
        ;imprimir cantidad_operaciones
        imprimir saltoLinea
        JMP     leer

    cerrarA:
        XOR     SI,SI
        cerrarArchivo hArchivo
        imprimir saltoLinea
ENDM
;==== MACRO QUE ACEPTA UN NUMERO INGRESADO POR EL USUARIO =========================
capturarNumero MACRO variable
    MOV     AH,01h
    INT     21h
    SUB     AL,30h
    ;MOV     BH,AL
    MOV     BL,10
    MUL     BL
    MOV     [variable],AL
    ;CMP     BH,10
    ;JE      imprimirMenu
    MOV     AH,01h
    INT     21h
    SUB     AL,30h
    MOV     BH,[variable]
    ADD     BH,AL
    MOV     [variable],BH
   ; CMP     BH,10
    ;JE      imprimirMenu
ENDM
;=============== RECUPERA LA OPERACION SELECCIONADA ================================
RecuperarOperacion MACRO variableTexto,hArchivo
    LOCAL leer, cerrarA, encontro_salto_linea, es_operacion
    XOR     SI,SI
    leer:
        MOV     AH,3fh
        MOV     BX,hArchivo
        XOR     DX,DX
        MOV     DX,offset variableTexto
        MOV     CX,1
        INT     21h
        JC      errorLeerArchivo
        CMP     AX,0
        JZ      cerrarA
        CMP     [variableTexto],0Ah
        JE      encontro_salto_linea
        CMP     [variableTexto],0Dh
        JE      leer
        MOV     DH,[operacion_seleccionada]
        CMP     DH,[cantidad_operaciones]
        JE      es_operacion
       ; imprimir variableTexto
        JMP     leer
    
    encontro_salto_linea:
       ; imprimir saltoLinea
        INC     [cantidad_operaciones]
        JMP     leer

    es_operacion:
        ;imprimir variableTexto
        MOV     DH,[variableTexto]
        MOV     [Operacion_Array[SI]],DH
        INC     SI
        JMP     leer
    
    cerrarA:
        XOR     SI,SI
        cerrarArchivo hArchivo
        imprimir saltoLinea
ENDM
;=============== OBTENER CANTIDAD OPERADORES ======================================= MACRO ArrayOperacion
Obt_Cant_Operadores MACRO A_Operacion
    LOCAL leer_Array_Operadores, Encontro_Operador_Operadores, Encontro_mult1, Encontro_mult2, salir_cant_operadores
    XOR     SI,SI
    leer_Array_Operadores:
        CMP     [A_Operacion[SI]],2dh       ;verifica si es -
        JE      Encontro_Operador_Operadores
        CMP     [A_Operacion[SI]],2Bh       ;verifica si es +
        JE      Encontro_Operador_Operadores
        CMP     [A_Operacion[SI]],2fh       ;verifica si es /
        JE      Encontro_Operador_Operadores
        CMP     [A_Operacion[SI]],25h       ;verifica si es %
        JE      Encontro_Operador_Operadores
        CMP     [A_Operacion[SI]],2ah       ;verifica si es *
        JE      Encontro_mult1
        CMP     [A_Operacion[SI]],21h       ;verifica si es !
        JE      Encontro_Operador_Operadores
        CMP     [A_Operacion[SI]],24h       ;verifica si es $ fin
        JE      salir_cant_operadores
        INC     SI
        JMP     leer_Array_Operadores

    Encontro_Operador_Operadores:
        INC     [cantidad_operadores]
        INC     SI
        JMP     leer_Array_Operadores

    Encontro_mult1:
        INC     SI
        CMP     [A_Operacion[SI]],2ah     ;verifica si es *
        JE      Encontro_mult2
        INC     [cantidad_operadores]
        INC     SI
        JMP     leer_Array_Operadores

    Encontro_mult2:
        INC     [cantidad_operadores]
        INC     SI
        JMP     leer_Array_Operadores

    salir_cant_operadores:    
        XOR     SI,SI
ENDM
;=== PASA LA OPERACION A CALCULAR DEL ARREGLO DE 8 BITS AL ARREGLO DE 16 BITS=======
Actualizar_Array_Pivote MACRO Array_p,Array_original,Cambio_pivote
    LOCAL leer_A_orig, salir_actualizar_array ,Encontro_Num_A,Encontro_Num_A0,Guardar_Num_A,Encontro_operacion, Encontro_mult1_AP, Encontro_mult2_AP
    XOR     BH,BH
    XOR     SI,SI
    XOR     DI,DI
  ;  MOV     [Array_p[0]],4848h
  ;  MOV     [Array_p[2]],004fh
  ;  MOV     [Array_p[4]],896
  ;  MOV     BX,[Array_p[2]]
  ;  MOV     [extra],BL
  ;  ADD     [extra],30h

  ;  imprimir saltoLinea
  ;  imprimir Array_p
    leer_A_orig:
        MOV     BH,Array_original[SI]
        MOV     Cambio_pivote,BH
        CMP     Cambio_pivote,24h
        JE      salir_actualizar_array
        CMP     Cambio_pivote,2dh       ;-
        JE      Encontro_operacion
        CMP     Cambio_pivote,2bh       ;+
        JE      Encontro_operacion
        CMP     Cambio_pivote,2fh       ;/
        JE      Encontro_operacion
        CMP     Cambio_pivote,25h       ;%
        JE      Encontro_operacion
        CMP     Cambio_pivote,2ah       ;*
        JE      Encontro_mult1_AP
        CMP     Cambio_pivote,21h       ;!
        JE      Encontro_operacion
        JMP     Encontro_Num_A
        INC     SI
        JMP     leer_A_orig

    Encontro_Num_A: ;-----ENTRA AQUI CADA VEZ QUE ENCUENTRA UN NUMERO
        XOR     AX,AX
        CMP     [tmp_numero_grande],00
        JE      Encontro_Num_A0
        ;---- TODAS ESTAS INSTRUCCIONES SON IGUALES A LAS MISMAS QUE REALIZA LA OPERACION AAD CON LA DIFERENCIA 
        ;---- QUE SE REALIZAN PARA 16 BITS Y NO UNICAMENTE PARA 8 BITS.
        MOV     AX,[tmp_numero_grande];-------SI CONTINUA DE AQUI EN ADELANTE SE HACE LAS OPERACIONES
        MOV     AH,10  ;-----------------------NECESARIAS PARA PASAR EL NUMERO A ENTERO DE 16 BITS COMPLETO
        MUL     AH     
        MOV     [tmp_numero_grande],AX
        XOR     AX,AX
        MOV     AL,[Cambio_pivote]
        SUB     AL,30h
        XOR     BX,BX
        MOV     BX,[tmp_numero_grande]
        ADD     BX,AX
        MOV     [tmp_numero_grande],BX
        XOR     AX,AX
        XOR     BX,BX
        INC     SI
        JMP     leer_A_orig
    
    Encontro_Num_A0:;---------ENTRA AQUI CUANDO EL ARRAY TEMPORAL DE NUMERO(16BITS) NO TIENE NUMEROS
        MOV     AL,[Cambio_pivote]
        SUB     AL,30h
        MOV     [tmp_numero_grande],AX
        INC     SI
        JMP     leer_A_orig

    Guardar_Num_A:
        XOR     BX,BX
        MOV     BX,[tmp_numero_grande]
        MOV     [Array_p[DI]],BX
        ADD     DI,2
        XOR     BX,BX
        MOV     [tmp_numero_grande],00
        JMP     leer_A_orig

    Encontro_operacion:
        CMP     [tmp_numero_grande],00
        JNE     Guardar_Num_A
        XOR     BX,BX   
        MOV     BL,Cambio_pivote
        MOV     [Array_p[DI]],BX
        ADD     DI,2
        INC     SI
        XOR     BX,BX
        JMP     leer_A_orig
    
    Encontro_mult1_AP:
        CMP     [tmp_numero_grande],00
        JNE     Guardar_Num_A
        CMP     Array_original[SI+1],2ah ;*
        JE      Encontro_mult2_AP
        XOR     BX,BX
        MOV     BL,Cambio_pivote
        MOV     [Array_p[DI]],BX
        INC     SI
        ADD     DI,2
        XOR     BX,BX
        JMP     leer_A_orig

    Encontro_mult2_AP:
        INC     SI
        XOR     BX,BX
        MOV     BX,2a2ah        ;**      
        MOV     [Array_p[DI]],BX
        ADD     DI,2
        INC     SI
        XOR     BX,BX
        JMP     leer_A_orig

    salir_actualizar_array:
        CMP     [tmp_numero_grande],00
        JNE     Guardar_Num_A
        XOR     BX,BX
        XOR     SI,SI
        XOR     DI,DI  
ENDM
;============= BORRAR ARREGLO DE 16 BITS ===========================================
BORRAR_ARREGLO_16bits MACRO Arreglo
    LOCAL limpiar
    XOR     DI,DI
    limpiar:
        MOV     Arreglo[DI],2424h
        ADD     DI,2
        CMP     DI,60
        JB      limpiar
    XOR     DI,DI
ENDM
;============= ORDENA OPERACIONES POR PRECEDENCIA ===================================
Ord_Precedencia MACRO Arreglo_OP, Arreglo_Pre, Cambio
    LOCAL cont_lectura, Encontro_Operador, salir_precedencia,Operador_en_0, Operador_en_1, Quitar_operador, Operadores_iguales
    LOCAL Operador0_mayor, Operador0_menor, Bandera_menor_activada, Encontro_factorial, E_factorial_menor
    XOR     SI,SI
    XOR     DI,DI
    cont_lectura:
        XOR     BX,BX
        MOV     BX,[Arreglo_OP[SI]]
        MOV     [Cambio],BX
        CMP     [Cambio],2424h              ;$$
        JE      salir_precedencia
        ES_OPERADOR_ARITMETICO_16bits Cambio        ;verifica si es operador
        CMP     [IsOperatorAritmetic],1
        JE      Encontro_Operador
        CMP     [Cambio],0021h                ;verifica si es el factorial
        JE      Encontro_factorial
        MOV     [Arreglo_Pre[DI]],BX
        ADD     DI,2
        CMP     [b_is_menor],1
        JE      Bandera_menor_activada
        ADD     SI,2
        JMP     cont_lectura
    
    Encontro_Operador:
        MOV     [IsOperatorAritmetic],0
        CMP     [cont_operadores],0
        JE     Operador_en_0
        CMP     [cont_operadores],1
        JE     Operador_en_1
        ADD     SI,2
        JMP     cont_lectura

    Operador_en_0:
        XOR     BX,BX
        MOV     BX,[Cambio]
        MOV     [Pila_Operadores[0]],BX
        MOV     [cont_operadores],1
        ADD     SI,2
        JMP     cont_lectura

    Operador_en_1:
        XOR     BX,BX
        MOV     BX,[Cambio]
        MOV     [Pila_Operadores[2]],BX
        MOV     [cont_operadores],2
        CMP     [cont_operadores],2
        JE      Quitar_operador
        ADD     SI,2
        JMP     cont_lectura

    Quitar_operador:
        VALOR_PRECEDENCIA_OP Pila_Operadores[0],V_op_pos0
        VALOR_PRECEDENCIA_OP Pila_Operadores[2],V_op_pos1
        XOR     BX,BX
        MOV     BL,[V_op_pos0] 
        CMP     BL,[V_op_pos1]
        JE      Operadores_iguales
        CMP     BL,[V_op_pos1]
        JA      Operador0_mayor
        CMP     BL,[V_op_pos1]
        JB      Operador0_menor
        ADD     SI,2
        JMP     cont_lectura

    Operadores_iguales:
        MOV     [b_is_menor_factorial],0
        XOR     BX,BX
        MOV     BX,[Pila_Operadores[0]]
        MOV     [Arreglo_Pre[DI]],BX
        ADD     DI,2
        ADD     SI,2
        XOR     BX,BX
        MOV     BX,[Pila_Operadores[2]]
        MOV     [Pila_Operadores[2]],2424h
        MOV     [Pila_Operadores[0]],BX
        MOV     [cont_operadores],1
        JMP     cont_lectura

    Operador0_mayor:
        ;si el operador en 0 es mayor, sale este, por eso solo saltamos a la
        ;etiqueta operadores_iguales ya que son las mismas instrucciones
        JMP     Operadores_iguales

    Operador0_menor:
        MOV     [b_is_menor],1      ;ACTIVA LA BANDERA
        ADD     SI,2
        JMP     cont_lectura

    Bandera_menor_activada:
        MOV     [b_is_menor],0
        MOV     [b_is_menor_factorial],1
        XOR     BX,BX
        MOV     BX,[Pila_Operadores[2]]
        MOV     [Pila_Operadores[2]],2424h
        MOV     [Arreglo_Pre[DI]],BX
        MOV     [cont_operadores],1
        ADD     DI,2
        ADD     SI,2
        JMP     cont_lectura

    Encontro_factorial:
        MOV     [resultado_factorial],0001
        CMP     [b_is_menor_factorial],1
        JE      E_factorial_menor
        CALCULAR_FACTORIAL Arreglo_Pre[DI-2]
        XOR     BX,BX
        MOV     BX,[resultado_factorial]
        MOV     [Arreglo_Pre[DI-2]],BX
        ADD     SI,2
        MOV     [resultado_factorial],0001
        JMP     cont_lectura

    E_factorial_menor:
        MOV     [b_is_menor_factorial],0
        CALCULAR_FACTORIAL Arreglo_Pre[DI-4]
        XOR     BX,BX
        MOV     BX,[resultado_factorial]
        MOV     [Arreglo_Pre[DI-4]],BX
        ADD     SI,2
        MOV     [resultado_factorial],0001
        JMP     cont_lectura

    salir_precedencia:
        XOR     BX,BX
        MOV     BX,[Pila_Operadores[0]]
        MOV     [Pila_Operadores[0]],2424h
        MOV     [Arreglo_Pre[DI]],BX
        MOV     [cont_operadores],0             ;limpiamos todas las banderas utilizadas
        MOV     [b_is_menor],0                  ;a su valor original
        MOV     [b_is_menor_factorial],0
        MOV     [V_op_pos0],0
        MOV     [V_op_pos1],0
        XOR     SI,SI
        XOR     DI,DI
        XOR     BX,BX
ENDM
;============ MACRO QUE VERIFICA SI ES UN OPERADOR DE 16BITS =========================
ES_OPERADOR_ARITMETICO_16bits MACRO operator
    LOCAL Encontro_operator_16bits,Salir_operator_aritmetico
    CMP     [operator],002bh            ;+
    JE      Encontro_operator_16bits
    CMP     [operator],002dh            ;-
    JE      Encontro_operator_16bits
    CMP     [operator],002ah            ;*
    JE      Encontro_operator_16bits
    CMP     [operator],0025h            ;%
    JE      Encontro_operator_16bits
    CMP     [operator],002fh            ;/
    JE      Encontro_operator_16bits
    CMP     [operator],2a2ah            ;**
    JE      Encontro_operator_16bits
  ;  CMP     [operator],0021h            ;!
  ;  JE      Encontro_operator_16bits
    JMP     Salir_operator_aritmetico

    Encontro_operator_16bits:
        MOV     [IsOperatorAritmetic],1
        JMP     Salir_operator_aritmetico
    
    Salir_operator_aritmetico:
ENDM
;============== MACRO QUE ME DA EL VALOR DE PRECEDENCIA OPERADOR =====================
VALOR_PRECEDENCIA_OP MACRO Operador_N, V_Operador_N
   LOCAL    salir_valor_precedencia, operador_nivel_1, operador_nivel_2, operador_nivel_3
    CMP     [Operador_N],002bh      ;+
    JE      operador_nivel_1
    CMP     [Operador_N],002dh      ;-
    JE      operador_nivel_1
    CMP     [Operador_N],002fh      ;/
    JE      operador_nivel_2
    CMP     [Operador_N],0025h      ;%
    JE      operador_nivel_2
    CMP     [Operador_N],002ah      ;*
    JE      operador_nivel_2
    CMP     [Operador_N],2a2ah      ;**
    JE      operador_nivel_3
  ;  CMP     [Operador_N],0021h      ;!
  ;  JE      operador_nivel_4

    operador_nivel_1:
        MOV     [V_Operador_N],1
        JMP     salir_valor_precedencia

    operador_nivel_2:
        MOV     [V_Operador_N],2
        JMP     salir_valor_precedencia

    operador_nivel_3:
        MOV     [V_Operador_N],3
        JMP     salir_valor_precedencia
  ;  operador_nivel_4:

    salir_valor_precedencia:
ENDM
;=============== CALCULA EL FACTORIAL DE UN NUMERO MAX 8BITS EL RESULTADO ============
CALCULAR_FACTORIAL MACRO  NUMERO
    LOCAL ciclo
    MOV     [tmp_CX],CX
    XOR     CX,CX
    MOV     CX,[NUMERO]

    ciclo:
        MOV     AX,[resultado_factorial]
        MOV     BX,CX
        MUL     BL
        MOV     [resultado_factorial],AX
        LOOP    ciclo
    XOR     CX,CX
    MOV     CX,[tmp_CX]
ENDM
;============== MACRO QUE REALIZA EL CALCULO POR PRECEDENCIA =========================
CALCULO_PRECEDENCIA MACRO Array_precedencia, temp_valor
    imprimir saltoLinea
    XOR     SI,SI
    XOR     DI,DI
    XOR     BX,BX
    leer_prec:
        XOR     BX,BX
        MOV     BX,[Array_precedencia[SI]]
        MOV     [temp_valor],BX
        CMP     [temp_valor],2424h                  ;si es $$
        JE      salir_calc_precedencia
        CMP     [temp_valor],002bh      ;+
        JE      op_suma
        CMP     [temp_valor],002dh      ;-
        JE      op_resta
        CMP     [temp_valor],002ah      ;*
        JE      op_multiplicado
        CMP     [temp_valor],0025h      ;%
        JE      op_modulo
        CMP     [temp_valor],002fh      ;/
        JE      op_division
        CMP     [temp_valor],2a2ah      ;**
        JE      op_potencia
        ADD     SI,2
        JMP     leer_prec

    op_multiplicado:
        XOR     BX,BX
        MOV     BX,[Array_precedencia[SI-4]]
        MOV     [var_num1],BX
        MOV     BX,[Array_precedencia[SI-2]]
        MOV     [var_num2],BX
        ;--se realizara multiplicaciones de word 
        XOR     AX,AX
        MOV     AX,[var_num1]
        MOV     BX,[var_num2]
        XOR     DX,DX
        MUL     BX
        MOV     [var_resultado],AX

        imprimir msg_salida
        IMPRIMIR_NUM16BITS_V2 var_num1      ;imprime num1
        imprimir temp_valor                 ;imprime operador
        IMPRIMIR_NUM16BITS_V2 var_num2      ;imprime num2
        imprimir msg_pregunta               ;imprime ?
        IMPRIMIR_NUM16BITS_V2 var_resultado
        imprimir saltoLinea
        imprimir msg_salida
        capturarNumero_v2 resultado_usario
        IMPRIMIR_NUM16BITS_V2 resultado_usario
        XOR     BX,BX
        MOV     BX,[resultado_usario]
        CMP     BX,[var_resultado]
        JE      acerto
        JMP     no_acerto
        ;MOV     [var_resultado],00
        ;ADD     SI,2
        JMP     leer_prec

    op_suma:
        XOR     BX,BX
        MOV     BX,[Array_precedencia[SI-4]]
        MOV     [var_num1],BX
        MOV     [var_resultado],BX
        MOV     BX,[Array_precedencia[SI-2]]
        MOV     [var_num2],BX
        ADD     [var_resultado],BX
        imprimir msg_salida
        IMPRIMIR_NUM16BITS_V2 var_num1
        imprimir temp_valor
        IMPRIMIR_NUM16BITS_V2 var_num2
        imprimir msg_pregunta
        IMPRIMIR_NUM16BITS_V2 var_resultado
        imprimir saltoLinea
        imprimir msg_salida
        capturarNumero_v2 resultado_usario
        IMPRIMIR_NUM16BITS_V2 resultado_usario
        XOR     BX,BX
        MOV     BX,[resultado_usario]
        CMP     BX,[var_resultado]
        JE      acerto
        JMP     no_acerto
        JMP     leer_prec

    op_resta:
        XOR     BX,BX
        MOV     BX,[Array_precedencia[SI-4]]
        MOV     [var_num1],BX
        MOV     [var_resultado],BX
        MOV     BX,[Array_precedencia[SI-2]]
        MOV     [var_num2],BX
        SUB     [var_resultado],BX
        imprimir msg_salida
        IMPRIMIR_NUM16BITS_V2 var_num1
        imprimir temp_valor
        IMPRIMIR_NUM16BITS_V2 var_num2
        imprimir msg_pregunta
        IMPRIMIR_NUM16BITS_V2 var_resultado
        imprimir saltoLinea
        imprimir msg_salida
        capturarNumero_v2 resultado_usario
        IMPRIMIR_NUM16BITS_V2 resultado_usario
        XOR     BX,BX
        MOV     BX,[resultado_usario]
        CMP     BX,[var_resultado]
        JE      acerto
        JMP     no_acerto
        JMP     leer_prec

    op_modulo:
        XOR     BX,BX
        MOV     BX,[Array_precedencia[SI-4]]
        MOV     [var_num1],BX
        MOV     BX,[Array_precedencia[SI-2]]
        MOV     [var_num2],BX
        ;--se realizara multiplicaciones de word 
        XOR     AX,AX
        MOV     AX,[var_num1]
        MOV     BX,[var_num2]
        XOR     DX,DX
        DIV     BX
        MOV     [var_resultado],DX

        imprimir msg_salida
        IMPRIMIR_NUM16BITS_V2 var_num1      ;imprime num1
        imprimir temp_valor                 ;imprime operador
        IMPRIMIR_NUM16BITS_V2 var_num2      ;imprime num2
        imprimir msg_pregunta               ;imprime ?
        IMPRIMIR_NUM16BITS_V2 var_resultado
        imprimir saltoLinea
        imprimir msg_salida
        capturarNumero_v2 resultado_usario
        IMPRIMIR_NUM16BITS_V2 resultado_usario
        XOR     BX,BX
        MOV     BX,[resultado_usario]
        CMP     BX,[var_resultado]
        JE      acerto
        JMP     no_acerto
        ;MOV     [var_resultado],00
        ;ADD     SI,2
        JMP     leer_prec

    op_division:
        XOR     BX,BX
        MOV     BX,[Array_precedencia[SI-4]]
        MOV     [var_num1],BX
        MOV     BX,[Array_precedencia[SI-2]]
        MOV     [var_num2],BX
        ;--se realizara multiplicaciones de word 
        XOR     AX,AX
        MOV     AX,[var_num1]
        MOV     BX,[var_num2]
        XOR     DX,DX
        DIV     BX
        MOV     [var_resultado],AX

        imprimir msg_salida
        IMPRIMIR_NUM16BITS_V2 var_num1      ;imprime num1
        imprimir temp_valor                 ;imprime operador
        IMPRIMIR_NUM16BITS_V2 var_num2      ;imprime num2
        imprimir msg_pregunta               ;imprime ?
        IMPRIMIR_NUM16BITS_V2 var_resultado
        imprimir saltoLinea
        imprimir msg_salida
        capturarNumero_v2 resultado_usario
        IMPRIMIR_NUM16BITS_V2 resultado_usario
        XOR     BX,BX
        MOV     BX,[resultado_usario]
        CMP     BX,[var_resultado]
        JE      acerto
        JMP     no_acerto
        ;MOV     [var_resultado],00
        ;ADD     SI,2
        JMP     leer_prec

    op_potencia:
        XOR     BX,BX
        MOV     BX,[Array_precedencia[SI-4]]
        MOV     [var_num1],BX
        MOV     BX,[Array_precedencia[SI-2]]
        MOV     [var_num2],BX
        MOV     [tmp_CX],CX
        MOV     CX,[var_num2]
        XOR     AX,AX
        MOV     AX,[var_num1]
        MOV     BX,[var_num1]
        DEC     CX
        ;--se realizara multiplicaciones de word 
       EFECT_OP:
            XOR     DX,DX
            MUL     BX
            LOOP    EFECT_OP
        MOV     CX,[tmp_CX]
        MOV     [tmp_CX],0000
        MOV     [var_resultado],AX
        imprimir msg_salida
        IMPRIMIR_NUM16BITS_V2 var_num1      ;imprime num1
        imprimir temp_valor                 ;imprime operador
        IMPRIMIR_NUM16BITS_V2 var_num2      ;imprime num2
        imprimir msg_pregunta               ;imprime ?
        IMPRIMIR_NUM16BITS_V2 var_resultado
        imprimir saltoLinea
        imprimir msg_salida
        capturarNumero_v2 resultado_usario
        IMPRIMIR_NUM16BITS_V2 resultado_usario
        XOR     BX,BX
        MOV     BX,[resultado_usario]
        CMP     BX,[var_resultado]
        JE      acerto
        JMP     no_acerto
        ;MOV     [var_resultado],00
        ;ADD     SI,2
        JMP     leer_prec

    acerto:
        imprimir saltoLinea
        imprimir resp_correcta
        XOR     BX,BX
        MOV     BL,[valor_operacion]
        ADD     [puntos_acumulados],BX
        IMPRIMIR_NUM16BITS_V2 puntos_acumulados
        imprimir saltoLinea
        XOR     BX,BX
        MOV     BX,[var_resultado]
        MOV     [Array_precedencia[SI-4]],BX
        ADD     SI,2
        JMP     ordenar_arreglo
       ; ADD     SI,2
       ; JMP     leer_prec
        

    no_acerto:
        imprimir saltoLinea
        imprimir resp_incorrecta
        IMPRIMIR_NUM16BITS_V2 var_resultado
        imprimir saltoLinea
        XOR     BX,BX
        MOV     BX,[var_resultado]
        MOV     [Array_precedencia[SI-4]],BX
        ADD     SI,2
        JMP     ordenar_arreglo
       ; ADD     SI,2
       ; JMP     leer_prec

    ordenar_arreglo:
        CMP     [Array_precedencia[SI]],2424h
        JE      fin_ordenar_arreglo
        XOR     BX,BX
        MOV     BX,[Array_precedencia[SI]]
        MOV     [Array_precedencia[SI-4]],BX
        ADD     SI,2
        JMP     ordenar_arreglo
    
    fin_ordenar_arreglo:
        MOV     [Array_precedencia[SI-4]],2424h
        MOV     [Array_precedencia[SI-2]],2424h
        MOV     [resultado_usario],0000
        XOR     SI,SI
        JMP     leer_prec
        ;JMP     salir_calc_precedencia
    
    ;encontro_operador_prec:
    ;    MOV     [IsOperatorAritmetic],0
    ;    imprimir temp_valor
    ;    ADD     SI,2
    ;    JMP     leer_prec

    salir_calc_precedencia:
ENDM
;================== MACRO QUE IMPRIMIRA UN NUMERO DE 16BITS ==========================
;el maximo numero que se le puede mandan para imprimir es 2555 ya que usa registros de 
;8 bits para hacer calculo, solo el primer calculo nos premite tener un numero de 16 bits
;ya que 2555/10=255.5 a partir de la primera division dentro de 10 solo se usan 
;registros de 8 bits
;-----la version 1 no fue utilizada sirvio como guia para la v2---- el mensaje de arriba es
;valido unicamente para la v1
IMPRIMIR_NUM16BITS MACRO NUM
    LOCAL continuar, leer_e_imprimir,salir_imp_num16
    MOV     [tmp_SI],SI
    XOR     SI,SI
    XOR     BX,BX
    XOR     AX,AX
    ;--ESTO SE REALIZA AL INICIO YA QUE NO SE TIENE NADA
    MOV     AX,[NUM]
    MOV     BH,10
    DIV     BH
   ; MOV     [extra],AH
    PUSH    AX
    INC     SI
    MOV     BL,AL
    ;imprimir saltoLinea
    ;imprimir extra
    continuar:
        XOR     AX,AX
        MOV     AL,BL
        XOR     BX,BX
        CMP     AL,00
        JE      leer_e_imprimir
        MOV     BH,10
        DIV     BH
        ;MOV     [extra],AH
        PUSH    AX
        INC     SI
        MOV     BL,AL
        ;imprimir saltoLinea
        ;imprimir extra
        JMP     continuar

    leer_e_imprimir:
        CMP     SI,0
        JE      salir_imp_num16
        POP     AX
        ADD     AH,30h
        MOV     [extra],AH
       ; imprimir saltoLinea
        imprimir extra
        DEC     SI
        JMP     leer_e_imprimir
        
    salir_imp_num16:
        MOV     SI,[tmp_SI]
        MOV     [extra],0
       ; CMP     [NUM],652
       ; JE      imprimirMenu
ENDM

IMPRIMIR_NUM16BITS_V2 MACRO NUM
    LOCAL continuar, leer_e_imprimir,salir_imp_num16
    MOV     [tmp_SI],SI
    XOR     SI,SI
    XOR     BX,BX
    XOR     AX,AX
    XOR     DX,DX
    ;--ESTO SE REALIZA AL INICIO YA QUE NO SE TIENE NADA
    MOV     AX,[NUM]
    MOV     BX,0010
    DIV     BX
   ; MOV     [extra],AH
    PUSH    DX
    INC     SI
    XOR     BX,BX
    MOV     BX,AX
    ;imprimir saltoLinea
    ;imprimir extra
    continuar:
        XOR     AX,AX
        XOR     DX,DX
        MOV     AX,BX
        XOR     BX,BX
        CMP     AX,00
        JE      leer_e_imprimir
        MOV     BX,0010
        DIV     BX
        ;MOV     [extra],AH
        PUSH    DX
        INC     SI
        MOV     BX,AX
        ;imprimir saltoLinea
        ;imprimir extra
        JMP     continuar

    leer_e_imprimir:
        XOR     AX,AX
        CMP     SI,0
        JE      salir_imp_num16
        POP     AX
        ADD     AL,30h
        MOV     [extra],AL
        imprimir extra
        DEC     SI
        JMP     leer_e_imprimir
        
    salir_imp_num16:
        MOV     SI,[tmp_SI]
        MOV     [extra],0
       ; CMP     [NUM],652
       ; JE      imprimirMenu
ENDM
;============= MACRO QUE CAPTURA UN NUMERO SIN LIMITE DE CANTIDAD 16 BITS ===========
;--el maximo numero que puede capturar es 2 elevado 16
capturarNumero_v2 MACRO variable
    LOCAL       cont_captura, salir_captura_numero
        XOR     AX,AX
        MOV     AH,01h
        INT     21h
        CMP     AL,0Ah          ;salto linea
        JE      salir_captura_numero
        XOR     AH,AH
        SUB     AX,0030h
        MOV     [variable],AX
    cont_captura:
        XOR     AX,AX
        MOV     AH,01h
        INT     21h
        CMP     AL,0Dh          ; si es ese sale de captura numero
        JE      salir_captura_numero
        MOV     [tmp_AL],AL
        XOR     AX,AX
        MOV     AX,[variable]
        MOV     BX,0010
        MUL     BX
        MOV     [variable],AX
        XOR     AH,AH
        MOV     AL,[tmp_AL]
        SUB     AX,0030h
        XOR     DX,DX
        MOV     DX,[variable]
        ADD     DX,AX
        MOV     [variable],DX
        JMP     cont_captura

    salir_captura_numero:
        MOV     [tmp_AL],0
        XOR     AX,AX
        XOR     BX,BX
        XOR     DX,DX
ENDM
;============= MACRO QUE POSICIONA EL PUNTERO DEL ARCHIVO ============================
posicionarPuntero MACRO handler_p, num
    LOCAL errorPunteroArchivo, salir_pos_puntero
        MOV     AH,42h
        MOV     AL,00h            ;QUE EMPIEZE A CONTAR DESDE EL INICIO DEL ARCHIVO SEEK_SET
        MOV     BX,handler_p
        MOV     CX,0              ;CX DEBE SER CERO MITAD MAS SIGNIFICATIVA DEL DESPLAZAMIENTO
        MOV     DX,num             ;DX EL VALOR A MOVERSE LA MITAD MENOS SIGNIFICATIVA DEL DESPLAZAMIENTO
        INT     21h
        JC      errorPunteroArchivo 
        JMP     salir_pos_puntero

        errorPunteroArchivo:
            imprimir errorPuntero
            JMP salir_pos_puntero
        
        salir_pos_puntero:
ENDM
;=========== MACRO QUE RECUPERA LA FECHA/HORA DEL SISTEMA ============================
getTime MACRO handlerR
    LOCAL dividirDia, resultadoDia, resultadoDia2, dividirMes, resultadoMes, resultadoMes2, dividirAnio, resultadoAnio
    LOCAL dividirHora, resultadoHora, resultadoHora2, dividirMinutos, resultadoMinutos, resultadoMinutos2
    posicionarPuntero handler_punteo,207
    escribirArchivo FECHA,7,handlerR
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
       ; imprimir saltoLinea
        ;imprimir diaSistema
        escribirArchivo diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoDia
    resultadoDia2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
     ;   imprimir saltoLinea
     ;   imprimir diaSistema
        escribirArchivo diaSistema,1,handlerR
    
    escribirArchivo separador_Fecha,1,handlerR
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
       ; imprimir saltoLinea
       ; imprimir diaSistema
       escribirArchivo diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoMes
    resultadoMes2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
      ;  imprimir saltoLinea
      ;  imprimir diaSistema
       escribirArchivo diaSistema,1,handlerR             
            
    escribirArchivo separadorFecha,1,handlerR
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
     ;   imprimir saltoLinea
     ;   imprimir diaSistema
        escribirArchivo diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoAnio
        
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
     ;   imprimir saltoLinea
     ;   imprimir diaSistema
       escribirArchivo diaSistema,1,handlerR
        
     
     escribirArchivo saltoLinea,2,handlerR 
     escribirArchivo HORA,6,handlerR  
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
     ;   imprimir saltoLinea
     ;   imprimir diaSistema
        escribirArchivo diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoHora
    resultadoHora2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
       ; imprimir saltoLinea
       ; imprimir diaSistema
        escribirArchivo diaSistema,1,handlerR
    
    escribirArchivo separador_hora,1,handlerR    
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
     ;   imprimir saltoLinea
    ;   imprimir diaSistema
        escribirArchivo diaSistema,1,handlerR
        DEC     SI
        CMP     SI,00h
        JA      resultadoMinutos
    resultadoMinutos2:
        XOR     CX,CX
        POP     CX    
        ADD     CX,30h
        MOV     diaSistema,CL
    ;    imprimir saltoLinea
    ;    imprimir diaSistema
        escribirArchivo diaSistema,1,handlerR    
        escribirArchivo saltoLinea,2,handlerR
ENDM  
;=============== MACRO QUE LEE EL ARCHIVO TOP.TXT ====================================
LEER_MAX_PUNTEO MACRO handler_ar, texto
    LOCAL leer_punt, cerrarA_punt     ;LE INDICAMOS QUE ETIQUETAS SON LOCALES DE LA MACRO
   leer_punt:
        MOV     AH,3fh
        MOV     BX,handler_ar
        XOR     DX,DX
        MOV     dx,offset texto
        MOV     CX, 1
        INT     21h
        JC      errorLeerArchivo 
        CMP     AX,0
        JZ      cerrarA_punt
        imprimir texto
        JMP     leer_punt

     cerrarA_punt:
         cerrarArchivo handler_ar
         imprimir saltoLinea
ENDM
;=========== ESCRIBIR ARCHIVO NUM16BITS ==============================================
;este sirve para pasarle un numero de 16bits y escribir su valor en una archivo
;es por ello que recibe el handler del archivo
IMPRIMIR_NUM16BITS_V3 MACRO NUM,handler_pn
    LOCAL continuar, leer_e_imprimir,salir_imp_num16
    MOV     [tmp_SI],SI
    XOR     SI,SI
    XOR     BX,BX
    XOR     AX,AX
    XOR     DX,DX
    ;--ESTO SE REALIZA AL INICIO YA QUE NO SE TIENE NADA
    MOV     AX,[NUM]
    MOV     BX,0010
    DIV     BX
   ; MOV     [extra],AH
    PUSH    DX
    INC     SI
    XOR     BX,BX
    MOV     BX,AX
    ;imprimir saltoLinea
    ;imprimir extra
    continuar:
        XOR     AX,AX
        XOR     DX,DX
        MOV     AX,BX
        XOR     BX,BX
        CMP     AX,00
        JE      leer_e_imprimir
        MOV     BX,0010
        DIV     BX
        ;MOV     [extra],AH
        PUSH    DX
        INC     SI
        MOV     BX,AX
        ;imprimir saltoLinea
        ;imprimir extra
        JMP     continuar

    leer_e_imprimir:
        XOR     AX,AX
        CMP     SI,0
        JE      salir_imp_num16
        POP     AX
        ADD     AL,30h
        MOV     [extra],AL
       ; imprimir extra
        escribirArchivo extra,1,handler_pn
        DEC     SI
        JMP     leer_e_imprimir
        
    salir_imp_num16:
        MOV     SI,[tmp_SI]
        MOV     [extra],0
       ; CMP     [NUM],652
       ; JE      imprimirMenu
ENDM
;==============MACRO QUE LEE EL ARCH. OP.TXT PARA RECUPERAR C/U OPERACIONES Y GENERAR SU ARBOL
RECUPERAR_OPERACIONES MACRO array_pivote, handler_arcOP, text_Pivote
   LOCAL leer_OP, cerrarA_OP     ;LE INDICAMOS QUE ETIQUETAS SON LOCALES DE LA MACRO
   XOR      SI,SI
   leer_OP:
        MOV     AH,3fh
        MOV     BX,handler_arcOP
        XOR     DX,DX
        MOV     dx,offset text_Pivote
        MOV     CX, 1
        INT     21h
        JC      errorLeerArchivo 
        CMP     AX,0
        JZ      cerrarA_OP
        CMP     [text_Pivote],0Ah     ;retorno carry
        JE      encontro_salto
        CMP     [text_Pivote],0Dh       ;salto linea
        JE      leer_OP
        ;imprimir text_Pivote
        MOV     DH,[text_Pivote]
        MOV     [array_pivote[SI]],DH
        INC     SI
        JMP     leer_OP

    encontro_salto:
        ;imprimir saltoLinea 
       ; imprimir array_pivote
        Actualizar_Array_Pivote Pivote_Operacion, Operacion_Array, textoArchivo
       ; imprimir Pivote_Operacion
        XOR     SI,SI
        MOV     [IsOperatorAritmetic],0
        Ord_Precedencia Pivote_Operacion,Array_Precedencia, texto_P_Operacion
        ;imprimir Array_Precedencia
        ;---------- MANDAMOS EL ARRAY PRECEDENCIA A LA MACRO QUE RECORRE Y GUARDA EN ARBOL ------
        ;imprimir saltoLinea
        CREAR_ARBOL Array_Precedencia, texto_P_Operacion
        ;----------------------------------------------------------------------------------------
        BORRAR_ARREGLO_16bits Array_Precedencia
        BORRAR_ARREGLO_16bits Pila_Operadores
        BORRAR_ARREGLO_16bits Pivote_Operacion
        BORRAR_ARREGLO array_pivote
        XOR     SI,SI
        JMP     leer_OP


    cerrarA_OP:
        MOV     [IsOperatorAritmetic],0
        cerrarArchivo handler_arcOP
        MOV     [cont_Arch],0
        imprimir saltoLinea
        ;JMP imprimirMenu
ENDM

CREAR_ARBOL MACRO   ARRAY_PREC, texto
    XOR     SI,SI
    XOR     BX,BX
    recorrer:
        CMP     [ARRAY_PREC[SI]],2424h
        JE      recorrer_inverso
        ADD     SI,2
        JMP     recorrer

    decrementar_uno:
        SUB     SI,2
        JMP     recorrer_inverso

    recorrer_inverso:
        XOR     BX,BX 
        SUB     SI,2
        MOV     BX,[ARRAY_PREC[SI]]
        MOV     [texto],BX
        ;----aqui se debe llamar a la macro que lo va a colocar en el arbol------
        XOR     DI,DI
        MOV     inodo_arbol,0
        COLCOAR_ARBOL inodo_arbol,texto
        MOV     [if_colocado],0
        ;-----------------------------------------------------------------------
        ;imprimir texto
        CMP     SI,0000
        JE      salir_crear_arbol
        JMP     recorrer_inverso
    
    salir_crear_arbol:
        ;imprimir text6
        imprimir saltoLinea
        ;-----------------------crea el archivo dot y lo abre -------------------
        XOR     BL,BL
        MOV     BL,[cont_Arch]
        ADD     BL,30h
        MOV     [path_arbol[6]],BL
        XOR     BL,BL
        crearArchivo path_arbol,handler_arbol
        cerrarArchivo handler_arbol
        abrirArchivo 3D01h,path_arbol,handler_arbol
        escribirArchivo digraph,12,handler_arbol
        ;------------------------------------------------------------------------
        imprimir arbol
        imprimir saltoLinea
        XOR     DI,DI
        MOV     [inodo_arbol],0
        IMPRIMIR_ARBOL_ETIQUETAS arbol, handler_arbol, inodo_arbol
        MOV     [inodo_arbol],0
        IMPRIMIR_ARBOL arbol,handler_arbol,inodo_arbol
        ;------------------------cierra el archivo dot----------------------------
        escribirArchivo cierredigraph,3,handler_arbol
        cerrarArchivo handler_arbol
        ;-------------------------------------------------------------------------
        INC     [cont_Arch]
        Limpiar_Arbol arbol
       ; JMP     imprimirMenu
ENDM

COLCOAR_ARBOL MACRO POS_CONTADOR, DATO
    LOCAL colocar_dato, IR_NODOS, validar_nodo0,salir_colocar_arbol
    inicio_todo:
    MOV     DI,[POS_CONTADOR]

    CMP     [arbol[DI]],00h
    JE      colocar_dato
    XOR     BX,BX
    MOV     BX,[arbol[DI]]
    MOV     [tmp_extra_dato],BX
    ES_OPERADOR_ARITMETICO_16bits tmp_extra_dato
    CMP     [IsOperatorAritmetic],1
    JE      IR_NODOS
    JMP     validar_nodo0


    colocar_dato:
        XOR     BX,BX
        MOV     [if_colocado],1
        MOV     BX,[DATO]
        MOV     [arbol[DI]],BX
        JMP     validar_nodo0


    IR_NODOS:
        MOV     [IsOperatorAritmetic],0
    ;----primero visita el nodo derecho
        PUSH    DI
        XOR     AX,AX
        MOV     AX,DI
        MOV     AH,2
        ;MOV     DI,2*DI+2
        MUL     AH
        MOV     DI,AX
        ADD     DI,4
        MOV     [POS_CONTADOR],DI
        CALL    inicio_todo
        POP     DI
        MOV     [POS_CONTADOR],DI
        CMP     [if_colocado],1
        JE      validar_nodo0
        PUSH    DI
        XOR     AX,AX
        MOV     AX,DI
        MOV     AH,2
        MUL     AH
        MOV     DI,AX
        ADD     DI,2
        MOV     [POS_CONTADOR],DI
   ;     MOV     [POS_CONTADOR],(2*DI+1)
    ;    COLCOAR_ARBOL POS_CONTADOR,DATO
        CALL    inicio_todo
        POP     DI
        MOV     [POS_CONTADOR],DI
        CMP     [if_colocado],1
        JE      validar_nodo0
        JMP     validar_nodo0
    ;----luego visita el nodo derecho

    validar_nodo0:
        CMP     DI,00
        JE      salir_full
        ;POP     DI
        ;MOV     [POS_CONTADOR],DI
        JMP     salir_colocar_arbol

    salir_colocar_arbol:
        RET
    salir_full:
ENDM
;=============== MACRO QUE LIMPIA EL ARBOL ========================
Limpiar_Arbol MACRO cadena_arbol
    LOCAL limpiar
    XOR     DI,DI
    limpiar:
        MOV     cadena_arbol[DI],00h
        ADD     DI,2
        CMP     DI,60
        JB      limpiar
    XOR     DI,DI
ENDM
;============== MACRO QUE IMPRIME EL ARBOL EN EL ARCHIVO============
IMPRIMIR_ARBOL MACRO arbol_array, handler_delArbol,pos_cont_nodo
   LOCAL inicio_todo_impresion, es_operador,es_num,validar_fin_escritura,salir_visito_nodo,salir_full_impresion
    inicio_todo_impresion:
    ;imprimir text6
    MOV     DI,[pos_cont_nodo]
    
    XOR     BX,BX
    MOV     BX,[arbol_array[DI]]
    CMP     BX,00                        ;salir
    JE      validar_fin_escritura
    MOV     texto_P_Operacion,BX 
    ES_OPERADOR_ARITMETICO_16bits texto_P_Operacion
    CMP     [IsOperatorAritmetic],1
    JE      es_operador
    JMP     es_num
    ;imprimir texto_P_Operacion
    ;ADD     DI,2

    es_operador:
        MOV     [IsOperatorAritmetic],0
       ; escribirArchivo label_etiqueta,6,handler_delArbol
       escribirArchivo label_etiqueta,5,handler_delArbol
       MOV      [num_etiqueta],DI
       IMPRIMIR_NUM16BITS_V3 num_etiqueta,handler_delArbol
       escribirArchivo enlazador,2,handler_delArbol
        ;JMP     salir_full_impresion
       ;--------visita nodo derecho-----------------------
        PUSH    DI
        XOR     AX,AX
        MOV     AX,DI
        MOV     AH,2
        ;MOV     DI,2*DI+2
        MUL     AH
        MOV     DI,AX
        ADD     DI,4
        MOV     [pos_cont_nodo],DI
        CALL    inicio_todo_impresion
        POP     DI
        MOV     [pos_cont_nodo],DI
        XOR     BX,BX
        MOV     BX,[arbol_array[DI]]
        MOV     texto_P_Operacion,BX
       escribirArchivo label_etiqueta,5,handler_delArbol
       MOV      [num_etiqueta],DI
       IMPRIMIR_NUM16BITS_V3 num_etiqueta,handler_delArbol
       escribirArchivo enlazador,2,handler_delArbol        
        ;--------------visita nodo izquierdo --------------
        PUSH    DI
        XOR     AX,AX
        MOV     AX,DI
        MOV     AH,2
        MUL     AH
        MOV     DI,AX
        ADD     DI,2
        MOV     [pos_cont_nodo],DI
   ;     MOV     [POS_CONTADOR],(2*DI+1)
    ;    COLCOAR_ARBOL POS_CONTADOR,DATO
        CALL    inicio_todo_impresion
        POP     DI
        MOV     [pos_cont_nodo],DI
        JMP     validar_fin_escritura


    es_num:
       escribirArchivo label_etiqueta,5,handler_delArbol
       MOV      [num_etiqueta],DI
       IMPRIMIR_NUM16BITS_V3 num_etiqueta,handler_delArbol
       escribirArchivo saltoLinea,2,handler_delArbol
       JMP     validar_fin_escritura

    validar_fin_escritura:
        CMP     DI,00
        JE      salir_full_impresion
        JMP     salir_visito_nodo

    salir_visito_nodo:
        RET
    salir_full_impresion:
ENDM
;=========== IMPRIME LAS ETIQUETAS DEL ARBOL ==========================
IMPRIMIR_ARBOL_ETIQUETAS MACRO arbol_array, handler_delArbol,pos_cont_nodo
   LOCAL inicio_todo_impresion, es_operador,es_num,validar_fin_escritura,salir_visito_nodo,salir_full_impresion
    inicio_todo_impresion:
    ;imprimir text6
    MOV     DI,[pos_cont_nodo]
    
    XOR     BX,BX
    MOV     BX,[arbol_array[DI]]
    CMP     BX,00                        ;salir
    JE      validar_fin_escritura
    MOV     texto_P_Operacion,BX 
    ES_OPERADOR_ARITMETICO_16bits texto_P_Operacion
    CMP     [IsOperatorAritmetic],1
    JE      es_operador
    JMP     es_num
    ;imprimir texto_P_Operacion
    ;ADD     DI,2

    es_operador:
        MOV     [IsOperatorAritmetic],0
       ; escribirArchivo label_etiqueta,6,handler_delArbol
        escribirArchivo label_etiqueta,5,handler_delArbol
        MOV     [num_etiqueta],DI
        IMPRIMIR_NUM16BITS_V3 num_etiqueta,handler_delArbol
        escribirArchivo label_abierto,8,handler_delArbol
        escribirArchivo texto_P_Operacion,1,handler_delArbol
        escribirArchivo label_cerrado,4,handler_delArbol
        ;JMP     salir_full_impresion
       ;--------visita nodo derecho-----------------------
        PUSH    DI
        XOR     AX,AX
        MOV     AX,DI
        MOV     AH,2
        ;MOV     DI,2*DI+2
        MUL     AH
        MOV     DI,AX
        ADD     DI,4
        MOV     [pos_cont_nodo],DI
        CALL    inicio_todo_impresion
        POP     DI
        MOV     [pos_cont_nodo],DI
        XOR     BX,BX
        MOV     BX,[arbol_array[DI]]
        MOV     texto_P_Operacion,BX
       ; escribirArchivo label_etiqueta,5,handler_delArbol
       ; MOV     [num_etiqueta],DI
       ; IMPRIMIR_NUM16BITS_V3 num_etiqueta,handler_delArbol
       ; escribirArchivo label_abierto,8,handler_delArbol
       ; escribirArchivo texto_P_Operacion,2,handler_delArbol
       ; escribirArchivo label_cerrado,4,handler_delArbol
        ;--------------visita nodo izquierdo --------------
        PUSH    DI
        XOR     AX,AX
        MOV     AX,DI
        MOV     AH,2
        MUL     AH
        MOV     DI,AX
        ADD     DI,2
        MOV     [pos_cont_nodo],DI
   ;     MOV     [POS_CONTADOR],(2*DI+1)
    ;    COLCOAR_ARBOL POS_CONTADOR,DATO
        CALL    inicio_todo_impresion
        POP     DI
        MOV     [pos_cont_nodo],DI
        JMP     validar_fin_escritura


    es_num:
        escribirArchivo label_etiqueta,5,handler_delArbol
        MOV     [num_etiqueta],DI
        IMPRIMIR_NUM16BITS_V3 num_etiqueta,handler_delArbol
        escribirArchivo label_abierto,8,handler_delArbol
        IMPRIMIR_NUM16BITS_V3 texto_P_Operacion,handler_delArbol
        escribirArchivo label_cerrado,4,handler_delArbol
     ;   escribirArchivo label_etiqueta,6,handler_delArbol
        JMP     validar_fin_escritura

    validar_fin_escritura:
        CMP     DI,00
        JE      salir_full_impresion
        JMP     salir_visito_nodo

    salir_visito_nodo:
        RET
    salir_full_impresion:
ENDM