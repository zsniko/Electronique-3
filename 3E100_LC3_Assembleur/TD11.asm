                .ORIG x3000
MAIN            JSR   INIT_TIMER  ; Sous-programme de Configuration du Timer
                JSR   START_APP   ; Demarrage de l'application
                JSR   GET_CHIFFRE ; Acquisition du Chiffre
                JSR   CHK_CHIFFRE ; Verification du Chiffre

FIN             HALT              ; Fin du programme

; ------ sous programme Init Timer
INIT_TIMER      LD    R0,REINIT
                STI   R0,TSR
                LD    R0,MODE_I
                STI   R0,TSR
                LD    R0,DELAIS
                STI   R0,TMR
                RET               ; Retour au programme principal

; ------  sous programme Start APP
START_APP       ST    R7,SAVE_R7  ; Sauvegarde adresse de retour avant SOUS sous prog sinon perdue
                LEA   R0,MSG1     ; R0 <- Adresse du 1er caractere de MSG1
                PUTS              ; Affichage MSG1
                GETC              ; Attente acquisition caractere
                LEA   R0,MSG2     ; R0 <- Adresse du 1er caractere de MSG2
                PUTS              ; Affichage MSG2
                GETC              ; Attente acq caract
                LD    R7,SAVE_R7  
                RET               ; Retour prog principal

; -----  sous programme get chiffre
GET_CHIFFRE     LD   R0,DEMAR     ; R0 <- Demarrage Timer
                STI  R0,TSR       ; R0 -> TSR
                LD   R1,MASK      ; R1 <- 0100 0000 0000 0000  MASK
WAIT_LOOP       LDI  R0,KSR       ; R0 <- Status Registre INPUT
                BRn  INPUT_OK     ; Branchement Si Ready = 1 (bit 15) donc negatif (signe)
                LDI  R0,TSR       ; R0 <- Timer Status
                AND  R0,R0,R1     ; R0 <- QUE Bit 14 
                BRz  WAIT_LOOP    ; Branchement Loop si bit 14 tjrs = 0

                TRAP x25          ; Si TimeOut, arret processeur
INPUT_OK        RET

; ------ sous programme check chiffre 
CHK_CHIFFRE     LDI R0,KDR        ; R0 <- Code ASCII du chiffre saisi
                LD  R1,ASCII
                ADD R0,R0,R1      ; R0 <- Valeur numerique saisie
                LDI R2,CHIFFRE
                NOT R2,R2
                ADD R2,R2,#1     
                ADD R0,R0,R2
                BRz GAGNE

                LEA R0,MSG_LOST
                PUTS
                BR  FIN_PROG

GAGNE           LEA R0,MSG_WIN
                PUTS

FIN_PROG        HALT     


TVR         .FILL xC000
TMR         .FILL xC002
TSR         .FILL xC004
DELAIS      .FILL #50000
REINIT      .FILL #2            ; Commande Reset Timer
MODE_I      .FILL #4            ; Selection mode incrementation
DEMAR       .FILL #5            ; 5 au lieu de 1 car il faut garder le mode incrementation

SAVE_R7     .BLKW #1
MSG1        .STRINGZ "Appuyer sur une touche..."  
MSG2        .STRINGZ "Choisir un chiffre avant 5 secondes..."     

MASK        .FILL x4000
KSR         .FILL xFE00

KDR         .FILL xFE02    
ASCII       .FILL xFED0
CHIFFRE     .FILL xA000
MSG_WIN     .STRINGZ "Bravo!"
MSG_LOST    .STRINGZ "Perdu!"  
            .END  