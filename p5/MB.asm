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
;=========== MACRO QUE CAPTURA UNA CADENA ========================
capturarCadena MACRO cadena
    LOCAL capturar, terminar_captura
    MOV     AH,1
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
;============================= CREAR ARCHIVO ==========================
crearArchivo MACRO pArchivo,hArchivo
    LOCAL       errorCrearArchivo, salir_crear_archivo
        MOV     AH,3Ch
        MOV     CX,0                       
        MOV     DX,offset pArchivo
        INT     21h
        JC      errorCrearArchivo   
        MOV     hArchivo,AX
        JMP     salir_crear_archivo

        errorCrearArchivo:
           ; imprimir saltoLinea
            imprimir errorCA
            JMP     imprimirMenu

        salir_crear_archivo:
ENDM
;========================================================================
;ABRE UN ARCHIVO EN EL MODO QUE SE LE INDIQUE, LA RUTA DEL ARCHIVO Y EL HANDLER DEL ARCHIVO 
;AH:3DH
;AL:0 READ, 1 WRITE, 2 READ/WRITE
;AHAL=AX
abrirArchivo MACRO modo,pArchivo2,hAr4
    LOCAL errorAbrirArchivo, salir_abrir_archivo
       MOV      AX,modo
       MOV      DX, offset pArchivo2                
       INT      21h
       JC       errorAbrirArchivo
       MOV      hAr4,AX
       JMP      salir_abrir_archivo

       errorAbrirArchivo:
           ; imprimir saltoLinea
            imprimir errorAA
            JMP     imprimirMenu

       salir_abrir_archivo:
ENDM
;=======================ESCRIBIR EN UN ARCHIVO==========================
escribirArchivo MACRO texto,cant,hArc
    LOCAL errorEscribirArchivoPivote, salir_escritura_archivo
        MOV     AH, 40h
        MOV     BX, hArc
        MOV     CX, cant
        MOV     DX, offset texto 
        INT     21h
        JC      errorEscribirArchivoPivote  
        JMP     salir_escritura_archivo

        errorEscribirArchivoPivote:
            ;imprimir saltoLinea
            imprimir errorEA
            JMP     imprimirMenu

        salir_escritura_archivo:
