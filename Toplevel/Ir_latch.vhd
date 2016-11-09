library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;

entity IR_Latch is
	generic (data_width:integer);
	port (Din        : in std_logic_vector(data_width-1 downto 0);
	      Dout       : out std_logic_vector(data_width-1 downto 0);
	      clk, enable: in std_logic);
end entity;

architecture Behave of IR_Latch is
begin
    process(clk,Din,enable)
     
    begin
    
           if(enable = '1') then
               Dout <= Din;
           end if;
    
    end process;
end Behave;
