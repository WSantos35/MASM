.model tiny

.data
  
    
.code
    

    .startup
    
    
    while:
        MOV     dl, 5+48
        MOV     ah, 02h
        INT     21h
        JMP     while
        
 
 
    MOV     ax,0c07h
    INT     21h   
    .exit
end   


;=====================un segundo ejemplo utilizando macro con parametro=============================

;.model tiny

;.data
  
    
;.code
    
   ; imprimirDigito MACRO parametro
   ;     MOV     dl, parametro+48
   ;     MOV     ah, 02h
   ;     INT     21h
   ;     JMP     while
   ; ENDM
    

   ; .startup
    
    
   ; while:
   ;     imprimirDigito 3
        
 
 
   ; MOV     ax,0c07h
   ; INT     21h   
   ; .exit
;end