ENDM 
;============================= CERRAR ARCHIVO =========================
cerrarArchivo MACRO hcerrarA
    MOV     AH,3eh
    MOV     BX,hcerrarA
    INT     21h
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
;======================== RECUPERAR VALOR ARCHIVO ======================
;es igual al metodo de leer archivo pero en vez de recuperar hasta fin del
;archivo, recupera valor por valor y la cantidad de bytes especificado
REC_VALOR_ARCHIVO MACRO  ubicacion_variable , hArchivo, cant_bytes
    LOCAL   errorLeerArchivo, salir_recuperar_archivo

        MOV     AH,3fh
        MOV     BX,hArchivo
        XOR     DX,DX
        MOV     dx,offset ubicacion_variable
        MOV     CX, cant_bytes
        INT     21h
        JC      errorLeerArchivo 
        JMP     salir_recuperar_archivo
    
    errorLeerArchivo:
       ; imprimir saltoLinea
        imprimir errorLA
        JMP     imprimirMenu

    salir_recuperar_archivo:
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
;================ MACRO QUE VERIFICA PASSWORD Y CONTRASEÑA==============
VALIDAR_USUARIO MACRO P_USUARIO,S_USUARIO
    LOCAL es_usuario_Administador, es_otro_usuario, salir_validar_usuario
    MOV     [Array_iguales],0
    ;--primero se valida el nombre de usuario sea correcto
    COMPARAR_ARREGLOS P_USUARIO.nombre_usuario,S_USUARIO.nombre_usuario,30
    CMP     [Array_iguales],1
    JE      salir_validar_usuario
    ;--segundo se valida el password sea correcto, llegara aqui unicamente
    ;--si el nombre usuario es correcto
    COMPARAR_ARREGLOS P_USUARIO.password, S_USUARIO.password,30
    CMP     [Array_iguales],1
    JE      salir_validar_usuario
    ;--si llega aqui el usuario es correcto, ahora se valida si el usuario
    ;--es el administrador
    CMP     SI,1
    JE      es_usuario_Administador
    ;--en caso contrario es otro usuario
    JMP     es_otro_usuario

    es_usuario_Administador:
        OP_ADMINISTRADOR
        JMP     encontro_usuario

    es_otro_usuario:
        SELECT_PAGE 01d
        ;XOR     BX,BX
        ;MOV     BL,[US2.puntos]
        ;MOV     punteo_juego,BL
        MOV      [punteo_juego],0
        MOV      [tiempo_juego],0
        INICIO_JUEGO
        ;--------------ACTUALIZAMOS DATOS USUARIOS -------
        XOR     BX,BX
        MOV     BL,[punteo_juego]
        MOV     [US2.puntos],BL
        XOR     BX,BX
        MOV     BL,[tiempo_juego]
        MOV     [US2.tiempo],BL
        XOR     BX,BX
        MOV     BL,[nivel_juego]
        MOV     [US2.nivel],BL
        posicionarPuntero handler_usuarios,ubicacion_puntero
        escribirArchivo US2,63,handler_usuarios
        ;-------------------------------------------------
        MOV     [posy_tablero],35
        MOV     [tmp_posx],0
        MOV     [posx_pelota1],17
        MOV     [posy_pelota1],37
        MOV     [bandera_arriba_abajo],1
        MOV     [bandera_izquierda_derecha],0
        MOV     [posx_bloque],0
        MOV     [posy_bloque],0
        MOV     [tiempo_retardo],65530
        MOV     [nivel_juego],1
        BORRAR_ARREGLO_16bits bloques
        SELECT_PAGE 00d
        JMP     encontro_usuario
    
    salir_validar_usuario:
        MOV     [Array_iguales],0
