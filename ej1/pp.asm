[org 100h]
[section .text]
GLOBAL Inicio
Inicio:	
	mov bl,43	
	mov dx,limpiar
	mov ah,9
	int 21h
  
	mov dx,msg2    	  ;Imprimo el menu principal 
	mov ah,9
	int 21h	        
	MOV DX, Mensaje   ; Imprimo peticion de ingreso de numero
  	MOV AH, 9       
  	INT 21h         
  	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h  	
  	MOV SI, Bufer + 2 ;Paso los datos para probar menu el numero ingresado  	
	Mov dl,Byte[SI]
	mov [variable],dl
	mov ah,[variable]
  	cmp ah,49	;Comparo si es 1, me muevo a ingresar funcion
  	Je N1
	cmp ah,50	;Compara si es 2, muestro funcion en memoria
	je N2
	cmp ah,51	;Compara si es 3, muestro la derivada
	je N3
	cmp ah,52	;Compara si es 4, muestro la integral
	je N4
	cmp ah,53	;Compara si es 5, Grafico funciones
	je N5
	cmp ah,54	;Compara si es 6, Reporte
	je N6
	cmp ah,55	;Compara si es 7, Salir
	je N7
	jmp N8 		;Cualquier otra cosa muestro mensaje error y regreso a menu
N1:
	mov dx,limpiar
	mov ah,9
	int 21h
	Mov dx,TN1
	mov ah,9
	int 21h
	Mov dx,TN1x4
	mov ah,9
	int 21h
;Revisar ingreso de Coeficiente 4
RevCoe4:
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	MOV SI, Bufer + 2 ;Paso los datos para probar menu el numero ingresado  	
  	cmp byte[SI],48	;El numero ingresado es 0
  	je RevCoe3
  	cmp byte[si],43	;Reviso si es mas
  	jne RevSigno4	;si no es que se vaya a revisar si es menos
  	jmp SignoBien4
RevSigno4:  	
  	cmp byte[si],45
  	jne ErrorSigno;Si no es menos que tire error
SignoBien4:
  	Mov dl,Byte[SI]
	mov [Signo4],dl
  	inc si
  	cmp byte[si],48;Reviso si es 0
  	je RevCoe3
  	cmp byte[si],49;Reviso si es 1
  	je RevCoe3
  	cmp byte[si],50;Reviso si es 2
  	je RevCoe3
  	cmp byte[si],51;Reviso si es 3
  	je RevCoe3
  	cmp byte[si],52;Reviso si es 4
  	je RevCoe3
  	cmp byte[si],53;Reviso si es 5
  	je RevCoe3
  	cmp byte[si],54;Reviso si es 6
  	je RevCoe3
  	cmp byte[si],55;Reviso si es 7
  	je RevCoe3
  	cmp byte[si],56;Reviso si es 8
  	je RevCoe3
  	cmp byte[si],57;Reviso si es 9
  	je RevCoe3
  	jmp ErrorCoeficiente;Se ingreso algo que no era un numero	
RevCoe3:
	Mov dl,Byte[SI]
	mov [Coeficiente4],dl;Guardo el numero del Coeficiente 4
	Mov dx,TN1x3
	mov ah,9
	int 21h
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	MOV SI, Bufer + 2 ;Paso los datos para probar menu el numero ingresado  	
  	cmp byte[SI],48	;El numero ingresado es 0
  	je RevCoe2
  	cmp byte[si],43	;Reviso si es mas
  	jne RevSigno3	;si no es que se vaya a revisar si es menos
  	jmp SignoBien3
RevSigno3:
  	cmp byte[si],45
  	jne ErrorSigno;Si no es menos que tire error
SignoBien3:
  	Mov dl,Byte[SI]
	mov [Signo3],dl
  	inc si
  	cmp byte[si],48;Reviso si es 0
  	je RevCoe2
  	cmp byte[si],49;Reviso si es 1
  	je RevCoe2
  	cmp byte[si],50;Reviso si es 2
  	je RevCoe2
  	cmp byte[si],51;Reviso si es 3
  	je RevCoe2
  	cmp byte[si],52;Reviso si es 4
  	je RevCoe2
  	cmp byte[si],53;Reviso si es 5
  	je RevCoe2
  	cmp byte[si],54;Reviso si es 6
  	je RevCoe2
  	cmp byte[si],55;Reviso si es 7
  	je RevCoe2
  	cmp byte[si],56;Reviso si es 8
  	je RevCoe2
  	cmp byte[si],57;Reviso si es 9
  	je RevCoe2
  	jmp ErrorCoeficiente;Se ingreso algo que no era un numero
RevCoe2:
	Mov dl,Byte[SI]
	mov [Coeficiente3],dl;Guardo el numero del Coeficiente 4
	Mov dx,TN1x2
	mov ah,9
	int 21h
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	MOV SI, Bufer + 2 ;Paso los datos para probar menu el numero ingresado  	
  	cmp byte[SI],48	;El numero ingresado es 0
  	je RevCoe1
  	cmp byte[si],43	;Reviso si es mas
  	jne RevSigno2	;si no es que se vaya a revisar si es menos
  	jmp SignoBien2
RevSigno2:
  	cmp byte[si],45
  	jne ErrorSigno;Si no es menos que tire error
SignoBien2:
  	Mov dl,Byte[SI]
	mov [Signo2],dl
  	inc si
  	cmp byte[si],48;Reviso si es 0
  	je RevCoe1
  	cmp byte[si],49;Reviso si es 1
  	je RevCoe1
  	cmp byte[si],50;Reviso si es 2
  	je RevCoe1
  	cmp byte[si],51;Reviso si es 3
  	je RevCoe1
  	cmp byte[si],52;Reviso si es 4
  	je RevCoe1
  	cmp byte[si],53;Reviso si es 5
  	je RevCoe1
  	cmp byte[si],54;Reviso si es 6
  	je RevCoe1
  	cmp byte[si],55;Reviso si es 7
  	je RevCoe1
  	cmp byte[si],56;Reviso si es 8
  	je RevCoe1
  	cmp byte[si],57;Reviso si es 9
  	je RevCoe1
  	jmp ErrorCoeficiente;Se ingreso algo que no era un numero
RevCoe1:
	Mov dl,Byte[SI]
	mov [Coeficiente2],dl;Guardo el numero del Coeficiente 4
	Mov dx,TN1x1
	mov ah,9
	int 21h
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	MOV SI, Bufer + 2 ;Paso los datos para probar menu el numero ingresado  	
  	cmp byte[SI],48	;El numero ingresado es 0
  	je RevCoe0
  	cmp byte[si],43	;Reviso si es mas
  	jne RevSigno1	;si no es que se vaya a revisar si es menos
  	jmp SignoBien1
RevSigno1:
  	cmp byte[si],45
  	jne ErrorSigno;Si no es menos que tire error
SignoBien1:
  	Mov dl,Byte[SI]
	mov [Signo1],dl
  	inc si
  	cmp byte[si],48;Reviso si es 0
  	je RevCoe0
  	cmp byte[si],49;Reviso si es 1
  	je RevCoe0
  	cmp byte[si],50;Reviso si es 2
  	je RevCoe0
  	cmp byte[si],51;Reviso si es 3
  	je RevCoe0
  	cmp byte[si],52;Reviso si es 4
  	je RevCoe0
  	cmp byte[si],53;Reviso si es 5
  	je RevCoe0
  	cmp byte[si],54;Reviso si es 6
  	je RevCoe0
  	cmp byte[si],55;Reviso si es 7
  	je RevCoe0
  	cmp byte[si],56;Reviso si es 8
  	je RevCoe0
  	cmp byte[si],57;Reviso si es 9
  	je RevCoe0
  	jmp ErrorCoeficiente;Se ingreso algo que no era un numero

RevCoe0:
	Mov dl,Byte[SI]
	mov [Coeficiente1],dl;Guardo el numero del Coeficiente 4
	Mov dx,TN1x0
	mov ah,9
	int 21h
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	MOV SI, Bufer + 2 ;Paso los datos para probar menu el numero ingresado  	
  	cmp byte[SI],48	;El numero ingresado es 0
  	je  N1Fin
  	cmp byte[si],43	;Reviso si es mas
  	jne RevSigno0	;si no es que se vaya a revisar si es menos
  	jmp SignoBien0
RevSigno0:
  	cmp byte[si],45
  	jne ErrorSigno;Si no es menos que tire error
SignoBien0:
  	Mov dl,Byte[SI]
	mov [Signo0],dl
  	inc si
  	cmp byte[si],48;Reviso si es 0
  	je N1Fin
  	cmp byte[si],49;Reviso si es 1
  	je N1Fin
  	cmp byte[si],50;Reviso si es 2
  	je N1Fin
  	cmp byte[si],51;Reviso si es 3
  	je N1Fin
  	cmp byte[si],52;Reviso si es 4
  	je N1Fin
  	cmp byte[si],53;Reviso si es 5
  	je N1Fin
  	cmp byte[si],54;Reviso si es 6
  	je N1Fin
  	cmp byte[si],55;Reviso si es 7
  	je N1Fin
  	cmp byte[si],56;Reviso si es 8
  	je N1Fin
  	cmp byte[si],57;Reviso si es 9
  	je N1Fin
  	jmp ErrorCoeficiente;Se ingreso algo que no era un numero
