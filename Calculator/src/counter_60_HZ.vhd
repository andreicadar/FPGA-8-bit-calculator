library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.STD_logic_unsigned.all; 
use IEEE.numeric_std.all;	

entity counter_60_HZ is
	port(CLK_100: in std_logic;
	O1, O2, O3: out std_logic);
end entity;

architecture counter_60_HZ_a of counter_60_HZ is

begin
	process(CLK_100)
	variable C: std_logic_vector(15 downto 0) := (others=>'0');
	begin
		if CLK_100'event and CLK_100='1' then
			C := C + "1";
		end if;
		O1 <= C(15);
		O2 <= C(14);
		O3 <= C(13);
	end process;
end architecture;