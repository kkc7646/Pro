library std;
library ieee;
use ieee.std_logic_1164.all;

entity flag is 
	port(Din  : in std_logic_vector(15 downto 0);
			 clk  : in std_logic;
			 Dout : out std_logic);
end entity;

architecture Behave of flag is
begin
	process(clk,Din)
		begin
		Dout <= Din(0) or Din(1) or Din(2) or Din(3) or Din(4) or Din(5) or Din(6) or Din(7);
	end process;
end Behave;
