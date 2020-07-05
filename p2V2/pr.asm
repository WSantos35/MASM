;Ensamblador: MASM611
.model large


;la variable del texto del archivo es: readfile/textocompleto
;el archivo esta en la variable :readfile/handler
.stack 2048


.data       
	pathArch db "c:\ec.arq",0,"$"
	textoArchivo db 2 dup("$")
	cadenaEnviar db 512 dup('0'),"$"
	saltoLinea db 10,13,"$"
	msgcelular db "ESPERANDO RETORNO CONTROL...",10,13,"$"
	hander2 dw ?
	include MB.asm
	include VARSMENU.asm;archivo que contiene las variables y macros del menu inicio
	include READFILE.asm;
	include BAISON.asm;
	include HEXTODEC.ASM
	include GRAPH2d.asm
	include GRAPH3d.asm

.code
 




.startup


		
Inicio:  


    limpia     ;Limpiando pantalla
    print_menu      ;Imprimiendo Menu
    leer opcion       ;Leyendo opcion
    ;Switch para comparar valores    
    CompareString opcion+2,op1,1,opcion1
    CompareString opcion+2,op2,1,opcion2
    CompareString opcion+2,op3,1,opcion3
    CompareString opcion+2,op4,1,opcion4
    CompareString opcion+2,op5,1,opcion5
    jmp default    

opcion1:                 
  ;  limpia                              
  ;  imprimir ms9
    ;---------------------------
    IniReadFile Inicio
;       abrirArchivo 3d00h,pathArch,hander2
;       leerArchivo pathArch, hander2
    ;iniciando LOGIN
    ;INILOGIN
    ;---------------------------
   
	imprimir ms9
   pause
    jmp  Inicio
opcion2:
    limpia                              
    ;---------------------------
    ;iniciando Grafica en 2D
    INI2D
    ;---------------------------    
    jmp  Inicio
opcion3:
    limpia                              
    ;---------------------------
    ;iniciando REGISTRO DE NUEVO USUARIO
    INI3D
;        MOV [textoArchivo],'>'
;        ENVIAR_CARACTER textoArchivo
    ;---------------------------    
    pause
    jmp  Inicio    
opcion4: 
   ; limpia                              
   ; imprimir ms12                     
    ;---------------------------    
    ;ReporteTiempo
    ;ReportePuntos--------------------------------------------------------------------------------
	   ; imprimir text4
	 
     ;------MANDANDO DATO PARA QUE RECONOZCA SOLO ANDROID -----
	MOV     AH,03
	MOV     DX,00 ;com1
	INT     14h
	
;        MOV     [textoArchivo],AH
;        imprimir textoArchivo
;        imprimir saltoLinea 
	;----texto propio para enviar datos      
	;MANDANDO SE¥AL PARA QUE QUE ANDROID TOME EL CONTROL
	MOV     AH,00
	MOV     AL,11100011b
	MOV     DX,00
	INT     14h

	MOV     AH,01
	MOV     AL,'>'
	MOV     DX,00
	INT     14h

;        MOV     [textoArchivo],AH
;        imprimir textoArchivo
;        imprimir saltoLinea
	

	;-------------------

;        
	MOV     AH,03
	MOV     DX,01;com2
	INT     14h
;        
;        MOV     [textoArchivo],AH
;        imprimir textoArchivo
;        imprimir saltoLinea
	
	MOV     AH,03
	MOV     DX,02 ;com3
	INT     14h
;        
;        MOV     [textoArchivo],AH
;        imprimir textoArchivo 
;        imprimir saltoLinea
;        
	MOV     AH,03
	MOV     DX,03 ;com4?
	INT     14h
;        
;        MOV     [textoArchivo],AH
;        imprimir textoArchivo  
;        imprimir saltoLinea
     
     ;-----------DELAY TIEMPO ESPERA -----------------------
	MOV     BX,65530
	tiempo_espera:
		DEC     BX       
		CMP     BX,0
		JNE     tiempo_espera
	MOV     BX,65530
	tiempo_espera2:
		DEC     BX
		CMP     BX,0
		JNE     tiempo_espera2
	 ;------------EN ESCUCHA PARA RECUPERAR CONTROL ------------
      ;ESPERANDO SE¥AL PARA RETOMAR EL CONTROL
      imprimir msgcelular  
	;---------CODIGO EXTA PRUEBA -----
	MOV     AH,02
	MOV     DX,00
	INT     14h
	;---------------------------------
      text_recibido:
	MOV     AH,02
	MOV     DX,00
	INT     14h
	MOV     BL,AL
	MOV     [textoArchivo],BL
	imprimir textoArchivo
	imprimir saltoLinea
	CMP     BL,40h
	JNE     text_recibido 
       ; MOV     [textoArchivo],BL
       ; imprimir textoArchivo
	imprimir saltoLinea
	
	
	;----------------------------------------------------------


	XOR     SI,SI
	XOR     DI,DI
    ;---------------------------------------------------------------------------------------------
    pause
    jmp  Inicio
opcion5:
finalizar
default:
    imprimir err1
    pause
    jmp  Inicio      
;-----------------Procedimientos----------------------

end                     




