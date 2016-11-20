library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity RegFile is
	port(A1,A2,A3			        : in  std_logic_vector(2 downto 0);
			 D1,D2,R7_out	        : out std_logic_vector(15 downto 0);
			 D3, R7_in			      : in  std_logic_vector(15 downto 0);			
			 clock,RF_Write,R7_En : in  std_logic);
end RegFile;

architecture Structure of RegFile is
type Register_16 is array (7 downto 0) of std_logic_vector (15 downto 0);
signal T:Register_16 := (others =>(others=>'0'));
begin
	process(clock,A1,A2,A3,D3,T, R7_in,RF_Write,R7_En)  
	begin
		if(RF_Write = '0') then
			D1 <= T(to_integer(unsigned(A1)));
			D2 <= T(to_integer(unsigned(A2)));
		end if;
		if rising_edge(clock) then
		if (RF_Write = '1') then
			T(to_integer(unsigned(A3)))<=D3;
		elsif(R7_En = '1') then
			--if rising_edge(clock) then 
				T(7) <= R7_in;
			end if;
		end if;
		R7_out <= T(7);
	end process;
end Structure;
