library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity One_Bit_Comparator is port(
			
			inputA	:	in std_logic;
			inputB	:	in std_logic;
			AGB		:	out std_logic;
			AEB		: 	out std_logic;
			ALB		: 	out std_logic;
			
			);
end One_Bit_Comparator;
			
			
			
architecture OBC of One_Bit_Comparator is


		AGB	 <= inputA AND (NOT inputB);
		AEB	 <= inputA XNOR inputB;
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
	
		