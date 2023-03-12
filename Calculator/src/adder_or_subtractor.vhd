library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder_or_subtractor is
	port( A: in std_logic_vector (7 downto 0);
	B: in std_logic_vector (7 downto 0);
	OPS, SIGN1, SIGN2: in std_logic;
	rez: out std_logic_vector(7 downto 0);
	SIGN_O: out std_logic);
end entity;

architecture adder_or_subtractor_a of adder_or_subtractor is

signal carry, borrow, rez_a, rez_s: std_logic_vector(7 downto 0);	 

signal dummy: std_logic;
signal dummy2: std_logic;
component bit_adder_1 is
	port( 	A: in std_logic;
	B: in std_logic; 
	C : in std_logic;
	rez, carry: out std_logic);
end component;	

component bit_subtractor_1 is
	port( A: in std_logic;
	B: in std_logic;
	C: in std_logic;
	dif,borrow: out std_logic);
end component;


begin  
		a0: bit_adder_1 port map(A(0),B(0), '0', rez_a(0),carry(0));
		a1: bit_adder_1 port map(A(1),B(1),carry(0), rez_a(1),carry(1));
		a2: bit_adder_1 port map(A(2),B(2),carry(1), rez_a(2),carry(2));
		a3: bit_adder_1 port map(A(3),B(3),carry(2), rez_a(3),carry(3));
		a4: bit_adder_1 port map(A(4),B(4),carry(3), rez_a(4),carry(4));
		a5: bit_adder_1 port map(A(5),B(5),carry(4), rez_a(5),carry(5));
		a6: bit_adder_1 port map(A(6),B(6),carry(5), rez_a(6),carry(6));
		a7: bit_adder_1 port map(A(7),B(7),carry(6), rez_a(7),dummy);
		
		s0: bit_subtractor_1 port map(A(0),B(0), '0', rez_s(0),borrow(0));
		s1: bit_subtractor_1 port map(A(1),B(1),borrow(0), rez_s(1),borrow(1));
		s2: bit_subtractor_1 port map(A(2),B(2),borrow(1), rez_s(2),borrow(2));
		s3: bit_subtractor_1 port map(A(3),B(3),borrow(2), rez_s(3),borrow(3));
		s4: bit_subtractor_1 port map(A(4),B(4),borrow(3), rez_s(4),borrow(4));
		s5: bit_subtractor_1 port map(A(5),B(5),borrow(4), rez_s(5),borrow(5));
		s6: bit_subtractor_1 port map(A(6),B(6),borrow(5), rez_s(6),borrow(6));
		s7: bit_subtractor_1 port map(A(7),B(7),borrow(6), rez_s(7),dummy2);  
		
	process(FLAG_TO_DO)
	begin
		if FLAG_TO_DO = '1' and FLAG_TO_DO'event then
			if OPS = '0' then
				rez <= rez_a;
			else
				rez <= rez_s;
			end if;
		end if;
		end process;
		
end architecture;