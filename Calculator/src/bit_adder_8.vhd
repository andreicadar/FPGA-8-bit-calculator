library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bit_adder_8 is
	port( A: in std_logic_vector (7 downto 0);
	B: in std_logic_vector (7 downto 0);
	rez: out std_logic_vector(7 downto 0);
	carry_O: out std_logic);
end entity;

architecture bit_adder_8_a of bit_adder_8 is

signal carry: std_logic_vector(7 downto 0);	 

component bit_adder_1 is
	port( A: in std_logic;
	B: in std_logic; 
	C : in std_logic;
	rez, carry: out std_logic);
end component;	

begin  
		a0: bit_adder_1 port map(A(0), B(0), '0',      rez(0), carry(0));
		a1: bit_adder_1 port map(A(1), B(1), carry(0), rez(1), carry(1));
		a2: bit_adder_1 port map(A(2), B(2), carry(1), rez(2), carry(2));
		a3: bit_adder_1 port map(A(3), B(3), carry(2), rez(3), carry(3));
		a4: bit_adder_1 port map(A(4), B(4), carry(3), rez(4), carry(4));
		a5: bit_adder_1 port map(A(5), B(5), carry(4), rez(5), carry(5));
		a6: bit_adder_1 port map(A(6), B(6), carry(5), rez(6), carry(6));
		a7: bit_adder_1 port map(A(7), B(7), carry(6), rez(7), carry_O);

end architecture;