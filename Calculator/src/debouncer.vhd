library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DEBOUNCER is
    Port ( BTN : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DET : out STD_LOGIC);
end DEBOUNCER;

architecture DBC of DEBOUNCER is

signal DB_COUNTER : STD_LOGIC_VECTOR (19 downto 0);
signal TC : STD_LOGIC;
signal DFF1 : STD_LOGIC;
signal DFF2 : STD_LOGIC;

begin

process(CLK)
begin
    if CLK'EVENT and CLK = '1' then
        DB_COUNTER <= DB_COUNTER + 1;
    end if;
end process;

process(DB_COUNTER)
begin
    if DB_COUNTER = "111111111111111111" then
        TC <= '1';
    else
        TC <= '0';
    end if;
end process;

DFF0: process(CLK)
begin
    if CLK'EVENT and CLK = '1' then
        if TC = '1' then
            DFF1 <= BTN;
        end if;
    end if;
end process;

DFF00: process(CLK)
begin
    if CLK'EVENT and CLK = '1' then
        DFF2 <= DFF1;
    end if;
end process;

DET <= DFF2 and (not DFF1);

end DBC;