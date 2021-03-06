library ieee;
use ieee.std_logic_1164.all;

entity sixteen_bit_nand is
port(A,B    : in std_logic_vector(15 downto 0);
	   RESULT : out std_logic_vector(15 downto 0));
end sixteen_bit_nand;

architecture Formula of sixteen_bit_nand is
begin
	loop1:
	for I in 15 downto 0 generate
		RESULT(I) <= B(I) nand A(I);
	end generate loop1;
end Formula;
