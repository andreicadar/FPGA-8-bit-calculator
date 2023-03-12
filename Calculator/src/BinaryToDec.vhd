library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.STD_logic_unsigned.all; 
use IEEE.numeric_std.all;			 

entity binaryToDec is
	port(inputNumber: in std_logic_vector(7 downto 0);
	H, D, U: out std_logic_vector(3 downto 0));
end entity;

architecture binaryToDec_a of binaryToDec is

begin
	process(inputNumber)
	
	variable initial_number: std_logic_vector(7 downto 0) := inputNumber;
	variable BCD: std_logic_vector(11 downto 0) := (others => '0');
	
	begin	
		initial_number := inputNumber;  
		BCD := (others => '0');
		
		for i in 0 to 7 loop  -- repeating 8 times.
			BCD(11 downto 1) := BCD(10 downto 0);  --shifting the bits.
			BCD(0) := initial_number(7);
			initial_number(7 downto 1) := initial_number(6 downto 0);
			initial_number(0) :='0';

			if(i < 7 and BCD(3 downto 0) > "0100") then --add 3 if BCD digit is greater than 4.
			BCD(3 downto 0) := BCD(3 downto 0) + "0011";
			end if;
			
			if(i < 7 and BCD(7 downto 4) > "0100") then --add 3 if BCD digit is greater than 4.
			BCD(7 downto 4) := BCD(7 downto 4) + "0011";
			end if;
			
			if(i < 7 and BCD(11 downto 8) > "0100") then  --add 3 if BCD digit is greater than 4.
			BCD(11 downto 8) := BCD(11 downto 8) + "0011";
			end if;
		end loop;
		H <= BCD(11 downto 8);
		D <= BCD(7 downto 4);
		U <= BCD(3 downto 0);
	end process;
end architecture;

	
