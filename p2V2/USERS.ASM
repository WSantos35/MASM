
    ms13 db 'Usuario:',13,10,'$'
    ms14 db 'Contrasenia: ',13,10,'$'

    ms15 db 'Usuario Registrado',13,10,'$'



US STRUCT 
 estado byte 0          ;1  byte
 name db 22 dup (' ')     ;22 byte
 pass db 22 dup (0)     ;22 byte
 puntos word 0          ;16 byte
 tiempo word 0          ;16 byte
US ENDS          ;Total:67 bytes

ARRAUS US 255 DUP ({'$'},{'$'})

PTRAR dw offset ARRAUS
user db 22,19 dup (' '),'$',0
pass db 22,19 dup (0),'$',0
puntos word 0
tiempo word 0

INISIGNIN MACRO 
    local copyname
    local copypass
    limpia                            
    imprimir ms10
    imprimir salto
    imprimir ms13
    leer user
    imprimir salto
    imprimir ms14
    leer pass
    imprimir salto
    imprimir salto

    mov si,PTRAR
    ;cambiando estado de nuevo bloque disponible
    mov byte ptr[si],1
    inc si
        ;--copiando nombre
        lea di,user
        mov cx,22d       
        copyname:
        mov ah,byte ptr[di]
        mov byte ptr[si],ah                
        inc si
        inc di
        loop copyname
        ;--copiando pass
        lea di,pass
        mov cx,22d        
        copypass:
        mov ah,byte ptr[di]
        mov byte ptr[si],ah                
        inc si
        inc di
        loop copypass
        add si,4;saltando variables de puntos y tiempo
        mov byte ptr[si],'X'
        mov PTRAR,si

    ;add si,67 ;desplazando punteor al siguiente usuario disponible
    ;mov PTRAR,si
    VERUSERS
    ;pause
    ;imprimir ms15
    ;imprimir user+2
    ;imprimir salto
    ;imprimir pass+2

    fin:
ENDM


ms16 db 'Usuario o Contrasenia incorrecta$',0
usadmin db 'adminAI'
pwadmin db '4321'
INILOGIN MACRO 
    local noadmin
    local fin
    limpia
    imprimir ms9
    imprimir salto
    imprimir ms13
    leer user
    imprimir salto
    imprimir ms14
    leer pass
    imprimir salto
    imprimir salto

    ;verificando si es usuario admin
    CompareStringF usadmin,user+2,7d,noadmin
    CompareStringF pwadmin,pass+2,4d,noadmin
    INIADMIN
    jmp fin
    noadmin:
    ;comprobando credeniales del usuario
    FINDUS user,pass,INIGAME,fin
    ;en este punto no se encontro el usuario
    imprimir ms16
    pause
    fin:
ENDM




FINDUS macro usr,pwd,mev,esalida
  local printuser
  local fin
  local compname
  local comppass     
  push ax
  push bx
  push cx
  push dx
  push si


  

  mov si,offset ARRAUS
  sub si,4
  mov cx,0

  
  finduser:
  add si,cx
  add si,4
  ;---saltando puntos y tiempo
  cmp byte ptr[si],1    ;comprobando usuario activo
  jne fin   
        inc si
        ;--comparando nombre      
        lea di,usr
        mov cx,22d        
        compname:
          mov ah,byte ptr[si]
          mov al,byte ptr[di] 
          add cx,22
          cmp ah,al                
          jne finduser     
          sub cx,22        
          inc si
          inc di
        loop compname
  ;---comparando pass a var aux      
        lea di,pwd
        mov cx,22d        
        comppass:
        mov ah,byte ptr[si]
        mov al,byte ptr[di]        
        cmp ah,al
        jne finduser
        inc si
        inc di                
        loop comppass  
        ;en este punto la contraseña y el usuario son los mismo      
        ;seteando datos para el juego
        mov puntos,0
        mov tiempo,0
        sub si,45;restando pra colocar el apuntador al inicio del bloque
        mov ptr_actualus,si
        mev;llamando macro que ejecuta el juego
        jmp esalida
  fin:

  pop si
  pop dx
  pop cx
  pop bx
  pop ax
ENDM

;-----------------------Macro que muestra los datos de los usuarios-----------------------
ms17 db 'Puntos:',13,10,'$'
ms18 db 'Tiempo:',13,10,'$'
prb db 10 dup (0)

hl db '---------------------------',13,10,'$'

ms19 db 'No existe ningun usuario',13,10,'$'


VERUSERS macro
   local printuser
   local fin
    local copyname
    local copypass   
  mov si,offset ARRAUS


  printuser:
  cmp byte ptr[si],1    ;comprobando usuario activo
  jne fin   
        inc si
  ;---copiando nombre a var aux
        ;--copiando nombre
        lea di,user
        mov cx,22d        
        copyname:
        mov ah,byte ptr[si]
        mov byte ptr[di],ah                
        inc si
        inc di
        loop copyname
  ;---copiand pass a var aux
        lea di,pass
        mov cx,22d        
        copypass:
        mov ah,byte ptr[si]
        mov byte ptr[di],ah                
        inc si
        inc di
        loop copypass  
  ;---copiando puntos a var aux
    mov ax,word ptr[si]
    mov puntos,ax
    add si,2
  ;---copiando tiempo a var aux
    mov ax,word ptr[si]
    mov tiempo,ax
    add si,2

  push si

  imprimir ms13
  imprimir user+2
  imprimir salto
  imprimir ms14
  imprimir pass+2
  imprimir salto
  imprimir ms17
  HexToDec16 puntos,prb
  imprimir prb
  imprimir salto
  imprimir ms18
  HexToDec16 tiempo,prb
  imprimir prb  
  imprimir salto
  pop si
  
  lea di,prb
  mov ah,byte ptr[si]
  mov byte ptr [di],ah
  mov ah,'$'
  mov byte ptr[di+1],ah  

  imprimir hl
  imprimir prb
  imprimir salto
  imprimir hl

  jmp printuser
  fin:
ENDM

