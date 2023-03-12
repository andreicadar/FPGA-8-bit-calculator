library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.STD_logic_unsigned.all; 
use IEEE.numeric_std.all;			 

entity DecToBinary is
	port(H, D, U: in std_logic_vector(3 downto 0);
	OUTPUT_NUMBER: out std_logic_vector(7 downto 0));
end entity;

architecture DecToBinary_a of DecToBinary is

begin
	process(H, D, U)
	
	variable initial_number: std_logic_vector(11 downto 0);
	variable binary: std_logic_vector(7 downto 0) := (others => '0');
	
	begin	
		initial_number(11 downto 8) := H;
		initial_number(7 downto 4) := D;
		initial_number(3 downto 0) := U; 
		binary := (others => '0');
		
		for i in 0 to 7 loop  -- repeating 8 times.	  
			binary(6 downto 0) := binary(7 downto 1);
			binary(7) :=initial_number(0);
			initial_number(10 downto 0) := initial_number(11 downto 1);  --shifting the bits.
			initial_number(11) := '0';

			if(i < 7 and initial_number(3 downto 0) > "0111") then --subtract 3 if BCD digit is greater than 8.
			initial_number(3 downto 0) := initial_number(3 downto 0) - "0011";
			end if;
			
			if(i < 7 and initial_number(7 downto 4) > "0111") then --subtract 3 if BCD digit is greater than 8.
			initial_number(7 downto 4) := initial_number(7 downto 4) - "0011";
			end if;
			
			if(i < 7 and initial_number(11 downto 8) > "0111") then --subtract 3 if BCD digit is greater than 8.
			initial_number(11 downto 8) := initial_number(11 downto 8) - "0011";
			end if;
		end loop;
		if initial_number > 0 then
			binary := "11111111";
		end if;	
		OUTPUT_NUMBER <= binary;
	end process;
end architecture;

	
