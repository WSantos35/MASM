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
    msg10 db "1)INGRESAR",10,13,"2)REGISTRAR",10,13,"3)SALIR",10,13,10,13,"$"
    msg11 db "ESCOGA UNA OPCION: ",10,13,"$"
    msg12 db "1)Top 10 Puntos",10,13,"2) Top 10 Tiempo",10,13,"3) Salir y Regresar al Menu",10,13,10,13,"$"
    
    ;MENSAJES VARIOS---------------------------------------------------------------------
    msgSalir db "==FIN DEL PROGRAMA, PRESIONE CUALQUIER TECLA PARA SALIR DEL PROGRAMA==",10,13,"$" 
    msg_nombre db ">>INGRESE SU NOMBRE DE USUARIO:",10,13,"$"
    msg_password db ">>INGRESE SU PASSWORD:",10,13,"$" 
    msg_separador db "----------------------",10,13,"$"
    msg_puntos db "------------------- TOP PUNTOS --------------------",10,13,"$" 
    msg_tiempo db "-----------------TOP TIEMPO EN SEGUNDOS ------------",10,13,"$"
    ;-------------------VARIABLES ESTATICAS-------------------------------------------------  
    saltoLinea db 10,13,"$"
    tabulacionLinea db 09h,09h,09h,"$"   
    textoArchivo db 2 dup("$")  
    tmp_numero db 0,"$"   
    cont_usuarios db 1,"$"
    tmp_cont_usuarios dw 00,"$" 
    pivoteCont db 5,"$"
    ubicacion_puntero dw 00,"$"
    cant_nombre db 0,"$"
    tmp_letranombre db 0,"$"
   ; pelota db 40h,"$" 
    ;-----------------VARIABLES ESTATICAS BANDERAS -----------------------------------------
    Array_iguales db 0,"$"     
    
    ;-------------------VARIABLES ARCHIVOS -------------------------------------------------
    path_usuarios db "C:\US.txt",0,"$"
    handler_usuarios dw ? 
    path_puntos db "C:\PUNTOS.rep",0,"$"
    handler_puntos dw ? 
    path_tiempo db "C:\TIMEPO.rep",0,"$"
    handler_tiempo dw ?
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
    ;-----------------------------------
    ;=========================================== VARIABLES JUEGO =====================================
    variable db "Hola Mundo",13,10,"$" 
    iz db "izquierda","$"
    dr db "derecha","$"
    pelota db 40h,"$"
    marco db 3Dh,"$"
    vacio db 00h,"$" 
    tablero db 04h,"$"
    posy_tablero db 35,"$"
    tmp_posx db 0,"$"
    escape equ 01h
    espacio equ 39h
    left equ 4bh
    rigth equ 4dh  
    tmp_SI dw 0,"$"
    extra db 0,"$"
    tmp_num_16_8bits dw 00,"$"
    punteo_juego db 0,"$"
    nivel_juego db 1,"$" 
    tiempo_juego db 0,"$"
    tmp_tiempo_verificacion dw 00,"$"
    tiempo_retardo dw 65530,"$"
    ;-
    posx_pelota1 db 17,"$"
    posy_pelota1 db 37,"$"    
    bandera_arriba_abajo db 1,"$"
    bandera_izquierda_derecha db 0,"$"
    ;---------------variables no agregadas 2--
    posx_bloque db 0,"$"
    posy_bloque db 0,"$"
    bloque db 02h,"$"
    bloques dw 30 dup("$$"),"$"
    ;-----------------------------------
    ;--------------------STRUCT PARA DATOS USUARIOS -----------------------------------------------------
    ;SE INICIALIZAN CON DB YA QUE PUNTOS, NIVEL Y TIEMPO NO PASARAN DE 255
    ;ESTE ESTRUCT OCUPAN 63 BYTES
    USUARIO STRUC
        nombre_usuario db 30 dup("$")
        password       db 30 dup("$")
        nivel          db 0
        puntos         db 0
        tiempo         db 0
    USUARIO ENDS  
      
    US USUARIO<'$','$',0,0,0>  
    US2 USUARIO<'$','$',0,0,0>
    

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
        
        ;============ NOMBRE Y PASSWORD DEL QUE INICIARA SESION ==================
        imprimir msg_nombre
        capturarCadena US.nombre_usuario
        imprimir saltoLinea
        imprimir msg_password  
        capturarCadena US.password
        imprimir saltoLinea 
        ;======================================================================= 
        
        ;=============PRIMERO SE POSICIONA EL PUNTERO EN LOS REGISTROS USUARIO==
        ;SE DEBE RECUPERAR EL CONTADOR DEL USUARIO
        abrirArchivo 3D00h, path_usuarios,handler_usuarios
        REC_VALOR_ARCHIVO cont_usuarios,handler_usuarios,1
        cerrarArchivo handler_usuarios
        ;=======================================================================
        ;============= SE RECUPERA A CADA USUARIO CREADO ====================== 
        XOR     SI,SI
        XOR     BX,BX
        MOV     BL,[cont_usuarios]
        MOV     [tmp_cont_usuarios],BX
        DEC     [tmp_cont_usuarios]
        INC     SI 
        ;imprimir cont_usuarios
        abrirArchivo 3D02h, path_usuarios,handler_usuarios;se cambio a lectura y escriura ----------------------********
        MOV     [ubicacion_puntero],64
        posicionarPuntero handler_usuarios,ubicacion_puntero 
        ;=============== SE VA VALIDANDO USUARIO POR USUARIO RECUPERADO ======
        lectura_usuarios:  
            REC_VALOR_ARCHIVO US2,handler_usuarios,63
            ;---- VALIDA EL USUARIO Y REALIZA LAS ACCIONES SI ES UN USUARIO
            ;---- CORRECTO  
            VALIDAR_USUARIO US2,US
            BORRAR_ARREGLO US2.nombre_usuario
            BORRAR_ARREGLO US2.password
            CMP     SI,[tmp_cont_usuarios]
            JE      continuar_opcion1
            INC     SI 
            ;se le suma a ubicacion puntero 63 bytes ya que nos va a servir despues
            ;para guardar las actualizaciones del usuario y saber de que usuario
            ;guardar las actualizaciones
            ADD     [ubicacion_puntero],63
            JMP     lectura_usuarios
        ;======================================================================
       ; cerrarArchivo handler_usuarios
       ; abrirArchivo 3D01h, path_usuarios,handler_usuarios
       ; ADD     [ubicacion_puntero],63
       ; posicionarPuntero handler_usuarios,ubicacion_puntero
       ; escribirArchivo US2,63,handler_usuarios
       ; cerrarArchivo handler_usuarios
        continuar_opcion1: 
            imprimir errorUsuarioIncorrecto
        encontro_usuario:
            BORRAR_ARREGLO US2.nombre_usuario
            BORRAR_ARREGLO US2.password
            BORRAR_ARREGLO US.nombre_usuario
            BORRAR_ARREGLO US.password 
            MOV     [ubicacion_puntero],0000
            cerrarArchivo handler_usuarios
            JMP imprimirMenu
        
     opcion2:
        imprimir saltoLinea
        ;imprimir text2
        XOR     SI,SI
        XOR     DI,DI 
        ;--- SE PIDEN LOS DATOS DEL USUARIO Y SE AGREGAN AL STRUCT ----------  
        imprimir msg_nombre
        capturarCadena US.nombre_usuario
        imprimir saltoLinea
        imprimir msg_password  
        capturarCadena US.password
        imprimir saltoLinea 
        ;--------------------------------------------------------------------
        
        ;===================PRIMERO SE RECUPERA CONTADOR USUARIOS ==============
        abrirArchivo 3D00h,path_usuarios,handler_usuarios
        REC_VALOR_ARCHIVO cont_usuarios,handler_usuarios,1
        cerrarArchivo handler_usuarios 
        ;imprimir cont_usuarios
        ;=======================================================================
        ;================ SE GUARDA EL USUARIO NUEVO ===========================
        ;antes de guardar, se debe encontrar la ubicacion del 
        ;puntero donde se guardara en el archivo
         XOR     DX,DX
         XOR     AX,AX
         XOR     BX,BX
         MOV     AL,[cont_usuarios] 
         MOV     BL,63
         MUL     BX
         MOV     [ubicacion_puntero],AX
         ADD     [ubicacion_puntero],1
         abrirArchivo 3D01h,path_usuarios,handler_usuarios
         posicionarPuntero handler_usuarios,ubicacion_puntero 
         ;imprimir ubicacion_puntero
         escribirArchivo US,63,handler_usuarios
         cerrarArchivo handler_usuarios 
        ;=======================================================================
        ;================ SE GUARDA EL CONTADOR ACTUALIZADO ====================
         INC     [cont_usuarios] 
         abrirArchivo 3D01h, path_usuarios,handler_usuarios
         escribirArchivo cont_usuarios,1,handler_usuarios
         cerrarArchivo handler_usuarios
        ;======================================================================= 
    
         ;---DESCOMENTAMOS ESTO PARA PODER CREAR EL ARCHIVO ORIGINAL DE 
         ;--USUARIOS