ENDM
;========================= MENU Y OPCIONES ADMINISTRADOR ==================
OP_ADMINISTRADOR MACRO
    LOCAL opcion1, opcion2, opcion3, intento_op, opcion_no_valida, salir_op_administrador
    intento_op:
       ; imprimir saltoLinea
        imprimir msg_separador
        imprimir msg12
        imprimir msg11
        XOR     AX,AX
        MOV     AH,01h
        INT     21h
        SUB     AL,30h
        CMP     AL,1
        JE      opcion1
        CMP     AL,2
        JE      opcion2
        CMP     AL,3
        JE      opcion3
        JMP     opcion_no_valida

    opcion_no_valida:
        imprimir errorNumero
        JMP     intento_op

    opcion1:
        imprimir saltoLinea
        imprimir msg_puntos
        ;------------ CREAR Y ABRIR ARCHIVO PUNTOS ----------------
        crearArchivo path_puntos, handler_puntos
        cerrarArchivo handler_puntos
        abrirArchivo 3D01h,path_puntos,handler_puntos
        escribirArchivo msg_puntos,53,handler_puntos
        escribirArchivo saltoLinea,2,handler_puntos
        ;----------------------------------------------------------
        XOR     SI,SI
        MOV     [ubicacion_puntero],127
        ADD     SI,2
        posicionarPuntero handler_usuarios,ubicacion_puntero
        lectura_puntos:
            REC_VALOR_ARCHIVO US2,handler_usuarios,63
            imprimir saltoLinea
            imprimir US2.nombre_usuario
            imprimir tabulacionLinea
            ;------------------ESCRIBIR ARCHIVO PUNTOS----------------
            escribirArchivo saltoLinea,2,handler_puntos
            CANTIDAD_NOMBRE handler_puntos
            ;escribirArchivo US2.nombre_usuario,cant_nombre,handler_puntos
            escribirArchivo tabulacionLinea,3,handler_puntos
            ;---------------------------------------------------------
            XOR     BX,BX
            MOV     BL,[US2.nivel]
            MOV     [tmp_num_16_8bits],BX
            IMPRIMIR_NUM16BITS_V2 tmp_num_16_8bits
            imprimir tabulacionLinea
            ;--------------- ESCRIBIR ARCHIVO PUNTOS --------------------
            IMPRIMIR_NUM16BITS_V3 tmp_num_16_8bits,handler_puntos
            escribirArchivo tabulacionLinea,3,handler_puntos
            ;------------------------------------------------------------
            XOR     BX,BX
            MOV     BL,[US2.puntos]
            MOV     [tmp_num_16_8bits],BX
            IMPRIMIR_NUM16BITS_V2 tmp_num_16_8bits
            ;-----------------ESCRIBIR ARCHIVO PUNTOS -------------------
            IMPRIMIR_NUM16BITS_V3 tmp_num_16_8bits,handler_puntos
            ;escribirArchivo tabulacionLinea,3,handler_puntos
            ;------------------------------------------------------------
            CMP     SI,[tmp_cont_usuarios]
            JE      salir_lectura_puntos
            INC     SI
            JMP     lectura_puntos
        ;----
        salir_lectura_puntos:
        cerrarArchivo handler_puntos
        imprimir saltoLinea
        imprimir msg_separador
        JMP     salir_op_administrador

    opcion2:
        imprimir saltoLinea
        imprimir msg_tiempo
        ;------------------- SE CREA ARCHIVO TIEMPO -----------
        crearArchivo path_tiempo,handler_tiempo
        cerrarArchivo handler_tiempo
        abrirArchivo 3D01h,path_tiempo,handler_tiempo
        escribirArchivo msg_tiempo,53,handler_tiempo
        escribirArchivo saltoLinea,2,handler_tiempo
        ;------------------------------------------------------
        XOR     SI,SI
        MOV     [ubicacion_puntero],127
        ADD     SI,2
        posicionarPuntero handler_usuarios, ubicacion_puntero
        lectura_tiempo:
            REC_VALOR_ARCHIVO US2,handler_usuarios,63
            imprimir saltoLinea
            imprimir US2.nombre_usuario
            imprimir tabulacionLinea
            ;----------------- ESCRIBIR ARCHIVO TIEMPO ----------------
            escribirArchivo saltoLinea,2,handler_tiempo
            CANTIDAD_NOMBRE handler_tiempo
            escribirArchivo tabulacionLinea,3,handler_tiempo
            ;----------------------------------------------------------
            XOR     BX,BX
            MOV     BL,[US2.nivel]
            MOV     [tmp_num_16_8bits],BX
            IMPRIMIR_NUM16BITS_V2 tmp_num_16_8bits
            imprimir tabulacionLinea
            ;--------------- ESCRIBIR ARCHIVO TIEMPO -------------------
            IMPRIMIR_NUM16BITS_V3 tmp_num_16_8bits,handler_tiempo
            escribirArchivo tabulacionLinea,3,handler_tiempo
            ;-----------------------------------------------------------
            XOR     BX,BX
            MOV     BL,[US2.tiempo]
            MOV     [tmp_num_16_8bits],BX
            IMPRIMIR_NUM16BITS_V2 tmp_num_16_8bits
            ;--------------- ESCRIBIR ARCHIVO TIEMPO -------------------
            IMPRIMIR_NUM16BITS_V3 tmp_num_16_8bits,handler_tiempo
            ;-----------------------------------------------------------
            CMP     SI,[tmp_cont_usuarios]
            JE      salir_lectura_tiempo
            INC     SI
            JMP     lectura_tiempo
        ;-------------------------------------------------------
        salir_lectura_tiempo:
        cerrarArchivo handler_tiempo
        imprimir saltoLinea
        imprimir msg_separador
        JMP     salir_op_administrador

    opcion3:
        imprimir saltoLinea
        imprimir msg_separador
        JMP     salir_op_administrador

    salir_op_administrador:
       ; imprimir saltoLinea
       ; imprimir msg_separador
