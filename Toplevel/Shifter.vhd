library ieee;
use ieee.std_logic_1164.all;

entity Shifter is
	port(Iin  : in std_logic_vector(8 downto 0);
			 Iout : out std_logic_vector(15 downto 0);
			 clock: in  std_logic);
end Shifter;

architecture Structure of Shifter is
begin
			Iout(15 downto 7) <= Iin(8 downto 0);
			Iout(6 downto 0) <= "0000000";
end Structure;
