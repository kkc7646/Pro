library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

package Components is
--------------------------mux21-------------------------------------------
   component mux21 is
		 generic(data_width:integer);
		 port(a,b	: in std_logic_vector(data_width-1 downto 0);
		 			s		: in std_logic;
		      c		: out std_logic_vector(data_width-1 downto 0));
   end component;
------------------------mux41----------------------------------------------
   component mux41 is
		 generic(data_width:integer);
		 port(a0,a1,a2,a3	: in std_logic_vector(data_width-1 downto 0);
		 			s0,s1				: in std_logic;
		      c						: out std_logic_vector(data_width-1 downto 0));
   end component;
------------------------mux81-----------------------------------------------
	 component mux81 is
		 port(a0,a1,a2,a3,a4,a5,a6,a7 : in std_logic_vector(15 downto 0);
					s0,s1,s2                : in std_logic;
		      c                       : out std_logic_vector(15 downto 0));
	 end component; 
-----------------------16bit adder--------------------------------------------
   component sixteen_bit_adder is
		 port(A,B		 : in std_logic_vector(15 downto 0);
		 			RESULT : out std_logic_vector(15 downto 0));
   end component;
---------------------- 16bit subtracter----------------------------------------
	 component sixteen_bit_subtracter is
		 port (A, B	  : in std_logic_vector(15 downto 0); 
		 			 RESULT : out std_logic_vector(15 downto 0));
	 end component;
----------------------16bit Nand-----------------------------------------------
   component sixteen_bit_nand is
		 port(A,B		 : in std_logic_vector(15 downto 0);
		 			RESULT : out std_logic_vector(15 downto 0));
   end component;
-----------------------ALU-----------------------------------------------------
   component ALU is
		 port (x,y						  : in std_logic_vector(15 downto 0);
		 			 op1,op0, flagset : in std_logic;
		 			 s							  : out std_logic_vector(15 downto 0);
		 			 c, z						  : out std_logic);
   end component;
------------------------DataRegister-------------------------------------------
	component DataRegister is
		generic (data_width:integer);
		port (Din         : in std_logic_vector(data_width-1 downto 0);
			    Dout        : out std_logic_vector(data_width-1 downto 0);
			    clk, enable : in std_logic);
  end component;
-----------------------IRLatch-------------------------------------------------
	component IR_Latch is
		generic (data_width:integer);
		port (Din         : in std_logic_vector(data_width-1 downto 0);
			    Dout        : out std_logic_vector(data_width-1 downto 0);
			    clk, enable : in std_logic);
	end component;
-----------------------Memory----------------------------------------------------
	component memory is
		port(A,Din         					  : in  std_logic_vector(15 downto 0);
				 Dout					 					  : out std_logic_vector(15 downto 0);
				 clock,mem_Write,mem_read : in  std_logic);
	end component;
----------------------PriorityEncoder---------------------------------------------
	component PriorityEncoder is
		port (x : in std_logic_vector(15 downto 0);
					y : out std_logic_vector(15 downto 0);
		 			s : out std_logic_vector(2 downto 0));
	end component;
-----------------------Flag-------------------------------------------------------
	component flag is 
		port(Din  : in std_logic_vector(15 downto 0);
				 Dout : out std_logic;
				 clk  : in std_logic);
	end component;
--------------------------RegFile-------------------------------------------------
	component RegFile is
		port(A1,A2,A3			 			  : in  std_logic_vector(2 downto 0);
				 D1,D2,R7_out	 			  : out std_logic_vector(15 downto 0);
				 D3,R7_in			 			: in  std_logic_vector(15 downto 0);			
				 clock,RF_Write,R7_En : in  std_logic);
	end component RegFile;
------------------------Shifter--------------------------------------------------
	component Shifter is
		port(Iin   : in std_logic_vector(8 downto 0);
				 Iout  : out std_logic_vector(15 downto 0);
				 clock : in  std_logic);
	end component Shifter;
------------------------Sign_Extender_by_10--------------------------------------
	component Sign_Extender_by_10 is
		port(Iin   : in std_logic_vector(5 downto 0);
				 Iout  : out std_logic_vector(15 downto 0);
				 clock : in  std_logic);
	end component Sign_Extender_by_10;
------------------------Sign_Extender_by_7----------------------------------------
	component Sign_Extender_by_7 is
		port(Iin   : in std_logic_vector(8 downto 0);
				 Iout  : out std_logic_vector(15 downto 0);
				 clock : in  std_logic);
	end component Sign_Extender_by_7;
--------------------------Controller----------------------------------------------
	component controller is
		port(opcode 											  : in std_logic_vector(3 downto 0);
				 cz 													  : in std_logic_vector(1 downto 0);
				 T6flag,c,z,clock 						  : in std_logic;
				 Mem_mux											  : out std_logic_vector(1 downto 0);
				 A1_mux												  : out std_logic;
				 A2_mux,A3_mux,D3_mux,T5_mux	  : out std_logic_vector(1 downto 0);
				 ALU_a_mux,ALU_b_mux					  : out std_logic_vector(2 downto 0);
				 T6_mux,Mem_enable,IR_enable,
				 RF_enable,R7_enable,T1_enable,
				 T2_enable,T3_enable,T4_enable,
				 T5_enable,T6_enable,T7_enable,
				 T8_enable,T10_enable,flagset   : out std_logic;
				 ALU_opcode											: out std_logic_vector(1 downto 0));
	end component controller ;
-------------------------DataPath--------------------------------------------------
	component datapath is
		port(clock                         : in std_logic;
				 A1_mux                        : in std_logic;
				 A2_mux,A3_mux,D3_mux,Mem_mux  : in std_logic_vector(1 downto 0);
				 ALU_a_mux,ALU_b_mux           : in std_logic_vector(2 downto 0);
				 T5_mux,ALU_opcode             : in std_logic_vector(1 downto 0);
				 T6_mux,Mem_enable,IR_enable,
				 RF_enable,R7_enable,T1_enable,
				 T2_enable,T3_enable,T4_enable,
				 T5_enable,T6_enable,T7_enable,
				 T8_enable,T10_enable,flagset  : in std_logic;
				 opcode                        : out std_logic_vector(3 downto 0);
				 cz                            : out std_logic_vector(1 downto 0);
				 T6flag,c, z                   : out std_logic);
	end component datapath ;

end Components;