ENDM
;==================== MACRO DONDE INICIA EL JUEGO ==========================
INICIO_JUEGO MACRO
    ;-----
     ;------- limpia la pantalla de la pagina 01d ------------
     XOR    SI,SI
     MOV    SI,24
     MOV    [tmp_posx],0
     limpiar_pantalla:
        imprimir_xy vacio,tmp_posx,0,79,0Ah
        INC     [tmp_posx]
        DEC     SI
        CMP     SI,0
        JNE     limpiar_pantalla
    ;---------imprime nombre usuario,tiempo,nivel,puntos ---------
    POSICIONAR_PUNTERO_GRAFICO 3,4
    imprimir US2.nombre_usuario
    ;--------imprime marco y barra ---------------------------
     imprimir_xy marco,4,4,71,0Ah
     imprimir_xy tablero,18,posy_tablero,5,03h
     XOR    SI,SI
     MOV    SI,16
     MOV    [tmp_posx],4
     colocar_marco_lateral:
        imprimir_xy marco,tmp_posx,4,1,0Ah
        imprimir_xy marco,tmp_posx,75,1,0Ah
        INC     [tmp_posx] 
        DEC     SI
        CMP     SI,0
        JNE     colocar_marco_lateral
     
     imprimir_xy marco,20,4,71,0Ah
     LLENAR_BLOQUES_PRIMER_NIVEL
     COLOCAR_BLOQUES
     imprimir_xy pelota,posx_pelota1,posy_pelota1,1,0Eh
     ;---------------- ESPERA INICIO --------------------
     ESPERA_INICIO:
        MOV     AH,01h
        INT     16h
        JZ      ESPERA_INICIO
        MOV     AH,00h
        INT     16h
        CMP     AH,[espacio]
        JE      LOOP_JUEGO
        JMP     ESPERA_INICIO
     ;-------------LOOP JUEGO ---------------------------
     LOOP_JUEGO:   
        
        PRESIONO_TECLA
        MOVIMIENTO_PELOTA
        ;-------------IMPRIME EL NIVEL EN EL CUAL ESTA ----
        POSICIONAR_PUNTERO_GRAFICO 3,21
        XOR     BX,BX
        MOV     BL,[nivel_juego]
        MOV     [tmp_num_16_8bits],BX
        IMPRIMIR_NUM16BITS_V2 tmp_num_16_8bits
        ;--------------------------------------------------
        CMP     [nivel_juego],1
        JE      nivel_uno
        CMP     [nivel_juego],2
        JE      nivel_dos
        CMP     [nivel_juego],3
        JE      nivel_tres

        nivel_uno:
            MOV     [tiempo_retardo],65530
            JMP     continuar_juego

        nivel_dos:
            MOV     [tiempo_retardo],50530
            JMP     continuar_juego

        nivel_tres:
            MOV     [tiempo_retardo],40530
            JMP     continuar_juego
        
        ;probando tiempo
        ;MOV     AH,00H
        ;INT     1ah
    continuar_juego:
        XOR     BX,BX
       ; MOV     BX,65530
        MOV     BX,[tiempo_retardo]
       
       TIEMPO_ESPERA2:
            DEC     BX
            CMP     BX,0
            JNE     TIEMPO_ESPERA2

        ;MOV     BX,65530
        MOV     BX,[tiempo_retardo]
        TIMEPO_ESPERA1:
            DEC     BX
            CMP     BX,0
            JNE     TIMEPO_ESPERA1

        CMP     [tmp_tiempo_verificacion],00020
        JE      mostrar_tiempo
        JMP     aumentar_t_continuar
    
    mostrar_tiempo:
        MOV     [tmp_tiempo_verificacion],0000
        INC     [tiempo_juego]
        ;MOV     [tiempo_juego],1
        XOR     BX,BX
        MOV     BL,[tiempo_juego]
        MOV     [tmp_num_16_8bits],BX
        POSICIONAR_PUNTERO_GRAFICO 3,55
        IMPRIMIR_NUM16BITS_V2 tmp_num_16_8bits
        JMP     aumentar_t_continuar
    
    aumentar_t_continuar:
       INC     [tmp_tiempo_verificacion]  
     
    JMP  LOOP_JUEGO 
     ;-------------- FIN LOOP JUEGO ---------------------
     salir_juego:
     
    ; desplazar_xy  
    
    ;-----
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
;============= IMPRIME UN NUMERO 16 BITS ====================================
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
;====================ESCRIBE EL NOMBRE USUARIO EN ARCHIVO CON SUS BYTES CORRECTOS ==============
CANTIDAD_NOMBRE MACRO handler_archivo
    LOCAL       verificar_cantidad, salir_cantidad_nombre
    XOR     DI,DI
 ;   MOV     [cant_nombre],0
    verificar_cantidad:
        CMP     [US2.nombre_usuario[DI]],24h
        JE      salir_cantidad_nombre
        XOR     BX,BX
        MOV     BL,[US2.nombre_usuario[DI]]
        MOV     [tmp_letranombre],BL
        escribirArchivo tmp_letranombre,1,handler_archivo
       ; INC     [cant_nombre]
        INC     DI
        JMP     verificar_cantidad

    salir_cantidad_nombre:
