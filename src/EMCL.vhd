library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EMCL is port(
		
							AGB				: in	std_logic; --- A>B
							AEB				: in	std_logic; --- A=B
							ALB				: in	std_logic; ---  A<B
							vacay_mode		: in	std_logic; --- VACATION PUSH BUTTON
							FDWBD				: in  std_logic_vector(2 downto 0); --- FRONT DOOR WINDOW BACK DOOR 
							FURNACEON 		: out	std_logic;	--- FURNACE ON
							TEMPON			: out	std_logic;	--- DESIRED AND CURRENT TEMPERATURES ARE EQUAL INDICATOR
							ACON				: out	std_logic;	--- AC ON
							BLOWERON			: out	std_logic;	--- BLOWER ON
							BKDOOROPNON		: out	std_logic;	--- BACK DOOR OPEN
							WINDOPNON		: out	std_logic;	--- WINDOW OPEN
							FDOOROPPON		: out	std_logic;	--- FRONT DOOR OPEN
							VACARBON			: out	std_logic   --- VACATION INDICATOR
							
);
end EMCL;


architecture Internal of EMCL is

begin

---- INDICATING IF THE BACK DOOR OR FRONT DOOR OR WINDOW IS OPEN
	BKDOOROPNON			<=		FDWBD(0);
	WINDOPNON			<=		FDWBD(1);
	FDOOROPPON			<=		FDWBD(2);
	
---- INDICATING IF ON VACATION OR DESIRED AND CURRENT TEMPERATURES ARE EQUAL
	
	VACARBON				<=		vacay_mode;
	TEMPON				<=		AEB;
---- CONTROLING THE AC FURNACE AND BLOWER
---- KEY 
---- AGB = A, ALB = B, FDWBD(0) = C, FDWBD(1) = D, FDWBD(2) = E
	
	ACON					<=	((AGB) AND  (NOT FDWBD(0)) AND (NOT FDWBD(1)) AND (NOT FDWBD(2))); ----- AC'D'E'
	
	FURNACEON			<=	((ALB) AND  (NOT FDWBD(0)) AND (NOT FDWBD(1)) AND (NOT FDWBD(2))); -----BC'D'E
	
	BLOWERON				<=	((AGB) AND  (NOT FDWBD(0)) AND (NOT FDWBD(1)) AND (NOT FDWBD(2))) OR 
								((ALB) AND  (NOT FDWBD(0)) AND (NOT FDWBD(1)) AND (NOT FDWBD(2))); ----- AC'D'E' + BC'D'E



end architecture Internal;