library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.STD_logic_unsigned.all; 
use IEEE.numeric_std.all;


--HS - hundreds switch
--DS - decimal switch
--US - units switch
--SIGN_S - sign switch
--OPS1, operations switch
--OPS2, operations swtich
--NEXT_B, next button to change state
--00 -> ADUNARE
--01 -> SCADERE
--10 -> INMULTIRE
--11 -> IMPARTIRE
--DArray display selection array
--DNumber what to siaply on currently selected display



entity calculator is
	port(CLK_100, HS, DS, US, SIGN_S, OPS1, OPS2, NEXT_B, RST: in std_logic;
	DArray: out std_logic_vector(7 downto 0);
	DNumber: out std_logic_vector(0 to 6);
	rez_o: out std_logic_vector(7 downto 0));
end entity;

architecture calculator_a of calculator is

component input_number is
	port(CLK_1_sec_signal, HS, DS, US, SIGN_S, NEXT_B: in std_logic;
	HD, DD, UD: out std_logic_vector(3 downto 0));
end component; 

component counter_1_sec is
	port(CLK_100: in std_logic;
	FLAG: out std_logic);
end component;

component counter_60_HZ is
	port(CLK_100: in std_logic;
	O1, O2, O3: out std_logic);
end component;

component mux81_8BIT is
	port(S1, S2, S3: in std_logic;
	I1, I2, I3, I4, I5, I6, I7, I8: in std_logic_vector(7 downto 0);
	O1: out std_logic_vector(7 downto 0));
end component;

component mux41_8BIT is
	port(S1, S2: in std_logic;
	I1, I2, I3, I4: in std_logic_vector(7 downto 0);
	O1: out std_logic_vector(7 downto 0));
end component;

component mux81_4BIT is
	port(S1, S2, S3: in std_logic;
	I1, I2, I3, I4, I5, I6, I7, I8: in std_logic_vector(3 downto 0);
	O1: out std_logic_vector(3 downto 0));
end component;

component display_decoder is
	port(nr: in std_logic_vector(3 downto 0);
	seven_segment: out std_logic_vector(0 to 6));
end component;

component determine_sign_value_in_hex is
	port(SWITCH_POS: in std_logic;
	OUTPUT: out std_logic_vector(3 downto 0));
end component;

component DecToBinary is
	port(H, D, U: in std_logic_vector(3 downto 0);
	OUTPUT_NUMBER: out std_logic_vector(7 downto 0));
end component;

component DEBOUNCER is
    Port ( BTN : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DET : out STD_LOGIC);
end component;

component change_state is
	port(CNT, CLK, RST: in std_logic;
		S2, S1: out std_logic);
end component;

component binaryToDec is
	port(inputNumber: in std_logic_vector(7 downto 0);
	H, D, U: out std_logic_vector(3 downto 0));
end component;

component D_FLIP_FLOP_8bit is
	port(D: in std_logic_vector(7 downto 0);
	CLK, RST: in std_logic;
	O: out std_logic_vector(7 downto 0));
end component;

component ChooseOperationAndReturnRes is
	port(A, B: in std_logic_vector(7 downto 0);
	OPS1, OPS2, STATE2, STATE1: in std_logic;
	CLK, RST: in std_logic;
	result, rezaO, rezsO, rezmO, rezdO, result_localO: out std_logic_vector(7 downto 0));
end component;

type DisplaySelectorType is array (0 to 7) of std_logic_vector(7 downto 0);
signal DSelector:DisplaySelectorType := ("11111110", "11111101", "11111011", "11110111", "11101111", "11011111", "10111111", "01111111");
signal OutDigit, HD, DD, UD: std_logic_vector(3 downto 0);
signal Out_of_60HZ_1, Out_of_60HZ_2, Out_of_60HZ_3, FLAG_1_SEC, STATE1, STATE2, Last_NEXT_B_STATE: std_logic;
signal A, A_AUX, A_AUX_2, A_DELAYED, B, B_AUX, B_AUX_2, REZ, THE_INPUT: std_logic_vector(7 downto 0);
signal A_DOUBLE_DABBLE, B_DOUBLE_DABBLE: std_logic_vector(11 downto 0);
signal signValue: std_logic_vector(3 downto 0) :="1010";
signal change_state_signal, not_clock: std_logic;

signal reza, rezs, rezm, rezd, result_local: std_logic_vector(7 downto 0);

