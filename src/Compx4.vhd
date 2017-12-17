library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Four_Bit_Comparator is port(

			--Two 4 bit input signals
			inputnumA	:	in std_logic_vector(3 downto 0);
			inputnumB	:	in std_logic_vector(3 downto 0);
			
			--1 bit output signal if inputA > inputB
			AGB		:	out std_logic;
			
			--1 bit output signal if inputA = inputB
			AEB		: 	out std_logic;
			
			--1 bit output signal if inputA < inputB
			ALB		: 	out std_logic
			
			);
end Four_Bit_Comparator;
			
			
			
architecture FBC of Four_Bit_Comparator is
		
		--Outputs from the one bit comparitor for the MSB (3rd bit)
		signal A		:	std_logic;
		signal B		:	std_logic;
		signal C		:	std_logic;
		
		--Outputs from the one bit comparitor for the 2nd bit
		signal D		:	std_logic;
		signal E		:	std_logic;
		signal F		:	std_logic;
		
		--Outputs from the one bit comparitor for the 1st bit
		signal G		:	std_logic;
		signal H		:	std_logic;
		signal I		:	std_logic;
		
		--Outputs from the one bit comparitor for the LSB (0th bit)
		signal J		:	std_logic;
		signal K		:	std_logic;
		signal L		:	std_logic;
		
		--The one bit comparator required for the four bit comparitor
		component One_Bit_Comparator port(
			
			--Two 1 bit input signals
			inputA	:	in std_logic;
			inputB	:	in std_logic;
			--1 bit output signal if inputA > inputB
			AGB		:	out std_logic;
			--1 bit output signal if inputA = inputB
			AEB		: 	out std_logic;
			--1 bit output signal if inputA < inputB
			ALB		: 	out std_logic
			
			);
		end component;
		


begin
		
		--Creating the four instances of the one bit adder
		TTHB:	One_Bit_Comparator port map(inputnumA(3),inputnumB(3),C,B,A);
		STHB:	One_Bit_Comparator port map(inputnumA(2),inputnumB(2),F,E,D);
		FTHB:	One_Bit_Comparator port map(inputnumA(1),inputnumB(1),I,H,G);
		ZTHB:	One_Bit_Comparator port map(inputnumA(0),inputnumB(0),L,K,J);
		
		
		-- LOGIC FOR inputnumA greater for inputnumB
		
		-- (A'B'C) OR (A'BC'D'E'F) 
		--  OR (A'BC'D'E'F'G'H'I) OR (A'BC'D'EF'G'HI'J'K'L)
		
		AGB	 <= (((NOT A) AND (NOT B) AND (C)) OR 
					 ((NOT A) AND (B) AND (NOT C) AND (NOT D) AND (NOT E) AND (F)) OR
					 ((NOT A) AND (B) AND (NOT C) AND (NOT D) AND (E) AND (NOT F) AND (NOT G) AND (NOT H) AND (I)) OR
					 ((NOT A) AND (B) AND (NOT C) AND (NOT D) AND (E) AND (NOT F) AND (NOT G) AND (H) AND (NOT I) AND (NOT J) AND (NOT K) AND (L)));
		
		-- LOGIC FOR inputnumA lesser for inputnumB
	
		-- (AB'C') OR (A'BC'DE'F') 
		--  OR (A'BC'DE'F'GH'I') OR (A'BC'D'E'F'G'HI'JK'L')
		
		
		ALB	 <= (((A) AND (NOT B) AND (NOT C)) OR 
					 ((NOT A) AND (B) AND (NOT C) AND (D) AND (NOT E) AND (NOT F)) OR
				    ((NOT A) AND (B) AND (NOT C) AND (NOT D) AND (E) AND (NOT F) AND (G) AND (NOT H) AND (NOT I)) OR
					 ((NOT A) AND (B) AND (NOT C) AND (NOT D) AND (E) AND (NOT F) AND (NOT G) AND (H) AND (NOT I) AND (J) AND (NOT K) AND (NOT L)));
		
		
		-- LOGIC FOR inputnumA equal to inputnumB
		
		-- (A'BC'D'EF'G'HI'J'KL')
		
		AEB	 <=  ((NOT A) AND (B) AND (NOT C) AND (NOT D) AND (E) AND (NOT F) AND (NOT G) AND (H) AND (NOT I) AND (NOT J) AND (K) AND (NOT L));

end architecture FBC;

--A>B : F = AB'C' + A'BC'DE'F' + A'BC'D'E'F'G'H'I + A'BC'D'EF'G'HI'J'K'L
--A<B : G = AB'C' + A'BC'DE'F' + OR A'BC'DE'F'GH'I' + A'BC'D'E'F'G'HI'JK'L'
--A=B : H = A'BC'D'EF'G'HI'J'KL'


--KEY A= RESULT FOR 3RD BIT (MSB) OF INPUT A LESS THAN 3RD BIT(MSB) OF INPUT B ,
--		B= RESULT FOR 3RD BIT (MSB) OF INPUT A EQUAL TO 3RD BIT(MSB) OF INPUT B, 
--		C= RESULT FOR 3RD BIT (MSB) OF INPUT A GREATER THAN 3RD BIT(MSB) OF INPUT B,

--KEY D= RESULT FOR 2ND BIT OF INPUT A LESS THAN 2ND BIT OF INPUT B ,
--		E= RESULT FOR 2ND BIT OF INPUT A EQUAL TO 2ND BIT OF INPUT B, 
--		F= RESULT FOR 2ND BIT OF INPUT A GREATER THAN 2ND BIT OF INPUT B,

--KEY G= RESULT FOR 1ST BIT OF INPUT A LESS THAN 1ST BIT OF INPUT B ,
--		H= RESULT FOR 1ST BIT OF INPUT A EQUAL TO 1ST BIT OF INPUT B, 
--		I= RESULT FOR 1ST BIT OF INPUT A GREATER THAN 1ST BIT OF INPUT B,

--KEY J= RESULT FOR 0TH BIT(LSB) OF INPUT A LESS THAN 0TH BIT(LSB) OF INPUT B ,
--		K= RESULT FOR 0TH BIT(LSB) OF INPUT A EQUAL TO 0TH BIT(LSB) OF INPUT B, 
--		L= RESULT FOR 0TH BIT (LSB) OF INPUT A GREATER THAN 0TH BIT(LSB) OF INPUT B,