N1Fin:
	Mov dl,Byte[SI]
	mov [Coeficiente0],dl;Guardo el numero del Coeficiente 4	
	mov dl,1
	mov [EstadoMem],dl
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
	jmp Inicio
ErrorSigno:
	Mov dx,TESigno
	mov ah,9
	int 21h
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	mov dl,0
	mov [EstadoMem],dl
  	jmp Inicio
ErrorCoeficiente:
	Mov dx,TECoe
	mov ah,9
	int 21h
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	mov dl,0
	mov [EstadoMem],dl
  	jmp Inicio

N2:
	mov dx,limpiar
	mov ah,9
	int 21h
	Mov dx,TN2
	mov ah,9
	int 21h	
	mov dl,[EstadoMem]
	cmp dl,0
	je ErrorMemoria
	Mov dx,TFun
	mov ah,9
	int 21h
	mov di, CadenaOriginal
	mov dl,0
	mov [ContadorOriginal],dl
FuncionMemoria4:
	mov dl,[Coeficiente4]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je FuncionMemoria3
	MOV AH, 6h 
	Mov dl,[Signo4];Imprimo el signo del Coeficiente4
	int 21h	
	mov dl,[Signo4]
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl
	MOV AH, 6h 
	Mov dl,32		;Imprimo un espacio en blanco
	int 21h	

	mov dl,32
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	MOV AH, 6h 
	Mov dl,[Coeficiente4]
	int 21h

	mov dl,[Coeficiente4]
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	mov dl,42				;*
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	mov dl,120				;x
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	mov dl,52				;4
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	Mov dx,TFun4
	mov ah,9
	int 21h	
FuncionMemoria3:
	mov dl,[Coeficiente3]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je FuncionMemoria2
	MOV AH, 6h 
	Mov dl,[Signo3];Imprimo el signo del Coeficiente4
	int 21h	

	mov dl,[Signo3]
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	MOV AH, 6h 
	Mov dl,32		;Imprimo un espacio en blanco
	int 21h	

	mov dl,32
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	MOV AH, 6h 
	Mov dl,[Coeficiente3]
	int 21h

	mov dl,[Coeficiente3]
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	mov dl,42				;*
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	mov dl,120				;x
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	mov dl,51				;3
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	Mov dx,TFun3
	mov ah,9
	int 21h	
FuncionMemoria2:
	mov dl,[Coeficiente2]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je FuncionMemoria1
	MOV AH, 6h 
	Mov dl,[Signo2];Imprimo el signo del Coeficiente4
	int 21h	

	mov dl,[Signo2]
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	MOV AH, 6h 
	Mov dl,32		;Imprimo un espacio en blanco
	int 21h	

	mov dl,32
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	MOV AH, 6h 
	Mov dl,[Coeficiente2]
	int 21h

	mov dl,[Coeficiente2]
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	mov dl,42				;*
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	mov dl,120				;x
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	mov dl,50				;2
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	Mov dx,TFun2
	mov ah,9
	int 21h	
FuncionMemoria1:
	mov dl,[Coeficiente1]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je FuncionMemoria0
	MOV AH, 6h 
	Mov dl,[Signo1];Imprimo el signo del Coeficiente4
	int 21h	

	mov dl,[Signo1]				
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	MOV AH, 6h 
	Mov dl,32		;Imprimo un espacio en blanco
	int 21h	

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	MOV AH, 6h 
	Mov dl,[Coeficiente1]
	int 21h

	mov dl,[Coeficiente1]			
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	mov dl,42				;*
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	mov dl,120				;x
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	Mov dx,TFun1
	mov ah,9
	int 21h	
FuncionMemoria0:
	mov dl,[Coeficiente0]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je N2Fin
	MOV AH, 6h 
	Mov dl,[Signo0];Imprimo el signo del Coeficiente4
	int 21h	

	mov dl,[Signo0]
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	MOV AH, 6h 
	Mov dl,32		;Imprimo un espacio en blanco
	int 21h	

	mov dl,32
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl

	MOV AH, 6h 
	Mov dl,[Coeficiente0]
	int 21h	

	mov dl,[Coeficiente0]
	mov byte[di], dl
	mov dl,[ContadorOriginal]
	inc dl
	inc di
	mov [ContadorOriginal],dl
N2Fin:
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	jmp Inicio
ErrorMemoria:
	Mov dx,TEMem
	mov ah,9
	int 21h		
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	jmp Inicio
N3:
	mov dx,limpiar
	mov ah,9
	int 21h
	Mov dx,TN3
	mov ah,9
	int 21h
	mov dl,[EstadoMem]
	cmp dl,0
	je ErrorMemoria
	Mov dx,TDer
	mov ah,9
	int 21h
	mov di, CadenaDerivada
	mov dl,0
	mov [ContadorDerivada],dl
DerivadaMemoria4:
	mov dl,[Coeficiente4]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je DerivadaMemoria3
	MOV AH, 6h 
	Mov dl,[Signo4];Imprimo el signo del Coeficiente4
	int 21h	

	mov dl,[Signo4];	Copio el signo
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	MOV AH, 6h 
	Mov dl,32		;Imprimo un espacio en blanco
	int 21h	

	mov dl,32;	Espacio
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	mov al,[Coeficiente4]	
	mov dl,48
	sub al,dl
	mov bl,4
	mov cl,0;Para contador de veces
	mov dl,0;para manejar el resultado	
DerMulti4:
	add dl,al
	inc cl
	cmp cl,bl
	jne DerMulti4
	mov al,dl;al es el resultado
	mov bl,0
DerPrimerDigito4:
	mov cl,0
	cmp al,0
	je DerPintarDigito4
	mov cl,1
	cmp al,1
	je DerPintarDigito4
	mov cl,2
	cmp al,2
	je DerPintarDigito4
	mov cl,3
	cmp al,3
	je DerPintarDigito4
	mov cl,4
	cmp al,4
	je DerPintarDigito4
	mov cl,5
	cmp al,5
	je DerPintarDigito4
	mov cl,6
	cmp al,6
	je DerPintarDigito4
	mov cl,7
	cmp al,7
	je DerPintarDigito4
	mov cl,8
	cmp al,8
	je DerPintarDigito4
	mov cl,9
	cmp al,9
	je DerPintarDigito4
	sub al,10
	inc bl
	jmp DerPrimerDigito4
DerPintarDigito4:
	add bl,48  	
  	MOV AH,6h 
	Mov dl,bl
	int 21h

	mov dl,bl;	 imprimo segundo digito
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	add cl,48  	
  	MOV AH, 6h 
	Mov dl,cl
	int 21h

	mov dl,cl;	 imprimo primer digito
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	mov dl,42				;*
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	mov dl,120				;x
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	mov dl,51				;3
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	Mov dx,TFun3
	mov ah,9
	int 21h
DerivadaMemoria3:
	mov dl,[Coeficiente3]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je DerivadaMemoria2
	MOV AH, 6h 
	Mov dl,[Signo3];Imprimo el signo del Coeficiente4
	int 21h	

	mov dl,[Signo3]				;Signo 3
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	MOV AH, 6h 
	Mov dl,32		;Imprimo un espacio en blanco
	int 21h	

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	mov al,[Coeficiente3]
	mov dl,48
	sub al,dl
	mov bl,3
	mov cl,0;Para contador de veces
	mov dl,0;para manejar el resultado	
DerMulti3:
	add dl,al
	inc cl
	cmp cl,bl
	jne DerMulti3
	mov al,dl;al es el resultado
	mov bl,0
DerPrimerDigito3:
	mov cl,0
	cmp al,0
	je DerPintarDigito3
	mov cl,1
	cmp al,1
	je DerPintarDigito3
	mov cl,2
	cmp al,2
	je DerPintarDigito3
	mov cl,3
	cmp al,3
	je DerPintarDigito3
	mov cl,4
	cmp al,4
	je DerPintarDigito3
	mov cl,5
	cmp al,5
	je DerPintarDigito3
	mov cl,6
	cmp al,6
	je DerPintarDigito3
	mov cl,7
	cmp al,7
	je DerPintarDigito3
	mov cl,8
	cmp al,8
	je DerPintarDigito3
	mov cl,9
	cmp al,9
	je DerPintarDigito3
	sub al,10
	inc bl
	jmp DerPrimerDigito3
DerPintarDigito3:
	add bl,48  	
  	MOV AH,6h 
	Mov dl,bl
	int 21h

	mov dl,bl				;Segundo digito
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	add cl,48  	
  	MOV AH, 6h 
	Mov dl,cl
	int 21h

	mov dl,cl				;Primer digito
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	mov dl,42				;*
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	mov dl,120				;x
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	mov dl,50				;2
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	Mov dx,TFun2
	mov ah,9
	int 21h	
