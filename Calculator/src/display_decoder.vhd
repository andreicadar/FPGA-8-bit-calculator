library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.STD_logic_unsigned.all; 
use IEEE.numeric_std.all;			 

entity display_decoder is
	port(nr: in std_logic_vector(3 downto 0);
	seven_segment: out std_logic_vector(0 to 6));
end entity;

architecture display_decoder_a of display_decoder is

begin
	process(nr)
	begin
		case nr is
			when x"0" => seven_segment <= "0000001";
			when x"1" => seven_segment <= "1001111";
			when x"2" => seven_segment <= "0010010";
			when x"3" => seven_segment <= "0000110";
			when x"4" => seven_segment <= "1001100";
			when x"5" => seven_segment <= "0100100";
			when x"6" => seven_segment <= "0100000";
			when x"7" => seven_segment <= "0001111";
			when x"8" => seven_segment <= "0000000";
			when x"9" => seven_segment <= "0000100";
			when x"A" => seven_segment <= "1111111";
			when x"B" => seven_segment <= "1111110";
			when others => seven_segment <= "0110000";
			end case;
	end process;
end architecture;

	
