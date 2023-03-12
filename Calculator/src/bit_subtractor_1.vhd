library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bit_subtractor_1 is
	port( A: in std_logic;
	B: in std_logic;
	C: in std_logic;
	dif, borrow: out std_logic);
end entity;

architecture bit_subtractor_1_a of bit_subtractor_1 is 
begin
	dif <= 	(A xor B) xor C;
	borrow	<= ((not A) and (B or C)) or (B and C);
end architecture;
	