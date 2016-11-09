---------------------mux21------------------------------------------
library std;
library ieee;
use ieee.std_logic_1164.all;

entity mux21 is
generic(data_width:integer);
   port(a,b: in std_logic_vector(data_width-1 downto 0);s: in std_logic;
        c: out std_logic_vector(data_width-1 downto 0));
end entity;

architecture Struct1 of mux21 is
   
  begin
  process(a,b,s)
   variable x: std_logic_vector(data_width-1 downto 0);
begin

	if s='0'    then
		 x:= a;
	elsif s='1' then
		 x:= b;
	end if;
		 c <= x;
end process;
end Struct1;