begin
	not_clock <= not CLK_100;
	--freq divider
	Counter_60_HZ_C: counter_60_HZ port map(CLK_100, Out_of_60HZ_1, Out_of_60HZ_2, Out_of_60HZ_3);
	Counter_1_sec_C: counter_1_sec port map(CLK_100, FLAG_1_SEC);
	
	
	--display
	MUX81_8BIT_C: mux81_8BIT port map(Out_of_60HZ_1, Out_of_60HZ_2, Out_of_60HZ_3, DSelector(0), DSelector(1), DSelector(2), DSelector(3), DSelector(4), DSelector(5), DSelector(6), DSelector(7), DArray);
	Mux81_4BIT_C: Mux81_4BIT port map(Out_of_60HZ_1, Out_of_60HZ_2, Out_of_60HZ_3, A_DOUBLE_DABBLE(11 downto 8), A_DOUBLE_DABBLE(7 downto 4), A_DOUBLE_DABBLE(3 downto 0), signValue, "0000", "0000", "0000", "0000", OutDigit);
	Display_decoder_C: display_decoder port map(OutDigit, DNumber);
	Determine_sign_value_in_hex_C: determine_sign_value_in_hex port map(SIGN_S, signValue);
	
	--Input number
	--Input_number_C: input_number port map(FLAG_1_SEC, HS, DS, US, SIGN_S, HD, DD, UD);
	Input_number_C: input_number port map(CLK_100, HS, DS, US, SIGN_S, NEXT_B, HD, DD, UD);
	
	--decode a from 8bits to 3 sets fo 4 bits
	binaryToDec_C: binaryToDec port map(A, A_DOUBLE_DABBLE(11 downto 8), A_DOUBLE_DABBLE(7 downto 4), A_DOUBLE_DABBLE(3 downto 0));
	
	--Here we do A
	D_FLIP_FLOP_8bit_C1: D_FLIP_FLOP_8bit port map(A_AUX, not_clock, RST, A_AUX_2);
	D_FLIP_FLOP_8bit_C2: D_FLIP_FLOP_8bit port map(A, NEXT_B, RST, A_DELAYED);
	mux41_8BIT_C: mux41_8BIT port map(STATE2, STATE1, THE_INPUT, THE_INPUT, A_AUX_2, REZ,  A_AUX);
	A <= A_AUX;
	
	--Here we do B
	D_FLIP_FLOP_8bit_C3: D_FLIP_FLOP_8bit port map(B_AUX, not_clock, RST, B_AUX_2);
	mux41_8BIT_C2: mux41_8BIT port map(STATE2, STATE1, "00000000", A_DELAYED, B_AUX_2, B_AUX_2, B_AUX);
	B <= B_AUX;
	
	--decode the input to 8 bits
	DecToBinary_C : DecToBinary port map(HD, DD, UD, THE_INPUT);
	
	--States
	--pentru simulator
	--DEBOUNCER_C: DEBOUNCER port map(NEXT_B, CLK_100, change_state_signal);
	change_state_C: change_state port map(NEXT_B, CLK_100, RST, STATE2, STATE1);
	--change_state_C: change_state port map(NEXT_B, CLK_100, RST, STATE2, STATE1);
	
	--Calculator
	ChooseOperationAndReturnRes_C: ChooseOperationAndReturnRes port map(B, A_DELAYED, OPS1, OPS2, STATE2, STATE1, change_state_signal, RST, REZ, reza, rezs, rezm, rezd, result_local);
	rez_o <= rez;	
	
end architecture;

library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.STD_logic_unsigned.all; 
use IEEE.numeric_std.all;

entity tb is
end entity;

architecture tb_a of tb is 

component calculator is
	port(CLK_100, HS, DS, US, SIGN_S, OPS1, OPS2, NEXT_B, RST: in std_logic;
	DArray: out std_logic_vector(7 downto 0);
	DNumber: out std_logic_vector(0 to 6);
	rez_o: out std_logic_vector(7 downto 0));
end component;

signal CLK, HD, DD, UD,  SIGN_S, RST, OPS1, OPS2, NEXT_B, res: std_logic;
signal DArray, rez:std_logic_vector(7 downto 0);
signal DNumber: std_logic_vector(0 to 6);	

begin
	C1:   calculator port map(CLK, HD, DD, UD, SIGN_S, OPS1, OPS2, NEXT_B, Res, DARray, Dnumber,rez);
process
begin
	wait for 50ns;
	CLK <= '0';
	wait for 50ns;
	CLK <= '1';
end process;
process
begin
	HD <= '0';
	DD<= '0';
	UD<= '0';
	SIGN_S<= '0';
	RST<= '0';
	OPS1<= '0';
	OPS2<= '0';
	NEXT_B<= '0';
	res	<= '0';
   wait for 300ns;
   RST<= '1';
   wait for 100ns;
   RST<= '0';
   -- gata cu resetu
   
   wait for 200ns;
   DD<= '1';
   wait for 200ns;
   DD<= '0';
   wait for 200ns;
   UD<='1';
   wait for 200ns;
   UD<='0';
   wait for 200ns;
   NEXT_B<= '1';
   wait for 100ns;
   NEXT_B<= '0';
   wait for 200ns;
   
   -- gata primu numar
   
   UD<= '1';
   wait for 300ns;
   UD<= '0';
   wait for 200ns;
   NEXT_B<= '1';
   wait for 100ns;
   NEXT_B<= '0';
   wait for 200ns;
   --gata al2lea numar 
   
   --setam operatia
   OPS1<= '1';
   OPS2<= '1';
   wait for 200ns;
   
   --next sa aflam rezultatul
   NEXT_B<= '1';
    wait for 100ns;
   NEXT_B<= '0';
   wait for 600ns;
end process;
end architecture;