DerivadaMemoria2:
	mov dl,[Coeficiente2]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je DerivadaMemoria1
	MOV AH, 6h 
	Mov dl,[Signo2];Imprimo el signo del Coeficiente4
	int 21h	

	mov dl,[Signo2]				;Signo 2
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	MOV AH, 6h 
	Mov dl,32		;Imprimo un espacio en blanco
	int 21h	

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	mov al,[Coeficiente2]
	mov dl,48
	sub al,dl
	mov bl,2
	mov cl,0;Para contador de veces
	mov dl,0;para manejar el resultado	
DerMulti2:
	add dl,al
	inc cl
	cmp cl,bl
	jne DerMulti2
	mov al,dl;al es el resultado
	mov bl,0
DerPrimerDigito2:
	mov cl,0
	cmp al,0
	je DerPintarDigito2
	mov cl,1
	cmp al,1
	je DerPintarDigito2
	mov cl,2
	cmp al,2
	je DerPintarDigito2
	mov cl,3
	cmp al,3
	je DerPintarDigito2
	mov cl,4
	cmp al,4
	je DerPintarDigito2
	mov cl,5
	cmp al,5
	je DerPintarDigito2
	mov cl,6
	cmp al,6
	je DerPintarDigito2
	mov cl,7
	cmp al,7
	je DerPintarDigito2
	mov cl,8
	cmp al,8
	je DerPintarDigito2
	mov cl,9
	cmp al,9
	je DerPintarDigito2
	sub al,10
	inc bl
	jmp DerPrimerDigito2
DerPintarDigito2:
	add bl,48  	
  	MOV AH,6h 
	Mov dl,bl
	int 21h

	mov dl,bl				;Digito 2
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl


	add cl,48  	
  	MOV AH, 6h 
	Mov dl,cl
	int 21h

	mov dl,cl				;Digito 1
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	mov dl,42				;*
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	mov dl,120				;x
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl	

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	Mov dx,TFun1
	mov ah,9
	int 21h	
DerivadaMemoria1:
	mov dl,[Coeficiente1]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je N3Fin
	MOV AH, 6h 
	Mov dl,[Signo1];Imprimo el signo del Coeficiente4
	int 21h	

	mov dl,[Signo1]				;Signo 1
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	MOV AH, 6h 
	Mov dl,32		;Imprimo un espacio en blanco
	int 21h

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	mov al,[Coeficiente1]
	mov dl,48
	sub al,dl
	mov bl,1
	mov cl,0;Para contador de veces
	mov dl,0;para manejar el resultado	
DerMulti1:
	add dl,al
	inc cl
	cmp cl,bl
	jne DerMulti1
	mov al,dl;al es el resultado
	mov bl,0
DerPrimerDigito1:
	mov cl,0
	cmp al,0
	je DerPintarDigito1
	mov cl,1
	cmp al,1
	je DerPintarDigito1
	mov cl,2
	cmp al,2
	je DerPintarDigito1
	mov cl,3
	cmp al,3
	je DerPintarDigito1
	mov cl,4
	cmp al,4
	je DerPintarDigito1
	mov cl,5
	cmp al,5
	je DerPintarDigito1
	mov cl,6
	cmp al,6
	je DerPintarDigito1
	mov cl,7
	cmp al,7
	je DerPintarDigito1
	mov cl,8
	cmp al,8
	je DerPintarDigito1
	mov cl,9
	cmp al,9
	je DerPintarDigito1
	sub al,10
	inc bl
	jmp DerPrimerDigito1
DerPintarDigito1:
	add bl,48  	
  	MOV AH,6h 
	Mov dl,bl
	int 21h

	mov dl,bl				;Segundo digito
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

	add cl,48  	
  	MOV AH, 6h 
	Mov dl,cl
	int 21h	

	mov dl,cl				;Primer Digito
	mov byte[di], dl
	mov dl,[ContadorDerivada]
	inc dl
	inc di
	mov [ContadorDerivada],dl

N3Fin:
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	jmp Inicio
N4:
	mov dx,limpiar
	mov ah,9
	int 21h
	Mov dx,TN4
	mov ah,9
	int 21h
	mov dl,[EstadoMem]
	cmp dl,0
	je ErrorMemoria
	Mov dx,TInt
	mov ah,9
	int 21h
	mov di, CadenaIntegral
	mov dl,0
	mov [ContadorIntegral],dl
IntegralMemoria4:
	mov dl,[Coeficiente4]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je IntegralMemoria3
	MOV AH, 6h 
	Mov dl,[Signo4];Imprimo el signo del Coeficiente4
	int 21h	

	mov dl,[Signo4]				;Signo 4
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,32		;Imprimo un espacio en blanco
	int 21h	

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,[Coeficiente4]
	int 21h

	mov dl,[Coeficiente4]				;Numerador
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,47		;Imprimo una diagonal /
	int 21h	

	mov dl,47				;/
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,53		;Imprimo 5 para el denominador
	int 21h	

	mov dl,53				;5
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,42				;*
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,120				;x
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,53				;5
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	Mov dx,TFun5
	mov ah,9
	int 21h	
IntegralMemoria3:
	mov dl,[Coeficiente3]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je IntegralMemoria2
	MOV AH, 6h 
	Mov dl,[Signo3];Imprimo el signo del Coeficiente4
	int 21h	

	mov dl,[Signo3]				;Signo 3
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,32		;Imprimo un espacio en blanco
	int 21h	

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,[Coeficiente3]
	int 21h

	mov dl,[Coeficiente3]				;Numerador
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,47		;Imprimo una diagonal /
	int 21h	

	mov dl,47				;/
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,52		;Imprimo 4 para el denominador
	int 21h	

	mov dl,52				;4
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,42				;*
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,120				;x
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,52				;4
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	Mov dx,TFun4
	mov ah,9
	int 21h	
IntegralMemoria2:
	mov dl,[Coeficiente2]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je IntegralMemoria1
	MOV AH, 6h 
	Mov dl,[Signo2];Imprimo el signo del Coeficiente4
	int 21h	

	mov dl,[Signo2]				;Signo 2
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,32		;Imprimo un espacio en blanco
	int 21h	

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,[Coeficiente2]
	int 21h

	mov dl,[Coeficiente2]				;Numerador
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,47		;Imprimo una diagonal /
	int 21h	

	mov dl,47				;/
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,51		;Imprimo 3 para el denominador
	int 21h	

	mov dl,51				;Denominador
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,42				;*
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,120				;x
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,51				;3
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	Mov dx,TFun3
	mov ah,9
	int 21h	
IntegralMemoria1:
	mov dl,[Coeficiente1]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je IntegralMemoria0
	MOV AH, 6h 
	Mov dl,[Signo1];Imprimo el signo del Coeficiente4
	int 21h	

	mov dl,[Signo1]				;Signo 1
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,32		;Imprimo un espacio en blanco
	int 21h	

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,[Coeficiente1]
	int 21h

	mov dl,[Coeficiente1]				;Numerador
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,47		;Imprimo una diagonal /
	int 21h	

	mov dl,47				;/
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,50		;Imprimo 2 para el denominador
	int 21h	

	mov dl,50				;Denominador
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,42				;*
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,120				;x
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,50				;2
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	Mov dx,TFun2
	mov ah,9
	int 21h	
IntegralMemoria0:
	mov dl,[Coeficiente0]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je N4Fin
	MOV AH, 6h 
	Mov dl,[Signo0];Imprimo el signo del Coeficiente4
	int 21h	

	mov dl,[Signo0]				;Signo
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,32		;Imprimo un espacio en blanco
	int 21h	

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,[Coeficiente0]
	int 21h	

	mov dl,[Coeficiente0]				;Numero
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,42				;*
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,120				;x
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	Mov dx,TFun1
	mov ah,9
	int 21h
N4Fin:
	MOV AH, 6h 
	Mov dl,43		;Imprimo un +
	int 21h	

	mov dl,43				;+
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,32		;Imprimo un espacio
	int 21h	

	mov dl,32				;Espacio
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV AH, 6h 
	Mov dl,67		;Imprimo C
	int 21h	

	mov dl,67				;C
	mov byte[di], dl
	mov dl,[ContadorIntegral]
	inc dl
	inc di
	mov [ContadorIntegral],dl

	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	jmp Inicio
N5:
	mov dx,limpiar
	mov ah,9
	int 21h
	mov dl,[EstadoMem]
	cmp dl,0
	je ErrorMemoria
	Mov dx,TN5
	mov ah,9
	int 21h
	MOV DX, Mensaje   ; Imprimo peticion de ingreso de numero
  	MOV AH, 9       
  	INT 21h 
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	MOV SI, Bufer + 2 ;Paso los datos para probar menu el numero ingresado  	
	Mov dl,Byte[SI]	
  	cmp dl,49	;Comparo si es 1, me muevo a ingresar funcion
  	Je M1
	cmp dl,50	;Compara si es 2, muestro funcion en memoria
	je M2
	cmp dl,51	;Compara si es 3, muestro la derivada
	je M3
	cmp dl,52	;Compara si es 4, regreso a inicio
	je M4
	jmp M5
