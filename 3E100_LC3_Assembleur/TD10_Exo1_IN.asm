		.ORIG 	x3000
        IN                  ; Demander a l'utilisateur d'entrer un chiffre (IN: dans R0, tjrs.)
                            ; MAIS! IN prend le code ASCII de la touche, donc le resultat est faux, il faut le corriger
ONE 	ST      R0,A		; stockage de A 
        IN
TWO     ST      R0,B        ; stockage de B 
		
        LD      R0,A        ; R0 <- A
        LD      R1,B        ; R1 <- B
	AND	R2,R2,#0	; R2 <- 0

        LD      R3,ASCII    ; R3 <- ASCII (Avant de faire l'addition corrective il faut load dans un registre, par ex R3)
        ADD     R0,R0,R3    ; Correction de A (Pour obtenir le chiffre a partir du code ascii)
        ADD     R1,R1,R3    ; Correction de B (R1 = R1 + 0xFFD0)

LOOP	ADD		R2,R2,R0	; R2 <- R2 + A
	ADD		R1,R1,#-1	; B <- B - 1
	BRnp	LOOP		; Retour ‡ LOOP si B /= 0 
                            ; si resultat n ou p (!= 0)
                            ; ici B fois addition : multiplication A * B

	ST		R2,MULT		; Sinon, MULT <- R2
	TRAP 	x25			; Fin Programme

ASCII   .FILL   xFFD0       ; offset code ASCII   chiffres : -x0030 
A		.BLKW	#1          ; reservation emplacement memoire pour stocker A
B		.BLKW   #1          
MULT	.BLKW	#1
		.END

        