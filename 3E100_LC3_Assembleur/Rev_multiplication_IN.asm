		.ORIG 	x3000
        IN 
     	ST 		R0,A		; R0 -> A
        IN 
		ST		R0,B		; R0 -> B

        LD      R0,A        ; R0 <- A
        LD      R1,B        ; R1 <- B
        LD      R3,ASCII    ; R3 <- -x30
        ADD     R0,R0,R3    ; correction R0/A
        ADD     R1,R1,R3    ; correction R1/B
 
		AND		R2,R2,#0	; R2 <- 0

LOOP	ADD		R2,R2,R0	; R2 <- R2 + A
		ADD		R1,R1,#-1	; B <- B - 1
		BRnp	LOOP		; Retour LOOP si B /= 0

		ST		R2,MULT		; Sinon, MULT <- R0
		HALT			

ASCII   .FILL xFFD0
A		.BLKW #1
B		.BLKW #1
MULT	.BLKW #1
		.END