ENDM
;==================== ESCRIBE EN UN ARCHIVO UN NUMERO CON BYTES ESPECIFICADOS ==================
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
;==================== MACROS DEL JUEGO ======================================
imprimir_xy MACRO escribir,x,y,repeticion,atributo
        ;este codigo posiciona el curso 
        ;selecciona el tipo de pagina
        ;SELECT_PAGE 01d
        ;posiciona el curso
        MOV     dh, x
        MOV     dl, y          
        MOV     bh, 01d        
        MOV     ah, 02h
        INT     10h
        ;escribe caracter en pantalla con cantidad
        ;de repeticiones
        MOV     ah,09h
        MOV     al,[escribir]
        MOV     BH,01d
        MOV     BL,atributo
        MOV     CX,repeticion
        INT     10h
        
        ;MOV     ah,9                                    
        ;LEA     dx,escribir
        ;INT     21h 
       ; MOV     AH,05H
       ; MOV     AL,00d
       ; INT     10h
ENDM 
    ;desplaza la cantidad de lineas que querramos
desplazar_xy MACRO
        MOV     AH,06h
        MOV     AL,4
        MOV     BH,7
        MOV     CH,15
        MOV     CL,10
        MOV     DH,24
        MOV     DL,79
        INT     10h
ENDM    
    
POSICIONAR_PUNTERO_GRAFICO MACRO x,y 
        MOV     dh, x
        MOV     dl, y          
        MOV     bh, 01d        
        MOV     ah, 02h
        INT     10h        
ENDM
    
SELECT_PAGE MACRO NUMP
        MOV     AH,05H
        MOV     AL,NUMP
        INT     10h 
ENDM  
    
