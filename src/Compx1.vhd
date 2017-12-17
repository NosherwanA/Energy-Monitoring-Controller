library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity One_Bit_Comparator is port(

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
end One_Bit_Comparator;
			
			
			
architecture OBC of One_Bit_Comparator is

begin
		
		-- inputA -> a
		-- inputB -> b
		
		-- ab'
		AGB	 <= inputA AND (NOT inputB);
		
		-- ab + a'b' (equivilent to a XNOR b)
		AEB	 <= inputA XNOR inputB;
		-- a'b
		ALB	 <= (NOT inputA) AND inputB;

end architecture OBC;




----------------------------------------------------
-----TRUTH TABLE FOR EACH OUTPUT BIT----------------
----------------------------------------------------

--INPUTA----INPUTB---------A>B--------A=B-------A<B

----0---------0-------------0----------1---------0-
----0---------1-------------0----------0---------1-
----1---------0-------------1----------0---------0-
----1---------1-------------0----------1---------0-
	

---------------------------------------------------
--------BOOLEAN EXPRESSION FOR EACH OUTPUT---------
---------------------------------------------------


--A>B : F = (INPUTA)(INPUTB)'
--A<B : G = (INPUTB)(INPUTA)'
--A=B : H = (INPUTA)(INPUTB) + (INPUTA)'(INPUTB)'


---------------------------------------------------