library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab3_top is port (
   clkin_50		: in	std_logic;
	pb				: in	std_logic_vector(3 downto 0);
 	sw   			: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds			: out std_logic_vector(7 downto 0);	-- for displaying the switch content
   seg7_data 	: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  : out	std_logic;							-- seg7 digi selectors
	seg7_char2  : out	std_logic							-- seg7 digi selectors
	
); 
end LogicalStep_Lab3_top;

architecture Energy_Monitor of LogicalStep_Lab3_top is
--
-- Components Used
------------------------------------------------------------------- 
		
		component Four_Bit_Comparator port(
			
			--Two 4 bit input signals
			inputnumA	:	in std_logic_vector(3 downto 0);
			inputnumB	:	in std_logic_vector(3 downto 0);
			--1 bit output signal if inputA > inputB
			AGB			:	out std_logic;
			--1 bit output signal if inputA = inputB
			AEB			: 	out std_logic;
			--1 bit output signal if inputA < inputB
			ALB			: 	out std_logic
			
			);
		end component;
		
		component Mux4to1 port(
			
			input_1	: in std_logic_vector(3 downto 0);
			input_2	: in std_logic_vector(3 downto 0);
			ctrl		: in std_logic;
			output	: out std_logic_vector(3 downto 0)
			);
		end component;
		
		
		component EMCL port(
		
							AGB				: in	std_logic;
							AEB				: in	std_logic;
							ALB				: in	std_logic;
							vacay_mode		: in	std_logic;
							FDWBD				: in  std_logic_vector(2 downto 0);
							FURNACEON 		: out	std_logic;	
							TEMPON			: out	std_logic;	
							ACON				: out	std_logic;	
							BLOWERON			: out	std_logic;	
							BKDOOROPNON		: out	std_logic;	
							WINDOPNON		: out	std_logic;	
							FDOOROPPON		: out	std_logic;	
							VACARBON			: out	std_logic
		);
		end component;
		
		component SevenSegment port (
		
				hex	   :  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   
				sevenseg :  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
				); 
		end component;
		
		component segment7_mux port (
          clk        : in  std_logic := '0';
			 DIN2 		: in  std_logic_vector(6 downto 0);	
			 DIN1 		: in  std_logic_vector(6 downto 0);
			 DOUT			: out	std_logic_vector(6 downto 0);
			 DIG2			: out	std_logic;
			 DIG1			: out	std_logic
        );
		end component;


------------------------------------------------------------------
	
	
-- Create any signals, or temporary variables to be used

	signal curr_temp				: std_logic_vector(3 downto 0); -- Current temperature
	signal desi_temp  			: std_logic_vector(3 downto 0); -- Desired temperature
	signal door_wind_open  		: std_logic_vector(2 downto 0); -- Front back doors and windows
	signal furn_on					: std_logic;-- furnace on signal	
	signal syst_at_temp			: std_logic;-- Current and desired temperature equality signal	
	signal ac_on					: std_logic;-- AC on signal 
	signal blow_on 				: std_logic;-- Blower on signal
	signal door_wind_op			: std_logic_vector(2 downto 0);-- front back door and window open indicator

	signal mux_out					: std_logic_vector(3 downto 0); -- output of the mux selecting non vacation and vacation desired temp
	signal inverted_pb			: std_logic; -- vacation mode push button
	signal AGRB						: std_logic; -- A greater than B
	signal AEQB						: std_logic; -- A equal than B
	signal ALEB						: std_logic; -- A lesser than B
	
	signal SEG7_B 		: std_logic_vector(6 downto 0); -- output of seven seg decoders
	signal SEG7_A  	: std_logic_vector(6 downto 0); -- output of seven seg decoders
	
	
	
	
-- Here the circuit begins

begin

	curr_temp <= sw(3 downto 0); -- Current temperature
	desi_temp <= sw(7 downto 4); -- Desired temperature
	door_wind_open <= (NOT pb(2 downto 0)); ----- 0 open and 1 is closed ; pressing the button will make it open (Front, back door and windows)
	inverted_pb <= (NOT pb(3)); -- Vacation mode push button (pressing it will go to vacation mode
	leds(0) <= furn_on; -- furnace on signal
	leds(1) <= syst_at_temp; -- Current and desired temperature equality signal
	leds(2) <= ac_on; -- AC on signal 
	leds(3) <= blow_on; -- Blower on signal 
	leds(6 downto 4) <= door_wind_op; -- front back door and window open indicator
	 
	FBC: Four_Bit_Comparator port map(curr_temp,mux_out,AGRB,AEQB,ALEB);--(2ND INPUT IS MUX_OUT) --- Comparing the desired and current temperature
	
	
	MUX: Mux4to1 port map(desi_temp,"0100",inverted_pb,mux_out); --- Selecting between non vacation and vacation desired temp using a 4 to 1 mux
	
	--- Energy monitor and control logic unit
	LOGIC: EMCL port map(AGRB,AEQB ,ALEB ,inverted_pb ,door_wind_open ,furn_on ,syst_at_temp ,ac_on ,blow_on ,door_wind_op(0) ,door_wind_op(1) ,door_wind_op(2),leds(7) ); 

	SS : SevenSegment port map(mux_out,SEG7_B ); --- converting the desired temp to a seven segment code
	
	SS1 : SevenSegment port map (curr_temp,SEG7_A); --- converting the current temp to a seven segment code
	
	S7M : segment7_mux port map (Clkin_50 ,SEG7_A  ,SEG7_B ,seg7_data ,seg7_char2 ,seg7_char1 ); --- displayiing the current and desired temp on the seg seven displays
	 
 
 
 
end Energy_Monitor;




