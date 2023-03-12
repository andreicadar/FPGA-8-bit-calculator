library IEEE;
use IEEE.STD_LOGIC_1164.all; 

entity bit_adder_1 is
	port(A: in std_logic;
	B: in std_logic; 
	C : in std_logic;
	rez, carry: out std_logic);
end entity;	

architecture bit_adder_1_a of bit_adder_1 is
begin
	rez <= A xor B xor C;
	carry <= ((A and B) or ( B and C) or (A and C));
end architecture;