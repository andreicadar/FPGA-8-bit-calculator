library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.STD_logic_unsigned.all; 
use IEEE.numeric_std.all;	

entity reset_module is
	port(CLK, STATE1, STATE2, RST: in std_logic);
end entity;

architecture reset_module_a of reset_module is

begin
	process(CLK)
	begin
		if CLK'event and CLK='1' then
			if RST = '1' then
				STATE1 <= '0';
				STATE2 <= '0';
			end if;
		end if;
	end process;
end architecture;