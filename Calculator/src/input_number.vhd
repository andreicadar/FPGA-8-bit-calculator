library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.STD_logic_unsigned.all; 
use IEEE.numeric_std.all;

entity input_number is
	port(CLK_1_sec_signal, HS, DS, US, SIGN_S, NEXT_B: in std_logic;
	HD, DD, UD: out std_logic_vector(3 downto 0));
end entity;

architecture input_number_a of input_number is

begin
	process(CLK_1_sec_signal)
	variable HD_LOCAL, DD_LOCAL, UD_LOCAL: std_logic_vector(3 downto 0):=(others=>'0');
	begin
		if CLK_1_sec_signal'event and CLK_1_sec_signal = '1' then
			if HS = '1' then
				HD_LOCAL := HD_LOCAL + 1;
				if HD_LOCAL = "1010" then
					HD_LOCAL := "0000";
				end if;
			end if;
			if DS = '1' then
				DD_LOCAL := DD_LOCAL + 1;
				if DD_LOCAL = "1010" then
					DD_LOCAL := "0000";
				end if;
			end if;
			if US = '1' then
				UD_LOCAL := UD_LOCAL + 1;
				if UD_LOCAL = "1010" then
					UD_LOCAL := "0000";
				end if;
			end if;
		else 
			if NEXT_B = '1' then
			 	HD_LOCAL := "0000";
				DD_LOCAL := "0000";
				UD_LOCAL := "0000";
			end if;
		end if;
		HD <= HD_LOCAL;
		DD <= DD_LOCAL;
		UD <= UD_LOCAL;
	end process;
end architecture;