;        abrirArchivo 3D01h,path_usuarios,handler_usuarios  
;        escribirArchivo cont_usuarios,1,handler_usuarios
;        cerrarArchivo handler_usuarios
;        
;        abrirArchivo 3D00h,path_usuarios,handler_usuarios
;        REC_VALOR_ARCHIVO pivoteCont,handler_usuarios,1
;        cerrarArchivo handler_usuarios
;        
;        imprimir pivoteCont 

         ;--ESTO QUE ESTA COMENTADO ES PARA VERIFICAR QUE SI GUARDA
         ;--DATOS DEL USUARIO, SOLO SIRVE PARA PRUEBAS
;        BORRAR_ARREGLO US.nombre_usuario
;        BORRAR_ARREGLO US.password  
;        
;        abrirArchivo 3D00h, path_usuarios,handler_usuarios
;        posicionarPuntero handler_usuarios,ubicacion_puntero
;        REC_VALOR_ARCHIVO US,handler_usuarios,63
;        cerrarArchivo handler_usuarios        
;        imprimir US.nombre_usuario
        
        BORRAR_ARREGLO US.nombre_usuario
        BORRAR_ARREGLO US.password  
        
        JMP imprimirMenu
        
     opcion3: 
        imprimir saltoLinea 
        ;imprimir text3  
        imprimir msgSalir 
        JMP     salir
        JMP     imprimirMenu
      
     ;ETIQUETA SALIR
     salir:
        MOV     ax,0c07h;ah,00
        INT     21h 
      
    .exit
end       