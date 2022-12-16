          .ORIG x3000
    
          AND R1,R1,#0  ; Compteur
          AND R2,R2 #0  ; Somme
          ADD R1,R1,#4  ; Nb Chiffre

BOUCLE    IN
          LD  R3,ASCII  ; R3 <= -x30
          ADD R0,R0,R3  ; Correction 
          ADD R2,R2,R0  ; Somme = Somme + Chiffre
          ADD R1,R1,#-1 ; Decrem compteur
          BRp BOUCLE
          
          ADD R0,R2,#0 
          LD  R4,INV
          ADD R0,R0,R4 
          OUT  
          ; ATTENTION MARCHE PAS SI LE RESULTAT SOMME EST > 10 
          ; CAR OUT AFFICHE UN SEUL CARACTERE
          
          ST  R2,RES    ; Transfert resultat


          ADD R2,R2,#-16
          BRzp AFF_S
          
          LD R0,I
          OUT
          BR FIN

AFF_S     LD R0,S
          OUT
          
FIN       HALT

ASCII   .FILL xFFD0
INV     .FILL x30
RES     .BLKW #1
S	.FILL x53	    ; Code ASCII de S
I	.FILL x49	    ; Code ASCII de I
        .END