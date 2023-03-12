library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.STD_logic_unsigned.all; 
use IEEE.numeric_std.all;			 

entity mux41_1BIT is
	port(S1, S2: in std_logic;
	I1, I2, I3, I4: in std_logic;
	O1: out std_logic);
end entity;

architecture mux41_1BIT_a of mux41_1BIT is

begin
	process(S1, S2, I1, I2, I3, I4)
	begin
		if S1 = '0' and S2 = '0' then
			O1 <= I1;
		else
			if S1 = '0' then
				O1 <= I2;
			else
				if S2 = '0' then
					O1 <= I3;
				else
					O1 <= I4;
				end if;
			end if;
		end if;
				
	end process;
end architecture;

	
