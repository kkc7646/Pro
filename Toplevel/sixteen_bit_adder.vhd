library ieee;
use ieee.std_logic_1164.all;


entity sixteen_bit_adder is
port(  
	A,B: in std_logic_vector(15 downto 0);
	RESULT: out std_logic_vector(15 downto 0)
       
 );
end sixteen_bit_adder;

architecture Formula of sixteen_bit_adder is

	signal p,c,g:std_logic_vector(15 downto 0);
	
begin
	loop1:
	for I in 15 downto 0 generate
		p(I) <= B(I) xor A(I);
		g(I) <= B(I) and A(I);
	end generate loop1;

	c(0) <= '0';
	loop2:
	for I in 15 downto 1 generate
		c(I) <= (p(I-1) and (c(I-1)) ) or g(I-1);
	end generate loop2;

	loop3:
	for I in 15 downto 0 generate
		RESULT(I) <= p(I) XOR c(I);
	end generate loop3;

end Formula;

