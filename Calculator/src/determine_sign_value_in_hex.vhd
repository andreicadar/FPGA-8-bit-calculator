library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.STD_logic_unsigned.all; 
use IEEE.numeric_std.all;	

entity determine_sign_value_in_hex is
	port(SWITCH_POS: in std_logic;
	OUTPUT: out std_logic_vector(3 downto 0));
end entity;

architecture determine_sign_value_in_hex_a of determine_sign_value_in_hex is											  

begin
	process(SWITCH_POS)
	begin
		if SWITCH_POS = '0' then
			OUTPUT <= "1010";
		else
			OUTPUT <= "1011";
		end if;
	end process;
end architecture;