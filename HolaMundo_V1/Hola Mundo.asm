.model tiny

.data

    h db "hola mundo",13,10,"otra linea",13,10,"$"
    
.code

.startup

    mov dx, offset h
    mov ah,9
    int 21h
    
    mov ax,0c07h
    int 21h
    
.exit

end