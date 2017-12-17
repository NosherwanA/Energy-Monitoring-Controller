library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-----------------------------------------------------------
-- 4 to 1 Mux

entity Mux4to1 is 

	port( input_1	: in std_logic_vector(3 downto 0);
			input_2	: in std_logic_vector(3 downto 0);
			ctrl		: in std_logic;
			output	: out std_logic_vector(3 downto 0)
			);
			
end entity Mux4to1;

architecture internal of Mux4to1 is

begin
	
	-- input 1 is selected when ctrl = 0 else input 2 is selected
	
	with ctrl select
	
		output <=	input_1		when '0',
		
						input_2 		when '1',
						
						"0000" 		when others;
						
						
end architecture internal;