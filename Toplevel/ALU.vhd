library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Components.all;

entity ALU is
   port(x,y              : in std_logic_vector(15 downto 0);
		    op1,op0, flagset : in std_logic;
		    c,z              : out std_logic;
        s                : out std_logic_vector(15 downto 0));
end entity;

architecture Struct of ALU is
signal s0,s1,s2, s3: std_logic_vector(15 downto 0);
constant w :std_logic_vector(15 downto 0):=(others=>'0');
begin
	process(x,y,op1,op0,s0,s1,s2,s3,flagset)
	begin
-----------------------16bit adder--------------------------------------
	if  op1='0' and op0='0'   then
		s <= s0;
----------------------16bit subtracter----------------------------------
	elsif op1='0' and op0='1' then
		s<= s1;
		if(s1 = w) then
		  z<= '1';
		 else 
		  z<= '0';
		  end if;
----------------------16bit nand-----------------------------
	elsif op1='1' and op0='0' then
		s <= s2;
-----------------------16bit and ----------------------------
	elsif op1='1' and op0='1' then
		s <= s3;
	end if;

	if flagset = '1' then
		c <= '1';
		z <= '1';
	end if;
	end process;
	DUT1: sixteen_bit_adder port map(A=>x,B=>y,RESULT=>s0);
	DUT3: sixteen_bit_subtracter port map(A=>x,B=>y,RESULT=>s1);
	DUT4: sixteen_bit_nand port map(A=>x,B=>y,RESULT=>s2);
	DUT5: sixteen_bit_nand port map(A=>s2,B=>s2,RESULT=>s3);
end Struct;
