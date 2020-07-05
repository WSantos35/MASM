;=================MACRO QUE IMPRIME CADENA EN CONSOLA============
enviar_arduino_cadena MACRO cad
        LOCAL lectura_cadena,salir_enviar_cadena_arduino
        XOR     SI,SI
        lectura_cadena:
                MOV     AH,00
                MOV     AL,11100011b
                MOV     DX,00
                INT     14h

                MOV     AH,01
                MOV     AL,[cad[SI]]
                CMP     AL,24h
                JE      salir_enviar_cadena_arduino
                MOV     DX,00
                INT     14h

                MOV     AH,03
                MOV     DX,01
                INT     14H
              ;  MOV     textoArchivo,AL
              ;  imprimir textoArchivo
              ;  imprimir saltoLinea
                INC     SI
                JMP     lectura_cadena

        salir_enviar_cadena_arduino:
ENDM
;================== ENVIAR LETRA POR EL PORT ===================
ENVIAR_CARACTER MACRO ltr
        push ax
        push bx
        push cx
        push dx

	MOV     AH,03
	MOV     DX,00 ;com1
	INT     14h

	MOV     AH,00
	MOV     AL,11100011b
	MOV     DX,00
	INT     14h

	MOV     AH,01
	MOV     AL,[ltr]
	MOV     DX,00
	INT     14h

	MOV     AH,03
	MOV     DX,01;com2
	INT     14h

	MOV     AH,03
	MOV     DX,02 ;com3
	INT     14h

	MOV     AH,03
	MOV     DX,03 ;com4?
	INT     14h
	MOV     BX,65530
	tiempo_espera_macro:
		DEC     BX       
		CMP     BX,0
		JNE     tiempo_espera_macro
	MOV     BX,65530
	tiempo_espera2_macro:
		DEC     BX
		CMP     BX,0
		JNE     tiempo_espera2_macro
        
        pop dx
        pop cx
        pop bx
        pop ax
ENDM

;==================================CODIGO EJEMPLO ARCHIVO LECTURA ===========================
ENVIAR_CADENA_ARDUINO MACRO CADENA
	LOCAL recorrer,salir_cadena
	XOR SI,SI
	
        recorrer:
                MOV     BL,[CADENA[SI]]
                CMP     BL,24h
                JE      salir_cadena
                MOV     [textoArchivo],BL
               ; imprimir textoArchivo
                ENVIAR_CARACTER textoArchivo
                INC     SI
                JMP     recorrer
	
	salir_cadena:
ENDM

