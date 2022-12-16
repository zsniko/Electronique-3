       .ORIG x3000  ; le prog commence a 3000, aller chercher l'inst a cette adresse

       AND R1,R1,#0 ; Init R1 = 0
       LD R2,SUM    ; R2 <- Adresse de la case memoire où on ecrira la somme partielle 
       ;LEA R4,LABEL 4000 trop loin

ONE    LD R0,A 
       ADD R1,R1,R0 
                    ; base + offset, REGISTRE, BASE, OFFSET #0 car on a deja charge dans R2 la bonne valeur d'adresse
       STR R1,R2,#0 ; Mem[R2+0] <- R1
       ADD R2,R2,#1 ; R2 <- R2 + 1 
       ; amener la valeur de R2 dans l<'adder a gauche, + offset 
       ; au lieu de partir du PC, on part de R2. 

TWO    LD R0,B      
       ADD R1,R1,R0

THREE  LD R0,C
       ADD R1,R1,R0
    
       STI R1,SUM    ; ***** Adressage indirect: STI car x4000 tres loin 
                     ; offset 9 bits signes PC-256 <-> PC+255
       TRAP x25

A    .FILL x0001
B    .FILL x0002
C    .FILL x0003
D    .FILL x0004
SUM  .FILL x4000     ; ***** Adressage indirect ; BLKW impossible d'initialiser 

.END
       