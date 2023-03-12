							  library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.STD_logic_unsigned.all; 
use IEEE.numeric_std.all;			 

entity mux81_8BIT is
	port(S1, S2, S3: in std_logic;
	I1, I2, I3, I4, I5, I6, I7, I8: in std_logic_vector(7 downto 0);
	O1: out std_logic_vector(7 downto 0));
end entity;

architecture mux81_8BIT_a of mux81_8BIT is

begin
	process(S1, S2, S3, I1, I2, I3, I4, I5, I6, I7, I8)
	begin
		if S1 = '0' and S2 = '0' and S3 = '0' then
			O1 <= I1;
		else
			if S1 = '0' and S2 = '0' then
				O1 <= I2;
			else
				if S1 = '0' and S3 = '0' then
					O1 <= I3;
				else
					if S1 = '0' then
						O1 <= I4;
					else
						if S2 = '0' and S3 = '0' then
							O1 <= I5;
						else
							if S2 = '0' then
								O1 <= I6;
							else
								if S3 = '0' then
									O1 <= I7;
								else
									O1 <= I8;
								end if;
							end if;
						end if;
						end if;
					end if;
					end if;
				end if;
				
	end process;
end architecture;

	
