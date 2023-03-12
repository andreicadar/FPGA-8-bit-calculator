library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity change_state is
	port(CNT, CLK, RST: in std_logic;
		S2, S1: out std_logic);
end entity;

architecture change_state_a of change_state is
	signal counter: std_logic_vector(1 downto 0) := (others => '0');
begin
	process(CLK)
	begin
		if CLK = '1' and CLK'event then
			if CNT = '1' then
				if counter = "11" then
					counter <= "01";
				else   
					counter <= counter+'1';
				end if;
			else 
				if RST = '1' then
					counter <= "00";
				end if;
			end if;
		end if;
	end process;
	S1 <= counter(0);
	S2 <= counter(1);
end architecture;
