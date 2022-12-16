		.ORIG 	x3000       ; Adresse debut programme
        GETC                ; Acquisition sans prompt (sans affichage)
         
        OUT                 ; Affichage du caractere acquis au clavier 
        ST      R0,CHAR     ; Stockage du caractere dans CHAR 

        HALT                ; Arret du programme

CHAR    .BLKW   #1      
		.END

        