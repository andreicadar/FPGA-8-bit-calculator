library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.STD_logic_unsigned.all; 
use IEEE.numeric_std.all;			 

entity D_FLIP_FLOP_8bit is
	port(D: in std_logic_vector(7 downto 0);
	CLK, RST: in std_logic;
	O: out std_logic_vector(7 downto 0));
end entity;

architecture D_FLIP_FLOP_8bit_a of D_FLIP_FLOP_8bit is

begin
	process(CLK, RST)
	begin
		if CLK = '1' and CLK'event then
			if RST = '1' then
				O <= "00000000";
			else
				O <= D;
			end if;
		end if;
				
	end process;
end architecture;

	
