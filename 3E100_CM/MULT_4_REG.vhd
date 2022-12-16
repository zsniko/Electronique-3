library ieee,work;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MULT is
		port (CLK,RESET: in std_logic;
		     START: in std_logic;
		     A,B: in std_logic_vector(7 downto 0);
		     S: out std_logic_vector(15 downto 0);
		     FIN: out std_logic); 
end MULT;

architecture ARCHI of MULT is

type ETAT is(ATTENTE,DEBUT,CALCUL);
signal PRES,FUT: ETAT;

signal REG_A,REG_B,REG_RES,REG_LSB,MASQUE: std_logic_vector(7 downto 0);
signal SOMME: std_logic_vector(8 downto 0);
signal COMPTEUR: natural range 0 to 7;

begin

------------------------------------------------------------------------------
--									PARTIE CONTROLE							--
------------------------------------------------------------------------------
------------------------------------------
-- 		PROCESS DU REGISTRE D'ETAT 		--
------------------------------------------
process(CLK,RESET)
begin
	if RESET='0' then PRES<=ATTENTE;
	elsif rising_edge(CLK) then PRES<=FUT;
	end if;
end process;

--------------------------------------------------
-- 		PROCESS DE CALCUL DE L'ETAT FUTUR 		--
--------------------------------------------------
process(PRES,START,COMPTEUR)
begin
	case PRES is
	
		when ATTENTE => FUT<=ATTENTE;
						if START = '1' then FUT<=DEBUT; end if;		
		
		when DEBUT  =>  FUT<=CALCUL;
				
		when CALCUL =>  FUT<=CALCUL;
						if COMPTEUR = 7 then FUT<=ATTENTE; end if;
	end case;
end process;


----------------------------------------------
-- 		PROCESS DE CALCUL DES SORTIES 		--
----------------------------------------------
process(PRES)
begin
	case PRES is
		when ATTENTE	=> FIN <= '1';
		when DEBUT  	=> FIN <= '0';
		when CALCUL  	=> FIN <= '0';
	end case;
end process;

----------------------------------------------
-- 		PROCESS DE GESTION DU COMPTEUR 		--
----------------------------------------------
process(CLK,RESET)
begin
	if RESET='0' then COMPTEUR <= 0;
	elsif rising_edge(CLK) then
		case PRES is
			when ATTENTE	=> 	COMPTEUR <= 0;
			when DEBUT  	=> 	COMPTEUR <= 0;
			when CALCUL  	=> 	if (COMPTEUR<7) then COMPTEUR <= COMPTEUR+1; 
								end if;
		end case;
	end if;
end process;


------------------------------------------------------------------------------
--								PARTIE OPERATIVE							--
------------------------------------------------------------------------------
--------------------------
--		COMBINATOIRE 	--
--------------------------

-- Sortie du multiplieur - Concatenation des registres Res et LSB
S <= REG_RES & REG_LSB;

-- Masque: Realise l'operation AxB(j)
MASQUE <=REG_A when REG_B(0)='1'
         else (others =>'0');

-- Additionneur		 
SOMME <= '0'&MASQUE + REG_RES;



--------------------------
-- 		SEQUENTIEL 		--
--------------------------

-- Process de Gestion des registres	 
process(CLK,RESET)

begin

if RESET='0' then 	REG_A<=(others=>'0'); REG_B<=(others=>'0');
					REG_RES<=(others=>'0'); REG_LSB<=(others=>'0');

elsif rising_edge(CLK) then

	case PRES is
	
		-- Dans l'etat ATTENTE, tous les registres conservent leur valeur,
		-- pas besoin de l'ecrire explicitement dans le process
	
		-- Dans l'etat DEBUT, REG A et B chargent les valeurs en entree,
		-- RAZ de l'accumulateur (Res), le registre LSB conserve sa valeur
		when DEBUT => REG_A<=A; REG_B<=B; REG_RES<=(others=>'0');
				
		-- Dans l'etat CALCUL, REG RES charge les MSBde la somme
		-- REG B se decale d'un rang vers la droite,
		-- REG LSB se decale d'un rang vers la droite pour charger le LSB de la somme
		when CALCUL => 	REG_B	<= '0' & REG_B(7 downto 1);
						REG_RES	<= SOMME(8 downto 1);
						REG_LSB	<= SOMME(0) & REG_LSB(7 downto 1);
		when others => NULL;
	end case;
end if;
end process;
end archi;






