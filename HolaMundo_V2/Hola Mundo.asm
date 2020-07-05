.model small

.stack

.data

    mensaje: db  "Hola mundo V2",13,10,"$"

.code

    .startup
       
       LEA      dx, mensaje
       MOV      ah, 09h
       INT      21h
       
       MOV      ax, 0c07h
       INT      21h 
        
    .exit

end