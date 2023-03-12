library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bit_subtractor_8 is
	port( A: in std_logic_vector (7 downto 0);
	B: in std_logic_vector (7 downto 0);
	rez: out std_logic_vector(7 downto 0);
	borrow_O: out std_logic);
end entity;

architecture bit_subtractor_8_a of bit_subtractor_8 is

signal borrow: std_logic_vector(7 downto 0);	 

component bit_subtractor_1 is
	port( A: in std_logic;
	B: in std_logic;
	C: in std_logic;
	dif, borrow: out std_logic);
end component;

begin  
		a0: bit_subtractor_1 port map(A(0), B(0), '0',      rez(0), borrow(0));
		a1: bit_subtractor_1 port map(A(1), B(1), borrow(0), rez(1), borrow(1));
		a2: bit_subtractor_1 port map(A(2), B(2), borrow(1), rez(2), borrow(2));
		a3: bit_subtractor_1 port map(A(3), B(3), borrow(2), rez(3), borrow(3));
		a4: bit_subtractor_1 port map(A(4), B(4), borrow(3), rez(4), borrow(4));
		a5: bit_subtractor_1 port map(A(5), B(5), borrow(4), rez(5), borrow(5));
		a6: bit_subtractor_1 port map(A(6), B(6), borrow(5), rez(6), borrow(6));
		a7: bit_subtractor_1 port map(A(7), B(7), borrow(6), rez(7), borrow_O);

end architecture;