M1:;Grafico original

	Mov dx,TIntervalo1;Pedir el primer numero
	mov ah,9
	int 21h
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	;Meter el primer numero a mis variables
  	mov bx,0
  	mov cx,0
  	movzx si, byte [Bufer+1] 
  	mov dx, Bufer
  	add si, dx 

  	mov bp,10	
  	mov cx,0
  	mov al,byte [si]
  	sub al,48
  	mov ah,0
  	mul bp
  	add bx,ax
  	inc si
  	mov al,byte [si]
  	sub al,48 
  	mov ah,0
  	add bx,ax

  	dec si
  	dec si
  	cmp byte[si],43
  	je IntervaloM1Mas1
  	mov ax,bx
	mov bx,160
	sub bx,ax	;En ax tengo el valor de X actual en el plano
	dec bx
  	mov [Intervalo1],bx
  	jmp FinIntervalo1M1
  	;trabajo si fuera menos
IntervaloM1Mas1:
	mov ax,bx
	mov bx,160
	add bx,ax	;En ax tengo el valor de X actual en el plano
	dec bx
  	mov [Intervalo1],bx

FinIntervalo1M1:
	Mov dx,TIntervalo2;Pedir el primer numero
	mov ah,9
	int 21h
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	;Meter el primer numero a mis variables
  	mov bx,0
  	mov cx,0
  	movzx si, byte [Bufer+1] 
  	mov dx, Bufer
  	add si, dx 

  	mov bp,10	
  	mov cx,0
  	mov al,byte [si]
  	sub al,48
  	mov ah,0
  	mul bp
  	add bx,ax
  	inc si
  	mov al,byte [si]
  	sub al,48 
  	mov ah,0
  	add bx,ax

  	dec si
  	dec si
  	cmp byte[si],43
  	je IntervaloM1Mas2
  	mov ax,bx
	mov bx,160
	sub bx,ax	;En ax tengo el valor de X actual en el plano
	inc bx
  	mov [Intervalo2],bx
  	jmp FinIntervalo2M1
  	;trabajo si fuera menos
IntervaloM1Mas2:
	mov ax,bx
	mov bx,160
	add bx,ax	;En ax tengo el valor de X actual en el plano
	inc bx
  	mov [Intervalo2],bx
FinIntervalo2M1:
	mov ax,[Intervalo1]
	mov bx,[Intervalo2]
  	cmp ax,bx
  	jge ErrorIntervalo

;Entro a modo grafico
	mov ax,0013h
  	int 10h

 	;PINTAR EJE Y,	CX ES COLUMNAS Y DX ES FILA
	;MAXIMO DE COLUMNA ES 320 
	;MAXIMO DE FILA ES 200
	mov cx,160;Me posiciono en columna central
	mov dx,0;Me posiciono en primera fila
PintarEjeY1:
	mov ah,0ch
  	mov al,0CH
  	int 10h
  	inc dx
  	cmp dx,200
  	jne PintarEjeY1

	mov cx,0;Me posiciono en primera columna
	mov dx,100;Me posiciono en fila central
PintarEjeX1:
	mov ah,0ch;servicio para pintar
  	mov al,0ch;Color
  	int 10h;Interrupcion
  	inc cx
  	cmp cx,320
  	jne PintarEjeX1


mov cx,0;Me posiciono en la primera columna
PintarOriginal:
	mov bx,100
	mov [variable],bx
FuncionGraficar4:
	mov dl,[Coeficiente4]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je FuncionGraficar3
	;Primero obtengo el resultado de elevar el valor a la cuarta 
	mov ax,cx
	mov bx,160
	sub ax,bx	;En ax tengo el valor de X actual en el plano
	Mov bx,ax	;En bx tambien tengo el valor de X actual en el plano 
	imul bx
	imul bx
	imul bx;El resultado se queda en ax
	Mov bx,[Coeficiente4];Paso el coeficiente para que se multiplique con la potencia
	mov dx,48
	sub bx,dx
	imul bx	
	Mov dl,[Signo4];Recupero el signo
	cmp dl,43
	je FuncionSuma4;Reviso si se lo sumo o se lo resto al resultado 
	mov bx,[variable]
	sub bx,ax
	mov [variable],bx
	jmp FuncionGraficar3
FuncionSuma4:
	mov bx,[variable]
	add bx,ax
	mov [variable],bx
FuncionGraficar3:
	mov dl,[Coeficiente3]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je FuncionGraficar2
	mov ax,cx
	mov bx,160
	sub ax,bx	;En ax tengo el valor de X actual en el plano
	Mov bx,ax	;En bx tambien tengo el valor de X actual en el plano 
	imul bx
	imul bx	
	Mov bx,[Coeficiente3];Paso el coeficiente para que se multiplique con la potencia
	mov dx,48
	sub bx,dx
	imul bx	
	Mov dl,[Signo3];Recupero el signo
	cmp dl,43
	je FuncionSuma3;Reviso si se lo sumo o se lo resto al resultado 
	mov bx,[variable]
	sub bx,ax
	mov [variable],bx
	jmp FuncionGraficar2
FuncionSuma3:
	mov bx,[variable]
	add bx,ax
	mov [variable],bx
FuncionGraficar2:
	mov dl,[Coeficiente2]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je FuncionGraficar1

	mov ax,cx
	mov bx,160
	sub ax,bx	;En ax tengo el valor de X actual en el plano
	Mov bx,ax	;En bx tambien tengo el valor de X actual en el plano 
	imul bx	
	Mov bx,[Coeficiente2];Paso el coeficiente para que se multiplique con la potencia
	mov dx,48
	sub bx,dx	
	imul bx	
	Mov dl,[Signo2];Recupero el signo
	cmp dl,43
	je FuncionSuma2;Reviso si se lo sumo o se lo resto al resultado 
	mov bx,[variable]
	sub bx,ax
	mov [variable],bx
	jmp FuncionGraficar1
FuncionSuma2:
	mov bx,[variable]
	add bx,ax
	mov [variable],bx

FuncionGraficar1:
	mov dl,[Coeficiente1]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je FuncionGraficar0
	
	mov ax,cx
	mov bx,160
	sub ax,bx	;En ax tengo el valor de X actual en el plano	
	Mov bx,[Coeficiente1];Paso el coeficiente para que se multiplique con la potencia
	mov dx,48
	sub bx,dx
	imul bx	
	Mov dl,[Signo1];Recupero el signo
	cmp dl,43
	je FuncionSuma1;Reviso si se lo sumo o se lo resto al resultado 
	mov bx,[variable]
	sub bx,ax
	mov [variable],bx
	jmp FuncionGraficar0
FuncionSuma1:
	mov bx,[variable]
	add bx,ax
	mov [variable],bx
FuncionGraficar0:
	mov dl,[Coeficiente0]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je FinPintarOriginal	
	Mov ax,[Coeficiente0];Paso el coeficiente para que se multiplique con la potencia	
	mov dx,48
	sub ax,dx
	Mov dl,[Signo0];Recupero el signo
	cmp dl,43
	je FuncionSuma0;Reviso si se lo sumo o se lo resto al resultado 
	mov bx,[variable]
	sub bx,ax
	mov [variable],bx
	jmp FinPintarOriginal
FuncionSuma0:
	mov bx,[variable]
	add bx,ax
	mov [variable],bx

FinPintarOriginal:
	mov ax,[Intervalo1]	
	mov dx,[Intervalo2]
	cmp cx,ax
	jle FinalitoPintarOriginal
	cmp cx,dx
	jge FinalitoPintarOriginal

	mov ax,100
	mov dx,[variable]
	sub dx,ax
	mov ax,dx
	mov dx,100
	sub dx,ax
	cmp dx,200;Esta comparacion es para ver si y se sale de la pantalla asi no pinta
	jge FinalitoPintarOriginal
	cmp dx,0;Esta comparacion es para ver si y se sale de la pantalla asi no pinta
	jle FinalitoPintarOriginal
	mov ah,0ch;servicio para pintar
  	mov al,03H;Color
  	int 10h;Interrupcion
FinalitoPintarOriginal:
	inc cx
	cmp cx,320
	jne PintarOriginal

	; esperar por tecla
  	mov ah,10h
	int 16h

  	; regresar a modo texto
  	mov ax,0003h
  	int 10h
	jmp N5
