----------------mux81------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mux81 is
	generic(data_width:integer);
   port(a0,a1,a2,a3,a4,a5,a6,a7 : in std_logic_vector(data_width-1 downto 0);
				s0,s1,s2                : in std_logic;
        c                       : out std_logic_vector(data_width-1 downto 0));
end entity;

architecture Struct3 of mux81 is
begin
  process(a0,a1,a2,a3,a4,a5,a6,a7,s0,s1,s2)
  variable x: std_logic_vector(data_width-1 downto 0);
	begin
	if s0='0' and s1='0' and s2 ='0'   then
		 x:= a0;
	elsif s0='1' and s1='0' and s2 ='0'    then
		 x:= a1;
	elsif s0='0' and s1='1' and s2='0'    then
		 x:= a2;
	elsif s0='1' and s1='1' and s2='0'    then
		 x:= a3;
	elsif s0='0' and s1='0' and s2='1'    then
		 x:= a4;
	elsif s0='1' and s1='0' and s2='1'    then
		 x:= a5;
	elsif s0='0' and s1='1' and s2='1'    then
		 x:= a6;
	elsif s0='1' and s1='1' and s2='1'   then
		 x:= a7;
	end if;
		 c <= x;
	end process;
end Struct3;
