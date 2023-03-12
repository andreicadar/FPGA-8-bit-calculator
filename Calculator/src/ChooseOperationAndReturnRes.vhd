library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.STD_logic_unsigned.all; 
use IEEE.numeric_std.all;			 

entity ChooseOperationAndReturnRes is
	port(A, B: in std_logic_vector(7 downto 0);
	OPS1, OPS2, STATE2, STATE1: in std_logic;
	CLK, RST: in std_logic;
	result, rezaO, rezsO, rezmO, rezdO, result_localO: out std_logic_vector(7 downto 0));
end entity;

architecture ChooseOperationAndReturnRes_a of ChooseOperationAndReturnRes is

component mux41_8BIT is
	port(S1, S2: in std_logic;
	I1, I2, I3, I4: in std_logic_vector(7 downto 0);
	O1: out std_logic_vector(7 downto 0));
end component;

component bit_adder_8 is
	port( A: in std_logic_vector (7 downto 0);
	B: in std_logic_vector (7 downto 0);
	rez: out std_logic_vector(7 downto 0);
	carry_O: out std_logic);
end component;

component bit_subtractor_8 is
	port( A: in std_logic_vector (7 downto 0);
	B: in std_logic_vector (7 downto 0);
	rez: out std_logic_vector(7 downto 0);
	borrow_O: out std_logic);
end component;

component multiplication is
	port( X: in std_logic_vector (7 downto 0);
		Y: in std_logic_vector (7 downto 0);
		CLK, RST: in std_logic;
		rez: out std_logic_vector(7 downto 0);
		carryM: out std_logic);
end component;

component division is
	port( X: in std_logic_vector (7 downto 0);
		Y: in std_logic_vector (7 downto 0);
		CLK, RST: in std_logic;
		rez: out std_logic_vector(7 downto 0));
end component;

component mux41_1BIT is
	port(S1, S2: in std_logic;
	I1, I2, I3, I4: in std_logic;
	O1: out std_logic);
end component;

component D_FLIP_FLOP_8bit is
	port(D: in std_logic_vector(7 downto 0);
	CLK, RST: in std_logic;
	O: out std_logic_vector(7 downto 0));
end component;

signal reza, rezs, rezm, rezd, result_local: std_logic_vector(7 downto 0);	
signal carry, borrow, carryM, overflow, reset_local, total_reset: std_logic;

begin
	total_reset <= reset_local or RST;
	mux41_1BIT_C: mux41_1BIT port map(STATE2, STATE1, '0', '0', '1', '0', reset_local);
	mux41_8BIT_C: mux41_8BIT port map(OPS1, OPS2, reza, rezs, rezm, rezd, result);
	rezaO <= reza;
	rezsO <= rezs;
	rezmO <= rezm;
	rezdO <= rezd;
	result_localO <= result_local;
	--D_FLIP_FLOP_8bit_C: D_FLIP_FLOP_8bit port map(result_local, CLK, total_reset, result);
	bit_adder_8_C: bit_adder_8 port map(A, B, reza, carry);
	bit_subtractor_8_C: bit_subtractor_8 port map(A, B, rezs, borrow);
	multiplication_C: multiplication port map(A, B, CLK, total_reset, rezm, carryM);
	division_C : division port map(A, B, CLK, total_reset, rezd);

end architecture;

	