ErrorIntervalo:
	Mov dx,TErrorIntervalo;Pedir el primer numero
	mov ah,9
	int 21h
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	jmp N5
M2:;Grafico derivada

	Mov dx,TIntervalo1;Pedir el primer numero
	mov ah,9
	int 21h
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	;Meter el primer numero a mis variables
  	mov bx,0
  	mov cx,0
  	movzx si, byte [Bufer+1] 
  	mov dx, Bufer
  	add si, dx 

  	mov bp,10	
  	mov cx,0
  	mov al,byte [si]
  	sub al,48
  	mov ah,0
  	mul bp
  	add bx,ax
  	inc si
  	mov al,byte [si]
  	sub al,48 
  	mov ah,0
  	add bx,ax

  	dec si
  	dec si
  	cmp byte[si],43
  	je IntervaloM2Mas1
  	mov ax,bx
	mov bx,160
	sub bx,ax	;En ax tengo el valor de X actual en el plano
	dec bx
  	mov [Intervalo1],bx
  	jmp FinIntervalo1M2
  	;trabajo si fuera menos
IntervaloM2Mas1:
	mov ax,bx
	mov bx,160
	add bx,ax	;En ax tengo el valor de X actual en el plano
	dec bx
  	mov [Intervalo1],bx

FinIntervalo1M2:
	Mov dx,TIntervalo2;Pedir el primer numero
	mov ah,9
	int 21h
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	;Meter el primer numero a mis variables
  	mov bx,0
  	mov cx,0
  	movzx si, byte [Bufer+1] 
  	mov dx, Bufer
  	add si, dx 

  	mov bp,10	
  	mov cx,0
  	mov al,byte [si]
  	sub al,48
  	mov ah,0
  	mul bp
  	add bx,ax
  	inc si
  	mov al,byte [si]
  	sub al,48 
  	mov ah,0
  	add bx,ax

  	dec si
  	dec si
  	cmp byte[si],43
  	je IntervaloM2Mas2
  	mov ax,bx
	mov bx,160
	sub bx,ax	;En ax tengo el valor de X actual en el plano
	inc bx
  	mov [Intervalo2],bx
  	jmp FinIntervalo2M2
  	;trabajo si fuera menos
IntervaloM2Mas2:
	mov ax,bx
	mov bx,160
	add bx,ax	;En ax tengo el valor de X actual en el plano
	inc bx
  	mov [Intervalo2],bx
FinIntervalo2M2:
	mov ax,[Intervalo1]
	mov bx,[Intervalo2]
  	cmp ax,bx
  	jge ErrorIntervalo

	;Entro a modo grafico
	mov ax,0013h
  	int 10h
 	;PINTAR EJE Y,	CX ES COLUMNAS Y DX ES FILA
	;MAXIMO DE COLUMNA ES 320 
	;MAXIMO DE FILA ES 200
	mov cx,160;Me posiciono en columna central
	mov dx,0;Me posiciono en primera fila
PintarEjeY2:
	mov ah,0ch
  	mov al,0CH
  	int 10h
  	inc dx
  	cmp dx,200
  	jne PintarEjeY2

	mov cx,0;Me posiciono en primera columna
	mov dx,100;Me posiciono en fila central
PintarEjeX2:
	mov ah,0ch;servicio para pintar
  	mov al,0ch;Color
  	int 10h;Interrupcion
  	inc cx
  	cmp cx,320
  	jne PintarEjeX2


	mov cx,0;Me posiciono en la primera columna
PintarDerivada:
	mov bx,100
	mov [variable],bx
DerivadaGraficar4:
	mov dl,[Coeficiente4]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je DerivadaGraficar3
	;Primero obtengo el resultado de elevar el valor a la cuarta 
	mov ax,cx
	mov bx,160
	sub ax,bx	;En ax tengo el valor de X actual en el plano
	Mov bx,ax	;En bx tambien tengo el valor de X actual en el plano 
	imul bx	
	imul bx;El resultado se queda en ax
	Mov bx,[Coeficiente4];Paso el coeficiente para que se multiplique con la potencia
	mov dx,48
	sub bx,dx
	imul bx	
	mov bx,4 ;Multiplico por el 4 de la derivada 
	imul bx
	Mov dl,[Signo4];Recupero el signo
	cmp dl,43
	je DerivadaSuma4;Reviso si se lo sumo o se lo resto al resultado 
	mov bx,[variable]
	sub bx,ax
	mov [variable],bx
	jmp DerivadaGraficar3
DerivadaSuma4:
	mov bx,[variable]
	add bx,ax
	mov [variable],bx
DerivadaGraficar3:
	mov dl,[Coeficiente3]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je DerivadaGraficar2
	mov ax,cx
	mov bx,160
	sub ax,bx	;En ax tengo el valor de X actual en el plano
	Mov bx,ax	;En bx tambien tengo el valor de X actual en el plano 
	imul bx	
	Mov bx,[Coeficiente3];Paso el coeficiente para que se multiplique con la potencia
	mov dx,48
	sub bx,dx
	imul bx
	mov bx,3 ;Multiplico por el 3 de la derivada 
	imul bx	
	Mov dl,[Signo3];Recupero el signo
	cmp dl,43
	je DerivadaSuma3;Reviso si se lo sumo o se lo resto al resultado 
	mov bx,[variable]
	sub bx,ax
	mov [variable],bx
	jmp DerivadaGraficar2
DerivadaSuma3:
	mov bx,[variable]
	add bx,ax
	mov [variable],bx
DerivadaGraficar2:
	mov dl,[Coeficiente2]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je DerivadaGraficar1

	mov ax,cx
	mov bx,160
	sub ax,bx	;En ax tengo el valor de X actual en el plano	
	Mov bx,[Coeficiente2];Paso el coeficiente para que se multiplique con la potencia
	mov dx,48
	sub bx,dx	
	imul bx
	mov bx,2 ;Multiplico por el 2 de la derivada 
	imul bx
	Mov dl,[Signo2];Recupero el signo
	cmp dl,43
	je DerivadaSuma2;Reviso si se lo sumo o se lo resto al resultado 
	mov bx,[variable]
	sub bx,ax
	mov [variable],bx
	jmp DerivadaGraficar1
DerivadaSuma2:
	mov bx,[variable]
	add bx,ax
	mov [variable],bx

DerivadaGraficar1:
	mov dl,[Coeficiente1]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je FinPintarDerivada
	
	Mov ax,[Coeficiente1];Paso el coeficiente para que se multiplique con la potencia
	mov dx,48
	sub ax,dx	
	Mov dl,[Signo1];Recupero el signo
	cmp dl,43
	je DerivadaSuma1;Reviso si se lo sumo o se lo resto al resultado 
	mov bx,[variable]
	sub bx,ax
	mov [variable],bx
	jmp FinPintarDerivada
DerivadaSuma1:
	mov bx,[variable]
	add bx,ax
	mov [variable],bx

FinPintarDerivada:
	mov ax,[Intervalo1]	
	mov dx,[Intervalo2]
	cmp cx,ax
	jle FinalitoPintarDerivada
	cmp cx,dx
	jge FinalitoPintarDerivada

	mov ax,100
	mov dx,[variable]
	sub dx,ax
	mov ax,dx
	mov dx,100
	sub dx,ax
	cmp dx,200;Esta comparacion es para ver si y se sale de la pantalla asi no pinta
	jge FinalitoPintarDerivada
	cmp dx,0;Esta comparacion es para ver si y se sale de la pantalla asi no pinta
	jle FinalitoPintarDerivada
	mov ah,0ch;servicio para pintar
  	mov al,03H;Color
  	int 10h;Interrupcion
FinalitoPintarDerivada:
	inc cx
	cmp cx,320
	jne PintarDerivada

	; esperar por tecla
  	mov ah,10h
	int 16h

  	; regresar a modo texto
  	mov ax,0003h
  	int 10h
	jmp N5
	
M3:;Grafico Integral

	Mov dx,TConstante;Pedir el primer numero
	mov ah,9
	int 21h
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	;Meter el primer numero a mis variables
  	mov bx,0
  	mov cx,0
  	movzx si, byte [Bufer+1] 
  	mov dx, Bufer
  	add si, dx

  	mov bp,10	
  	mov cx,0
  	mov al,byte [si]
  	sub al,48
  	mov ah,0
  	mul bp
  	add bx,ax
  	inc si
  	mov al,byte [si]
  	sub al,48 
  	mov ah,0
  	add bx,ax

  	dec si
  	dec si
  	cmp byte[si],43
  	je ConstanteMas
  	mov ax,bx;El valor que ingreso 
	mov bx,0;Cero 
	sub bx,ax	;Hago la resta para que sea un numero negativo	
  	mov [Constante],bx
  	jmp FinConstante
  	;trabajo si fuera menos
ConstanteMas:	
  	mov [Constante],bx