PRESIONO_TECLA MACRO     
        LOCAL tecla_izquierda,mover_iz_tablero,tecla_derecha,mover_der_tablero,juego_pausado;,salir_precedencia
        LOCAL   cambiar_nivel1, cambiar_nivel2, cambiar_nivel3, salir_presiono_tecla
        MOV     AH,01h
        INT     16h
        JZ      salir_presiono_tecla
        
        MOV     AH,00h
        INT     16h
        
        CMP     AH,left
        JE      tecla_izquierda
        CMP     AH,rigth
        JE      tecla_derecha 
        CMP     AH,escape
        JE      juego_pausado
        JMP     salir_presiono_tecla
        
        tecla_izquierda:
            ;POSICIONAR_PUNTERO_GRAFICO 3,4
            ;imprimir iz 
            imprimir_xy vacio,18,posy_tablero,5,03h
            SUB     [posy_tablero],3
            CMP     posy_tablero,5
            JA      mover_iz_tablero
            MOV     [posy_tablero],5
            mover_iz_tablero:
            imprimir_xy tablero,18,posy_tablero,5,03h
            JMP     salir_presiono_tecla
        
        tecla_derecha:
            ;POSICIONAR_PUNTERO_GRAFICO 3,21
            ;imprimir dr 
            imprimir_xy vacio,18,posy_tablero,5,03h
            ADD     [posy_tablero],3  
            CMP     [posy_tablero],70
            JB      mover_der_tablero
            MOV     [posy_tablero],70
            mover_der_tablero:
            imprimir_xy tablero,18,posy_tablero,5,03h
            JMP     salir_presiono_tecla 
            
        juego_pausado: 
            MOV     AH,01h
            INT     16h
            JZ      juego_pausado
            MOV     AH,00h
            INT     16h
            CMP     AH,espacio
            JE      salir_juego
            CMP     AH,02h;31h
            JE      cambiar_nivel1
            CMP     AH,03h;32h
            JE      cambiar_nivel2
            CMP     AH,04h
            JE      cambiar_nivel3
            CMP     AH,[escape]
            JE      salir_presiono_tecla
            JMP     juego_pausado

            cambiar_nivel1:
                MOV     [nivel_juego],1
                JMP     salir_presiono_tecla
            cambiar_nivel2:
                MOV     [nivel_juego],2
                JMP     salir_presiono_tecla
            cambiar_nivel3:
                MOV     [nivel_juego],3
                JMP     salir_presiono_tecla
            JMP     juego_pausado
        
        salir_presiono_tecla:
ENDM
;---
MOVIMIENTO_PELOTA MACRO
        
        CMP     [bandera_arriba_abajo],1
        JE      pelota_arriba
        JMP     pelota_abajo
        
        
        pelota_arriba:
            CMP     [bandera_izquierda_derecha],1
            JE      pelota_arriba_izquierda
            JMP     pelota_arriba_derecha
            
        
        pelota_abajo:
            CMP     [bandera_izquierda_derecha],1
            JE      pelota_abajo_izquierda
            JMP     pelota_abajo_derecha
            
            
        pelota_arriba_izquierda:
            imprimir_xy vacio,posx_pelota1,posy_pelota1,1,0Eh
            DEC     [posx_pelota1]
            DEC     [posy_pelota1]
            JMP     restricciones_posicion_pelota
        
        pelota_arriba_derecha:
            imprimir_xy vacio,posx_pelota1,posy_pelota1,1,0Eh
            DEC     [posx_pelota1]
            INC     [posy_pelota1] 
            JMP     restricciones_posicion_pelota
        
        pelota_abajo_izquierda:
            imprimir_xy vacio,posx_pelota1,posy_pelota1,1,0Eh
            INC     [posx_pelota1]
            DEC     [posy_pelota1]
            JMP     restricciones_posicion_pelota
        
        pelota_abajo_derecha:
            imprimir_xy vacio,posx_pelota1,posy_pelota1,1,0Eh
            INC     [posx_pelota1]
            INC     [posy_pelota1]
            JMP     restricciones_posicion_pelota
        
        
        restricciones_posicion_pelota: 
            CMP     [posx_pelota1],6
            JB      restriccion1
            CMP     [posx_pelota1],17
            JE      restriccion2  ;74 
            CMP     [posy_pelota1],73
            JA      restriccion3  
            CMP     [posy_pelota1],6
            JB      restriccion4
            JMP     repintar_pelota 
            
        restriccion1:;esta restriccion valida que no se pase del margen superior
            MOV     [posx_pelota1],5
            DEC     [posy_pelota1]
            MOV     [bandera_arriba_abajo],0
            JMP     repintar_pelota
            
        restriccion2:;valida cuando toca la barra
            XOR     BX,BX
            MOV     BL,[posy_pelota1]
            CMP     [posy_tablero],BL
            JA      salir_juego 
            MOV     BH,[posy_tablero]
            ADD     BH,5
            CMP     BH,BL
            JB      salir_juego
            MOV     [bandera_arriba_abajo],1
            JMP     repintar_pelota
            
        restriccion3:;cuando toca la barra derecha
            MOV     [posy_pelota1],74
            ;INC     [posx_pelota1]
            DEC     [posx_pelota1]
            MOV     [bandera_izquierda_derecha],1
            JMP     repintar_pelota
            
        restriccion4:;cuando toca la barra izquierda
            MOV     [posy_pelota1],5
            INC     [posx_pelota1]
            MOV     [bandera_izquierda_derecha],0
            JMP     repintar_pelota
                    
        
        repintar_pelota:
            ;imprimir_xy vacio,posx_pelota1,posy_pelota1,1,0Eh
            ;DEC     [posx_pelota1]
            imprimir_xy pelota,posx_pelota1,posy_pelota1,1,0Eh
            VALIDAR_CHOQUES_BLOQUESPN
