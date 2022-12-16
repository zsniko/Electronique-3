       .ORIG x3000  ; le prog commence a 3000, aller chercher l'inst a cette adresse

       AND R1,R1,#0 ; R1 = R1 ET 0, idem R1 = 0
ONE    LD R0,A 
       ADD R1,R1,R0 ; R1 aucune information donc mettre R1 A 0 donc 👆 R1 AND 0
TWO    LD R0,B      
       ADD R1,R1,R0
THREE  LD R0,C
       ADD R1,R1,R0
       ST R1,SUM
       TRAP x25

A    .FILL x0001
B    .FILL x0002
C    .FILL x0003
D    .FILL x0004
SUM  .BLKW #1    ; BLKW directive qui reserve un espace memoire 
                 ; si BLKW #3 cases, TOTO sera a x....+3
TOTO .FILL x5555

.END
       
       