FinConstante:




	Mov dx,TIntervalo1;Pedir el primer numero
	mov ah,9
	int 21h
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	;Meter el primer numero a mis variables
  	mov bx,0
  	mov cx,0
  	movzx si, byte [Bufer+1] 
  	mov dx, Bufer
  	add si, dx 

  	mov bp,10	
  	mov cx,0
  	mov al,byte [si]
  	sub al,48
  	mov ah,0
  	mul bp
  	add bx,ax
  	inc si
  	mov al,byte [si]
  	sub al,48 
  	mov ah,0
  	add bx,ax

  	dec si
  	dec si
  	cmp byte[si],43
  	je IntervaloM3Mas1
  	mov ax,bx
	mov bx,160
	sub bx,ax	;En ax tengo el valor de X actual en el plano
	dec bx
  	mov [Intervalo1],bx
  	jmp FinIntervalo1M3
  	;trabajo si fuera menos
IntervaloM3Mas1:
	mov ax,bx
	mov bx,160
	add bx,ax	;En ax tengo el valor de X actual en el plano
	dec bx
  	mov [Intervalo1],bx

FinIntervalo1M3:
	Mov dx,TIntervalo2;Pedir el primer numero
	mov ah,9
	int 21h
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
  	;Meter el primer numero a mis variables
  	mov bx,0
  	mov cx,0
  	movzx si, byte [Bufer+1] 
  	mov dx, Bufer
  	add si, dx 

  	mov bp,10	
  	mov cx,0
  	mov al,byte [si]
  	sub al,48
  	mov ah,0
  	mul bp
  	add bx,ax
  	inc si
  	mov al,byte [si]
  	sub al,48 
  	mov ah,0
  	add bx,ax

  	dec si
  	dec si
  	cmp byte[si],43
  	je IntervaloM3Mas2
  	mov ax,bx
	mov bx,160
	sub bx,ax	;En ax tengo el valor de X actual en el plano
	inc bx
  	mov [Intervalo2],bx
  	jmp FinIntervalo2M3
  	;trabajo si fuera menos
IntervaloM3Mas2:
	mov ax,bx
	mov bx,160
	add bx,ax	;En ax tengo el valor de X actual en el plano
	inc bx
  	mov [Intervalo2],bx
FinIntervalo2M3:
	mov ax,[Intervalo1]
	mov bx,[Intervalo2]
  	cmp ax,bx
  	jge ErrorIntervalo



	;Entro a modo grafico
	mov ax,0013h
  	int 10h

 	;PINTAR EJE Y,	CX ES COLUMNAS Y DX ES FILA
	;MAXIMO DE COLUMNA ES 320 
	;MAXIMO DE FILA ES 200
	mov cx,160;Me posiciono en columna central
	mov dx,0;Me posiciono en primera fila
PintarEjeY3:
	mov ah,0ch
  	mov al,0CH
  	int 10h
  	inc dx
  	cmp dx,200
  	jne PintarEjeY3

	mov cx,0;Me posiciono en primera columna
	mov dx,100;Me posiciono en fila central
PintarEjeX3:
	mov ah,0ch;servicio para pintar
  	mov al,0ch;Color
  	int 10h;Interrupcion
  	inc cx
  	cmp cx,320
  	jne PintarEjeX3


	mov cx,0;Me posiciono en la primera columna
PintarIntegral:
	mov bx,100
	mov [variable],bx
IntegralGraficar4:
	mov dl,[Coeficiente4]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je IntegralGraficar3
	;Primero obtengo el resultado de elevar el valor a la cuarta 
	mov ax,cx
	mov bx,160
	sub ax,bx	;En ax tengo el valor de X actual en el plano
	Mov bx,ax	;En bx tambien tengo el valor de X actual en el plano 
	imul bx
	imul bx
	imul bx
	imul bx;El resultado se queda en ax
	;Mov bx,[Coeficiente4];Paso el coeficiente para que se multiplique con la potencia
	;mov dx,48
	;sub bx,dx
	;imul bx
	;mov dx,0
	;mov bx,5
	;idiv bx	
	Mov dl,[Signo4];Recupero el signo
	cmp dl,43
	je IntegralSuma4;Reviso si se lo sumo o se lo resto al resultado 
	mov bx,[variable]
	sub bx,ax
	mov [variable],bx
	jmp IntegralGraficar3
IntegralSuma4:
	mov bx,[variable]
	add bx,ax
	mov [variable],bx
IntegralGraficar3:
	mov dl,[Coeficiente3]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je IntegralGraficar2
	mov ax,cx
	mov bx,160
	sub ax,bx	;En ax tengo el valor de X actual en el plano
	Mov bx,ax	;En bx tambien tengo el valor de X actual en el plano 
	imul bx
	imul bx	
	imul bx	
	Mov bx,[Coeficiente3];Paso el coeficiente para que se multiplique con la potencia
	mov dx,48
	sub bx,dx
	imul bx	
	mov dx,0
	mov bx,4
	idiv bx	
	Mov dl,[Signo3];Recupero el signo
	cmp dl,43
	je IntegralSuma3;Reviso si se lo sumo o se lo resto al resultado 
	mov bx,[variable]
	sub bx,ax
	mov [variable],bx
	jmp IntegralGraficar2
IntegralSuma3:
	mov bx,[variable]
	add bx,ax
	mov [variable],bx
IntegralGraficar2:
	mov dl,[Coeficiente2]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je IntegralGraficar1

	mov ax,cx
	mov bx,160
	sub ax,bx	;En ax tengo el valor de X actual en el plano
	Mov bx,ax	;En bx tambien tengo el valor de X actual en el plano 
	imul bx	
	imul bx	
	;Mov bx,[Coeficiente2];Paso el coeficiente para que se multiplique con la potencia
	;mov dx,48
	;sub bx,dx
	;imul bx	
	;mov dx,0	
	;mov bx,3
	;idiv bx	
	Mov dl,[Signo2];Recupero el signo
	cmp dl,43
	je IntegralSuma2;Reviso si se lo sumo o se lo resto al resultado 
	mov bx,[variable]
	sub bx,ax
	mov [variable],bx
	jmp IntegralGraficar1
IntegralSuma2:
	mov bx,[variable]
	add bx,ax
	mov [variable],bx

IntegralGraficar1:
	mov dl,[Coeficiente1]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je IntegralGraficar0
	
	mov ax,cx
	mov bx,160
	sub ax,bx	;En ax tengo el valor de X actual en el plano
	Mov bx,ax	;En bx tambien tengo el valor de X actual en el plano 
	imul bx	
	Mov bx,[Coeficiente1];Paso el coeficiente para que se multiplique con la potencia
	mov dx,48
	sub bx,dx
	imul bx
	mov dx,0
	mov bx,2
	idiv bx	
	Mov dl,[Signo1];Recupero el signo
	cmp dl,43
	je IntegralSuma1;Reviso si se lo sumo o se lo resto al resultado 
	mov bx,[variable]
	sub bx,ax
	mov [variable],bx
	jmp IntegralGraficar0
IntegralSuma1:
	mov bx,[variable]
	add bx,ax
	mov [variable],bx
IntegralGraficar0:
	mov dl,[Coeficiente0]
	cmp dl,48		;Comparo si es 0, si es asi salto esto
	je FinPintarIntegral
	mov ax,cx
	mov bx,160
	sub ax,bx	;En ax tengo el valor de X actual en el plano	
	Mov bx,[Coeficiente0];Paso el coeficiente para que se multiplique con la potencia	
	mov dx,48
	sub bx,dx
	imul bx
	Mov dl,[Signo0];Recupero el signo
	cmp dl,43
	je IntegralSuma0;Reviso si se lo sumo o se lo resto al resultado 
	mov bx,[variable]
	sub bx,ax
	mov [variable],bx
	jmp FinPintarIntegral
IntegralSuma0:
	mov bx,[variable]
	add bx,ax
	mov [variable],bx

FinPintarIntegral:
	mov ax,[Intervalo1]	
	mov dx,[Intervalo2]
	cmp cx,ax
	jle FinalitoPintarIntegral
	cmp cx,dx
	jge FinalitoPintarIntegral

	mov ax,100
	mov dx,[variable]
	sub dx,ax
	mov ax,dx
	mov dx,100
	sub dx,ax
	mov ax,[Constante]
	sub dx,ax
	cmp dx,200;Esta comparacion es para ver si y se sale de la pantalla asi no pinta
	jge FinalitoPintarIntegral
	cmp dx,0;Esta comparacion es para ver si y se sale de la pantalla asi no pinta
	jle FinalitoPintarIntegral
	mov ah,0ch;servicio para pintar
  	mov al,03H;Color
  	int 10h;Interrupcion
FinalitoPintarIntegral:
	inc cx
	cmp cx,320
	jne PintarIntegral

	; esperar por tecla
  	mov ah,10h
	int 16h

  	; regresar a modo texto
  	mov ax,0003h
  	int 10h
	jmp N5

M4:;Regreso a menu principal
	jmp Inicio
M5:	
	Mov dx,limpiar
	mov ah,9
	int 21h
	Mov dx,Otro
	mov ah,9
	int 21h	
	MOV DX, Bufer     ; Dirección del Bufer
  	MOV AH, 0Ah       ; función A entrada en búfer
  	INT 21h
	jmp N5
