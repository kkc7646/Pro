-------------------mux41-----------------------------------------------
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity mux41 is
	generic(data_width:integer);
   port(a0,a1,a2,a3: in std_logic_vector(data_width-1 downto 0);s0,s1: in std_logic;
        c: out std_logic_vector(data_width-1 downto 0));
end entity;

architecture Struct2 of mux41 is
   
  begin
  process(a0,a1,a2,a3,s0,s1)
   variable x: std_logic_vector(data_width-1 downto 0);
begin

if s0='0' and s1='0'    then
   x:= a0;
elsif s0='1' and s1='0'    then
   x:= a1;
elsif s0='0' and s1='1'    then
   x:= a2;
elsif s0='1' and s1='1'    then
   x:= a3;
end if;
   c <= x;
end process;
end Struct2;

