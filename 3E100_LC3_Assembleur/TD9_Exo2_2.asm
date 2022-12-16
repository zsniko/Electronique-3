       .ORIG x3000  ; le prog commence a 3000, aller chercher l'inst a cette adresse

       AND R1,R1,#0 ; R1 = R1 ET 0, idem R1 = 0
ONE    LD R0,A 
       ADD R1,R1,R0 ; R1 aucune information donc mettre R1 A 0 donc 👆 R1 AND 0
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
       