;TD9 - EXERCICE 1

     .ORIG x3000    ; Adresse debut prog.
     ; A B pas ici sinon valeur numerique a b est cherchee et correspond a une instruction qui peut etre n'importe quoi 

    LD R0,A         ; R0<-A  (6)
    LD R1,B         ; R1<-B  (4)
                    
                    ; valeur immediate codee sur 5 bits donc on ne peut pas faire ADD R1,R1,#2000, par exemple
    NOT R1,R1       ; complement a 2 de R1
    ADD R1,R1,#1    ; R1 <- (-B)   

    ADD R2,R1,R0    ; R2 <- (A-B) (normalement stocker dans la memoire ou..)
     
    HALT            ; Idem TRAP x25 
                    ; Arret du processeur 


A    .FILL #6       ; EN DECIMAL #    CONSTANTE A ET B     adresse x3006
B    .FILL #4       ; adresse x3007

.END
