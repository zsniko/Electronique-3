		.ORIG 	x3000
        
ONE 	LD 		R0,A		; R0 <- A
		LD		R1,B		; R1 <- B
		AND		R2,R2,#0	; R2 <- 0

LOOP	ADD		R2,R2,R0	; R2 <- R2 + A
		ADD		R1,R1,#-1	; B <- B - 1
		BRnp	LOOP		; Retour ‡ LOOP si B /= 0 
                            ; si resultat n ou p (!= 0)
                            ; ici 4 fois addition : multiplication A * 4

		ST		R2,MULT		; Sinon, MULT <- R2
		TRAP 	x25			; Fin Programme

A		.FILL	x0006       ; A et V definis 
B		.FILL 	x0004
MULT	.BLKW	#1
		.END