ENDM
;---010000
LLENAR_BLOQUES_PRIMER_NIVEL MACRO
        XOR     SI,SI
        XOR     BX,BX
        
        MOV     BH,9
        MOV     BL,10;con cual valor empieza en pos_y
        llenar_primeros:
            MOV     [bloques[SI]],BX
            ADD     BL,5
            ADD     SI,4
            CMP     SI,48
            JNE     llenar_primeros
        
        XOR     SI,SI
        XOR     BX,BX 
        MOV     SI,2
        MOV     BH,7
        MOV     BL,15   
        
        llenar_segundos:
            MOV     [bloques[SI]],BX
            ADD     BL,5
            ADD     SI,4
            CMP     SI,46
            JNE     llenar_segundos 
            
        XOR SI,SI
        XOR BX,BX
ENDM 
    
COLOCAR_BLOQUES MACRO 
        XOR     BX,BX
        XOR     SI,SI
        colocar:
            MOV     BX,[bloques[SI]]
            CMP     BX,2424h
            JE      salir_colocar_bloques
            MOV     [posx_bloque],BH
            MOV     [posy_bloque],BL
            imprimir_xy bloque,posx_bloque,posy_bloque,1,0Ah 
            ADD     SI,2
            JMP     colocar
            
       salir_colocar_bloques: 
ENDM 
                                    
VALIDAR_CHOQUES_BLOQUESPN MACRO
        XOR     BX,BX
        XOR     SI,SI
        verificar:
            MOV     BX,[bloques[SI]]
            CMP     BX,2424h
            JE      salir_validar_choques_bloquesPN
            MOV     [posx_bloque],BH
            MOV     [posy_bloque],BL
            CMP     [posx_pelota1],BH
            JE      valido_x 
            ADD     SI,2
            JMP     verificar
            
        valido_x:
            CMP     [posy_pelota1],BL
            JE      valido_y
            ADD     SI,2
            JMP     verificar
            
        valido_y:
            CMP     [bandera_arriba_abajo],1
            JE      ir_abajo
            MOV     [bandera_arriba_abajo],1
            MOV     [bloques[SI]],0000
            INC     [punteo_juego]
            POSICIONAR_PUNTERO_GRAFICO 3,38
            XOR     BX,BX
            MOV     BL,[punteo_juego]
            MOV     [tmp_num_16_8bits],BX
            IMPRIMIR_NUM16BITS_V2 tmp_num_16_8bits
            JMP     salir_validar_choques_bloquesPN
            
        ir_abajo:
            MOV     [bandera_arriba_abajo],0
            MOV     [bloques[SI]],0000
            INC     [punteo_juego]
            POSICIONAR_PUNTERO_GRAFICO 3,38
            XOR     BX,BX
            MOV     BL,[punteo_juego]
            MOV     [tmp_num_16_8bits],BX
            IMPRIMIR_NUM16BITS_V2 tmp_num_16_8bits
            JMP     salir_validar_choques_bloquesPN    
        
        
        salir_validar_choques_bloquesPN:
ENDM