library ieee;
use ieee.std_logic_1164.all;
--use IEEE.NUMERIC_STD.ALL;

entity Sign_Extender_by_7 is
	--generic(data_width:integer);
	port(
			Iin : in std_logic_vector(8 downto 0);
			Iout : out std_logic_vector(15 downto 0);
			clock: in  std_logic
			);
end Sign_Extender_by_7;

architecture Structure of Sign_Extender_by_7 is
begin
		
		loop1:
		for I in 15 downto 8 generate
			Iout(I) <= Iin(8);
		end generate loop1;
			Iout(7 downto 0) <= Iin(7 downto 0);

end Structure;

