.model small
.data
    msg db "zurk, 2015","$"
    
.code

    main PROC
        mov ax, seg msg
        mov ds, ax
        mov ah, 09h
        lea dx, msg
        int 21h
        .exit
        main endp
    
    end main