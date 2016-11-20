library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity memory is
	port(A			                  : in  std_logic_vector(15 downto 0);
			 Din                      : in std_logic_vector(15 downto 0);		
			 clock,mem_Write,mem_read : in  std_logic;
			 Dout				              : out std_logic_vector(15 downto 0));
end memory;

architecture Structure of memory is
type memory_16 is array (512 downto 0) of std_logic_vector (15 downto 0);------------1kB of memory
signal T:memory_16 :=(--#From 0 to 13
								0=> "1000001000000001",
								1=> "0100100110000101",
								2=> "0001111100101100",
								3=> "0100110110000101",
								4=> "0110001000000011",
								5=> "0001010000000000",
								6=> "0010001011000000",
								7=> "0010011011000110",
								8=> "0001011000000110",
								9=> "0000110100001000",
								10=> "0000000000000000",
								11=> "0010110110010101",
								12=> "1100110101111010",
								13=> "0101100101010110",

								--#From 29 to 38
								29=> "0001011000001110",
								30=> "0001110010111101",
								31=> "0101000110000100",
								32=> "0100000110000000",
								33=> "0100001110000001",
								34=> "1100101001001011",
								35=> "0000010010000000",
								36=> "0000000100010111",
								37=> "0001001111111010",
								38=> "0001111111011111",

								--#From 46 to 50
								46=> "0001100000010100",
								47=> "0111100000010100",
								48=> "0001011111111110",
								49=> "0101011110000101",
								50=> "0100111110000100",
								others => "0000000000000000");
begin
	process(clock,mem_Write,mem_read,Din,A,T)
	begin
		if((mem_Write) = '1') then
			T(to_integer(unsigned(A)))<= Din;
		elsif(mem_read = '1') then
			Dout <= T(to_integer(unsigned(A)));
		end if;
	end process;
end Structure;