N6:
	mov dx,limpiar
	mov ah,9
	int 21h

	Mov dx,TN6
	mov ah,9
	int 21h

	mov ah,040h        ; the Write-to-a-file function for int 21h
    mov bx,1           ; the file handle for standard output
    mov cx,[msg_len]   ; number of bytes to write
    mov dx,msg         ; address of our "buffer" to write from
    int 021h           ; call on Good Old Dos
       ; now, lets read from a file that's already open,
       ; standard input - normally the keyboard.

	   
    mov ah,03Fh        ; the read-from-a-file function for int 21h
    mov bx,0           ; the file handle for standard input
    mov cx,0FFh        ; maximum number of bytes to read
    mov dx,textbuf     ; address of buffer to read into
    int 021h           ; call on Good Old Dos
    mov [text_len],ax  ; returns number of bytes actually read in ax
                       ; store it for future use

	
    mov ah,03Ch        ; the open/create-a-file function
    mov cx,020h        ; file attribute - normal file
    mov dx,filename    ; address of a ZERO TERMINATED! filename string
    int 021h           ; call on Good Old Dos
    mov [filehndl],ax  ; returns a file handle (probably 5)

    mov ah,040h        ; the Write-to-a-file function for int 21h
    mov bx,[filehndl]  ; the file handle goes in bx
    mov cx,[tituloreporte0_len]  ; number of bytes to write
    mov dx,tituloreporte0     ; address to write from (the text we input)
    int 021h           ; call on Good Old Dos

    mov ah,040h        ; the Write-to-a-file function for int 21h
    mov bx,[filehndl]  ; the file handle goes in bx
    mov cx,[tituloreporte1_len]  ; number of bytes to write
    mov dx,tituloreporte1     ; address to write from (the text we input)
    int 021h           ; call on Good Old Dos

    	mov ah, 2Ah
	int 21h

	mov al,dl
    ;al tiene el numero
	mov bl,0
	jmp PrimerDigitoDia
PrimerDigitoDia:
	mov cl,0
	cmp al,0
	je PintarDigitoDia
	mov cl,1
	cmp al,1
	je PintarDigitoDia
	mov cl,2
	cmp al,2
	je PintarDigitoDia
	mov cl,3
	cmp al,3
	je PintarDigitoDia
	mov cl,4
	cmp al,4
	je PintarDigitoDia
	mov cl,5
	cmp al,5
	je PintarDigitoDia
	mov cl,6
	cmp al,6
	je PintarDigitoDia
	mov cl,7
	cmp al,7
	je PintarDigitoDia
	mov cl,8
	cmp al,8
	je PintarDigitoDia
	mov cl,9
	cmp al,9
	je PintarDigitoDia
	sub al,10
	inc bl
	jmp PrimerDigitoDia
PintarDigitoDia:
	add bl,48  	
	add cl,48
  	
  	mov di, CadenaFecha
  	mov byte[di],bl
  	inc di
  	mov byte[di],cl
  	inc di
  	mov byte[di],47
  	inc di

	mov ah, 2Ah
	int 21h

	mov al,dh
    ;al tiene el numero
	mov bl,0
	jmp PrimerDigitoMes
PrimerDigitoMes:
	mov cl,0
	cmp al,0
	je PintarDigitoMes
	mov cl,1
	cmp al,1
	je PintarDigitoMes
	mov cl,2
	cmp al,2
	je PintarDigitoMes
	mov cl,3
	cmp al,3
	je PintarDigitoMes
	mov cl,4
	cmp al,4
	je PintarDigitoMes
	mov cl,5
	cmp al,5
	je PintarDigitoMes
	mov cl,6
	cmp al,6
	je PintarDigitoMes
	mov cl,7
	cmp al,7
	je PintarDigitoMes
	mov cl,8
	cmp al,8
	je PintarDigitoMes
	mov cl,9
	cmp al,9
	je PintarDigitoMes
	sub al,10
	inc bl
	jmp PrimerDigitoMes
PintarDigitoMes:
	add bl,48  	
	add cl,48
  	
  	mov byte[di],bl
  	inc di
  	mov byte[di],cl
  	inc di  	
  	mov byte[di],47
  	inc di

	mov byte[di],50;2
  	inc di
  	mov byte[di],48;0
  	inc di
	mov byte[di],49;1
  	inc di
  	mov byte[di],55;7
  	inc di  	
  	mov byte[di],32
  	inc di

  	mov ah,040h        ; the Write-to-a-file function for int 21h
    mov bx,[filehndl]  ; the file handle goes in bx
    mov cx,10  ; number of bytes to write
    mov dx,CadenaFecha     ; address to write from (the text we input)
    int 021h           ; call on Good Old Dos

    mov ah,040h        ; the Write-to-a-file function for int 21h
    mov bx,[filehndl]  ; the file handle goes in bx
    mov cx,[tituloreporte2_len]  ; number of bytes to write
    mov dx,tituloreporte2     ; address to write from (the text we input)
    int 021h           ; call on Good Old Dos

    mov ah, 2Ch
	int 21h

	mov al,ch
    ;al tiene el numero
	mov bl,0
	jmp PrimerDigitoHora
PrimerDigitoHora:
	mov cl,0
	cmp al,0
	je PintarDigitoHora
	mov cl,1
	cmp al,1
	je PintarDigitoHora
	mov cl,2
	cmp al,2
	je PintarDigitoHora
	mov cl,3
	cmp al,3
	je PintarDigitoHora
	mov cl,4
	cmp al,4
	je PintarDigitoHora
	mov cl,5
	cmp al,5
	je PintarDigitoHora
	mov cl,6
	cmp al,6
	je PintarDigitoHora
	mov cl,7
	cmp al,7
	je PintarDigitoHora
	mov cl,8
	cmp al,8
	je PintarDigitoHora
	mov cl,9
	cmp al,9
	je PintarDigitoHora
	sub al,10
	inc bl
	jmp PrimerDigitoHora
PintarDigitoHora:
	add bl,48  	
	add cl,48
  	
  	mov di, CadenaHora
  	mov byte[di],bl
  	inc di
  	mov byte[di],cl
  	inc di
  	mov byte[di],58
  	inc di

	mov ah, 2Ch
	int 21h

	mov al,cl
    ;al tiene el numero
	mov bl,0
	jmp PrimerDigitoMinuto
PrimerDigitoMinuto:
	mov cl,0
	cmp al,0
	je PintarDigitoMinuto
	mov cl,1
	cmp al,1
	je PintarDigitoMinuto
	mov cl,2
	cmp al,2
	je PintarDigitoMinuto
	mov cl,3
	cmp al,3
	je PintarDigitoMinuto
	mov cl,4
	cmp al,4
	je PintarDigitoMinuto
	mov cl,5
	cmp al,5
	je PintarDigitoMinuto
	mov cl,6
	cmp al,6
	je PintarDigitoMinuto
	mov cl,7
	cmp al,7
	je PintarDigitoMinuto
	mov cl,8
	cmp al,8
	je PintarDigitoMinuto
	mov cl,9
	cmp al,9
	je PintarDigitoMinuto
	sub al,10
	inc bl
	jmp PrimerDigitoMinuto
PintarDigitoMinuto:
	add bl,48  	
	add cl,48
  	
  	mov byte[di],bl
  	inc di
  	mov byte[di],cl
  	inc di
  	mov byte[di],58
  	inc di

  	mov ah,040h        ; the Write-to-a-file function for int 21h
    mov bx,[filehndl]  ; the file handle goes in bx
    mov cx,5  ; number of bytes to write
    mov dx,CadenaHora     ; address to write from (the text we input)
    int 021h           ; call on Good Old Dos

    mov ah,040h        ; the Write-to-a-file function for int 21h
    mov bx,[filehndl]  ; the file handle goes in bx
    mov cx,[tituloreporte3_len]  ; number of bytes to write
    mov dx,tituloreporte3     ; address to write from (the text we input)
    int 021h           ; call on Good Old Dos

    mov ah,040h        ; the Write-to-a-file function for int 21h
    mov bx,[filehndl]  ; the file handle goes in bx
    mov cx,[ContadorOriginal]  ; number of bytes to write
    mov dx,CadenaOriginal     ; address to write from (the text we input)
    int 021h           ; call on Good Old Dos

    mov ah,040h        ; the Write-to-a-file function for int 21h
    mov bx,[filehndl]  ; the file handle goes in bx
    mov cx,[tituloreporte4_len]  ; number of bytes to write
    mov dx,tituloreporte4     ; address to write from (the text we input)
    int 021h           ; call on Good Old Dos

    mov ah,040h        ; the Write-to-a-file function for int 21h
    mov bx,[filehndl]  ; the file handle goes in bx
    mov cx,[ContadorDerivada]  ; number of bytes to write
    mov dx,CadenaDerivada     ; address to write from (the text we input)
    int 021h           ; call on Good Old Dos

    mov ah,040h        ; the Write-to-a-file function for int 21h
    mov bx,[filehndl]  ; the file handle goes in bx
    mov cx,[tituloreporte5_len]  ; number of bytes to write
    mov dx,tituloreporte5     ; address to write from (the text we input)
    int 021h           ; call on Good Old Dos

    mov ah,040h        ; the Write-to-a-file function for int 21h
    mov bx,[filehndl]  ; the file handle goes in bx
    mov cx,[ContadorIntegral]  ; number of bytes to write
    mov dx,CadenaIntegral     ; address to write from (the text we input)
    int 021h           ; call on Good Old Dos

    mov ah,03Eh        ; the close-the-file function
    mov bx,[filehndl]  ; the file handle
    int 021h           ; call on Good Old Dos

	JMP Inicio

