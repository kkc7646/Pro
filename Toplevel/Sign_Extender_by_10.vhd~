library ieee;
use ieee.std_logic_1164.all;

entity Sign_Extender_by_10 is
	port(Iin   : in std_logic_vector(5 downto 0);
			 Iout  : out std_logic_vector(15 downto 0);
			 clock : in  std_logic);
end Sign_Extender_by_10;

architecture Structure of Sign_Extender_by_10 is
begin
		loop1:
		for I in 15 downto 5 generate
			Iout(I) <= Iin(5);
		end generate loop1;
			Iout(4 downto 0) <= Iin(4 downto 0);
end Structure;
