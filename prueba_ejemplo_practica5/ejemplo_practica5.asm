;ENSAMBLADOR UTILIZADO: MASM611
;DEL CUAL SE EXTRAJO LA INFORMACION DE INSTALACION Y USO EN: https://www.youtube.com/watch?v=pIRd79UsHXA


.model tiny

.data        
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
    
    posx_pelota1 db 17,"$"
    posy_pelota1 db 37,"$"    
    bandera_arriba_abajo db 1,"$"
    bandera_izquierda_derecha db 0,"$" 
    ;=0===0 variables no agregadas
    posx_bloque db 0,"$"
    posy_bloque db 0,"$"
    bloque db 02h,"$"
    bloques dw 30 dup("$$"),"$"
    ;?????????????????'
.code
    ;*************************************************************MACROS ********************************
    imprimir_xy MACRO escribir,x,y,repeticion,atributo
        ;este codigo posiciona el curso 
        ;selecciona el tipo de pagina
        SELECT_PAGE 01d
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
        LOCAL tecla_izquierda,mover_iz_tablero,tecla_derecha,mover_der_tablero,juego_pausado,salir_precedencia
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
            JMP     juego_pausado
        
        salir_presiono_tecla:
    ENDM 
    imprimir MACRO texto   
        XOR     DX,DX
        MOV     DX, OFFSET texto    
        MOV     AH, 09h
        INT     21h
    ENDM
    ;0... 
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
            
        restriccion2:;valida cuando toca la barra que se mueve con el teclado
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
            
        restriccion3:;valida cuando toca la barra derecha
            MOV     [posy_pelota1],74
            INC     [posx_pelota1]
            MOV     [bandera_izquierda_derecha],1
            JMP     repintar_pelota
            
        restriccion4:;valida cuando toca la barra izquierda
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
    
    ;------------------- macros no agregados -------------------------
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
            JMP     salir_validar_choques_bloquesPN
            
        ir_abajo:
            MOV     [bandera_arriba_abajo],0
            MOV     [bloques[SI]],0000
            JMP     salir_validar_choques_bloquesPN    
        
        
        salir_validar_choques_bloquesPN:
    ENDM
    ;**************************************************************************************************

    .startup
    
    
;    MOV     ax, 0600h  
;    MOV     bh, 50h             ;color fondo y letra
;    MOV     ch, 0               ;punto inicial hacia abajo
;    MOV     cl, 0               ;punto inicial hacia la derecha
;    MOV     dh, 5              ;punto final hacia abajo
;    MOV     dl, 79              ;punto final hacia la derecha  
;    INT     10h                                                

    ;********************   PROCEDIMIENTO JUEGO *******************************************************
     
     ;marco de la pantalla 
     INICIO_TODO:
;--
     XOR    SI,SI
     MOV    SI,24
     MOV    [tmp_posx],0
     limpiar_pantalla:
        imprimir_xy vacio,tmp_posx,0,79,0Ah
        INC     [tmp_posx]
        DEC     SI
        CMP     SI,0
        JNE     limpiar_pantalla
;-- 
      
     
     imprimir_xy marco,4,4,71,0Ah
     
    ; imprimir_xy pelota,0,0,1,0Eh 
    ; imprimir_xy vacio,0,0,1,0Eh
     imprimir_xy pelota,posx_pelota1,posy_pelota1,1,0Eh 
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
     ;--se llenan blqoues
     LLENAR_BLOQUES_PRIMER_NIVEL    
     COLOCAR_BLOQUES
     LOOP_JUEGO:   
        
        PRESIONO_TECLA
        
        MOVIMIENTO_PELOTA
        ;probando tiempo
        MOV     AH,00H
        INT     1ah
            
     
        JMP  LOOP_JUEGO 
     
     salir_juego:
     
    ; desplazar_xy
    JMP     INICIO_TODO ;esta etiqueta solo se coloco com prueba en vez de esto al salir del juego debe resetear todas las variables y arrays utilizados a sus valores originales 
    
    SELECT_PAGE 00d
    
    ;********************************* FIN PROCEDIMIENTO **********************************************                                                      
                                                                
    ;Dibujando una Bandera
    
   
;    ;1 franja (azul)
;    MOV     ax, 0600h
;    MOV     bh, 97h
;    MOV     cx, 0000h
;    MOV     dx, 034fh
;    INT     10h  
;    
;        ;2 franja (blanca)
;    MOV     ax, 0600h
;    MOV     bh, 70h
;    MOV     cx, 0400h
;    MOV     dx, 074fh
;    INT     10h
;    
;                
;        ;3 franja (roja)
;    MOV     ax, 0600h
;    MOV     bh, 47h
;    MOV     cx, 0800h
;    MOV     dx, 0B4fh
;    INT     10h
;    
;        ;4 franja (azul)
;    MOV     ax, 0600h
;    MOV     bh, 47h
;    MOV     cx, 0c00h
;    MOV     dx, 104fh
;    INT     10h
;              
;               
;        ;5 franja (azul)
;    MOV     ax, 0600h
;    MOV     bh, 70h
;    MOV     cx, 1100h
;    MOV     dx, 144fh
;    INT     10h
;    
;        ;6 franja (azul)
;    MOV     ax, 0600h
;    MOV     bh, 97h
;    MOV     cx, 1500h
;    MOV     dx, 184fh
;    INT     10h     
;    
;        
;    MOV     ax, 0600h  
;    MOV     bh, 50h            
;    MOV     ch, 0              
;    MOV     cl, 0              
;    MOV     dh, 25             
;    MOV     dl, 20             
;    INT     10h  
;                  
    salir: 
               
    MOV     ax,0c07h
    INT     21h   
    .exit
end