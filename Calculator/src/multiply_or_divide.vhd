library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity multiply_or_divide is
	port( 	A: in std_logic_vector (7 downto 0);
	B: in std_logic_vector (7 downto 0);
	OPS, RST, SIGN1, SIGN2, CLK: in std_logic;
	rez: out std_logic_vector(7 downto 0);
	SIGN_O, DONE_O: out std_logic);
end entity;

architecture multiply_or_divide_a of multiply_or_divide is

signal rez_m, rez_d: std_logic_vector(7 downto 0);

begin  
	process(FLAG_TO_DO)
	variable done : std_logic := '0';
	begin
		if CLK = '1' and CLK'event then
				
			end if;
		end if;
	end process;
		
end architecture;