N7:
	MOV AX, 4C00h                      ; Servicio 4Ch,mensaje 0
  	INT 21h                            ; volvemos al DOS	
N8:;SELECCION DE CUALQUIER NUMERO EQUIVOCADO (RETORNA A INICIO)
	Mov dx,limpiar
	mov ah,9
	int 21h
	Mov dx,Otro
	mov ah,9
	int 21h	
	jmp Inicio
[section .data]
 
  	msg2 	db 0Dh,0Ah,'  ######################',0Dh,0Ah,'  ### MENU PRINCIPAL ###',0Dh,0Ah,'  ######################',0Dh,0Ah,0Ah,' ##############################',0Dh,0Ah,' ## 1) Ingresar funcion f(x) ##',0Dh,0Ah,' ## 2) Funcion en memoria    ##', 0Dh,0Ah,' ## 3) Derivada de f(x)      ##',0Dh,0Ah,' ## 4) Integral de f(x)      ##',0Dh,0Ah,' ## 5) Graficar funciones    ##',0Dh,0Ah,' ## 6) Reporte               ##',0Dh,0Ah,' ## 7) Salir                 ##',   0Dh,0Ah,' ##############################',0Dh,0Ah,'$',0
  	msg3 	db 0Dh,0Ah,' ###########################',0Dh,0Ah,' ### MENU DE OPERACIONES ###',0Dh,0Ah,' ###########################',0Dh,0Ah,0Ah,' ############################',0Dh,0Ah,' ## 1) Grafica original    ##',0Dh,0Ah,' ## 2) Graficar derivada   ##',0Dh,0Ah,' ## 3) Graficar integral   ##',0Dh,0Ah,' ## 4) Regresar            ##',0Dh,0Ah,' ##############################',0Dh,0Ah,'$',0
  	TN1		db 0Dh,0Ah,' ############################',0Dh,0Ah,' ## INGRESO DE UNA FUNCION ##',0Dh,0Ah,' ############################','$',0
  	TN2		db 0Dh,0Ah,' ############################',0Dh,0Ah,' ##   FUNCION EN MEMORIA   ##',0Dh,0Ah,' ############################','$',0
  	TN3		db 0Dh,0Ah,' ############################',0Dh,0Ah,' ##    MOSTRAR DERIVADA    ##',0Dh,0Ah,' ############################','$',0
  	TN4		db 0Dh,0Ah,' ############################',0Dh,0Ah,' ##    MOSTRAR INTEGRAL    ##',0Dh,0Ah,' ############################','$',0
  	TN5		db 0Dh,0Ah,'      ############################',0Dh,0Ah,'      ##   GRAFICAR FUNCIONES   ##',0Dh,0Ah,'      ############################',0Dh,0Ah,0Dh,0Ah,' ########################################',0Dh,0Ah,' ## 1) Graficar funcion original f(x)  ##',0Dh,0Ah,' ## 2) Graficar funcion derivada f`(x) ##',0Dh,0Ah,' ## 3) Graficar funcion Integral F(x)  ##',0Dh,0Ah,' ## 4) Regresar                        ##',0Dh,0Ah,' ########################################','$',0
  	TN6		db 0Dh,0Ah,' ############################',0Dh,0Ah,' ##         REPORTE        ##',0Dh,0Ah,' ############################',0Dh,0Ah,0Dh,0Ah,0,'$'
  	TN1x4 	db 0Dh,0Ah,' Ingrese coeficiente de x4: ','$',0
  	TN1x3 	db 0Dh,0Ah,' Ingrese coeficiente de x3: ','$',0
  	TN1x2 	db 0Dh,0Ah,' Ingrese coeficiente de x2: ','$',0
  	TN1x1 	db 0Dh,0Ah,' Ingrese coeficiente de x1: ','$',0
  	TN1x0 	db 0Dh,0Ah,' Ingrese coeficiente de x0: ','$',0
  	TESigno db 0Dh,0Ah,' Se esperaba un signo','$',0
  	TECoe 	db 0Dh,0Ah,' Se esperaba un digito (0-10)','$',0
  	TFun 	db 0Dh,0Ah,'      f(x) = ','$',0
  	TFun5	db '*x5 ','$',0
  	TFun4	db '*x4 ','$',0
  	TFun3	db '*x3 ','$',0
  	TFun2	db '*x2 ','$',0
  	TFun1	db '*x ','$',0
  	TEMem	db 0Dh,0Ah,0Ah,'No se encuentra una funcion almacenada!!','$',0
  	TDer 	db 0Dh,0Ah,0Ah,'      f`(x) = ','$',0
  	TInt 	db 0Dh,0Ah,0Ah,'      F(x) = ','$',0
  	;Reporte
  	msg db ' !! Pausa !!         ',0Dh,0Ah
    msg_len dw $-msg  ; let assembler count it...
    filename db 'reporte.rep',0
  	tituloreporte0 	db ' UNIVERSIDAD DE SAN CARLOS DE GUATEMALA',0Dh,0Ah,' FACULTAD DE INGENIERIA',0DH,0AH,' ESCUELA DE CIENCIAS Y SISTEMAS',0DH,0AH,' ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1 A',0DH,0AH,' SEGUNDO SEMESTRE 2017',0DH,0AH,' JOEL DANIEL ESAU PEREZ CAMEY',0DH,0AH,' 201404268',0DH,0AH,0AH,' REPORTE PRACTICA NO.3',0
  	tituloreporte0_len dw $-tituloreporte0-1
  	tituloreporte1 db 0Dh,0Ah, ' Fecha: ',0
  	tituloreporte1_len dw $-tituloreporte1-1
  	tituloreporte2 db 0Dh,0Ah, ' Hora: ',0
  	tituloreporte2_len dw $-tituloreporte2-1
  	tituloreporte3 db 0Dh,0Ah,0Ah, ' Funcion original:',0Dh,0Ah,'f(x) = ',0
  	tituloreporte3_len dw $-tituloreporte3-1
  	tituloreporte4 db 0Dh,0Ah,0Ah, ' Funcion derivada:',0Dh,0Ah,'f`(x) = ',0
  	tituloreporte4_len dw $-tituloreporte4-1
  	tituloreporte5 db 0Dh,0Ah,0Ah, ' Funcion integral:',0Dh,0Ah,'F(x) = ',0
  	tituloreporte5_len dw $-tituloreporte5-1

  	TIntervalo1 db 0Dh,0Ah,' Ingrese el valor inicial del intervalo: ','$',0
  	TIntervalo2 db 0Dh,0Ah,' Ingrese el valor Final del intervalo: ','$',0
  	TErrorIntervalo db 0Dh,0Ah,' !!ERROR!! El intervalo inicial es mayor que el final ','$',0
  	TConstante db 0Dh,0Ah,' Ingrese el valor de la constante (-99,+99): ','$',0

  	
  	limpiar db 0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,'$',0
  	Otro 	db 0Dh,0ah,' Ingreso una opcion incorrecta',0Dh,0ah,'$',0
  	Mensaje DB 0Dh,0Ah,' Ingresa numero: ','$',0
  	Bufer    DB   40                         ; Número de caracteres + 1  	
[section .bss]
	variable: 	resb 40	
	Constante: 	resb 40	
	;para manejar funciones
	ContadorOriginal resb 40
	ContadorDerivada resb 40
	ContadorIntegral resb 40
	
	Signo4 		 resb 40
	Signo3 		 resb 40
	Signo2 		 resb 40
	Signo1 		 resb 40
	Signo0 		 resb 40
	SignoInter1	 resb 40
	SignoInter2	 resb 40
	Coeficiente4 resb 40
	Coeficiente3 resb 40
	Coeficiente2 resb 40
	Coeficiente1 resb 40
	Coeficiente0 resb 40
	Intervalo1	 resb 40
	Intervalo2	 resb 40
	EstadoMem	 resb 40
	;Variables para leer archvio	
	nombre resb 01h      
    CadenaOriginal resd 0100h
    CadenaDerivada resd 0100h
    CadenaIntegral resd 0100h
    CadenaHora 	   resd 0100h
    CadenaFecha	   resd 0100h
    textbuf resb 0100h
    iobuf resb 0100h
    text_len resw 01h
    read_len resw 01h
    filehndl resw 01h