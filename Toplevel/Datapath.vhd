library work;
use work.Components.all;
library std;
library ieee;
use ieee.std_logic_1164.all;


entity datapath is
  port(opcode :out std_logic_vector(3 downto 0);
			cz : out std_logic_vector(1 downto 0);
			T6flag,c, z : out std_logic;
			clock : in std_logic;
			Mem_mux: in std_logic_vector(1 downto 0);
			A1_mux:  in std_logic;
			A2_mux:  in std_logic_vector(1 downto 0);
			A3_mux:  in std_logic_vector(1 downto 0);
			D3_mux:  in std_logic_vector(1 downto 0);
			ALU_a_mux: in std_logic_vector(2 downto 0);
			ALU_b_mux: in std_logic_vector(2 downto 0);
			T5_mux: in std_logic_vector(1 downto 0);
			T6_mux,Mem_enable,IR_enable,RF_enable,R7_enable,T1_enable,
			T2_enable,T3_enable,T4_enable,T5_enable,T6_enable,T7_enable,
			T8_enable,T10_enable,flagset: in std_logic;
			ALU_opcode:in std_logic_vector(1 downto 0));

end entity datapath ;

architecture dataflow of datapath is



signal  D1_dataout, D2_dataout, T1_out, T2_out, T3_out, T4_out, T5_out, T6_out, T7_out,
		  T8_out, R7_out, Mem_out, Sign_extender_7_out, Sign_extender_10_out, Shifter_out,
		  Priority_encoder_out2, Mem_mux_out, T6_mux_out, T5_mux_out, Alu_a_mux_out,
		  Alu_b_mux_out, D3_mux_out, Alu_out, IR_out : std_logic_vector(15 downto 0);
signal T10_out, A1_mux_out, A2_mux_out, A3_mux_out :std_logic_vector(2 downto 0);
signal Priority_encoder_out1,ALU_amux,ALU_bmux: std_logic_vector(2 downto 0);
signal T5mux :std_logic_vector(1 downto 0);	
begin
-------------------------------------ALU-----------------------------------------------------		
DUT1	      : ALU 
		port map(x => Alu_a_mux_out,y => Alu_b_mux_out , op1 => ALU_opcode(1), op0 => ALU_opcode(0),flagset => flagset, s => Alu_out, c => c, z => z);

-------------------------------------RegFile-------------------------------------------------		
DUT2	      : RegFile 
		port map(A1 => A1_mux_out, A2 => A2_mux_out, A3 => A3_mux_out, R7_in=>Alu_out, R7_out => R7_out, R7_En => R7_enable,D1 => D1_dataout, D2 => D2_dataout, D3 => D3_mux_out, RF_Write => RF_enable,clock => clock);

------------------------------------Sign_Extender------------------------------------------		
DUT3	      : Sign_Extender_by_7 
		
		port map(Iin => IR_out(8 downto 0), Iout => Sign_extender_7_out, clock => clock);

-----------------------------------Sign_Extender--------------------------------------		
DUT4	      : Sign_Extender_by_10 
		
		port map( Iin => IR_out(5 downto 0),Iout=>Sign_extender_10_out, clock => clock);

---------------------------------Shifter------------------------------------------------		
DUT5	      : Shifter
		port map( Iin => IR_out(8 downto 0), Iout => Shifter_out, clock => clock);

-----------------------------PriorityEncoder-----------------------------------------		
DUT6	      : PriorityEncoder 
		port map(x => T6_out,s => Priority_encoder_out1,y =>Priority_encoder_out2);

------------------------------Memory--------------------------------------------		
DUT7	      : memory 
		port map(A => Mem_mux_out,Dout => Mem_out, Din => T2_out, mem_write => Mem_enable, mem_read => '1',clock=>clock);
 
	-------------------------------------------------------------------------------

--OPCODE_Reg        : DataRegister
--		generic map (data_width => 4)
--		port map (Din => IR_out(15 downto 12) , Dout => opcode, enable =>'1',clk => clock);
opcode <= IR_out(15 downto 12);
--CZ_Reg            : DataRegister
--		generic map (data_width => 2)
--		port map (Din => IR_out(1 downto 0) , Dout => cz, enable =>'1',clk => clock);
cz <= IR_out(1 downto 0);
IR_latc      : IR_Latch
		generic map(data_width => 16)
		port map(Din => Mem_out, Dout => IR_out, enable=>IR_enable, clk=>clock);
		
T1_latch      : DataRegister 
		generic map(data_width => 16)
		port map(Din => D1_dataout, Dout => T1_out, enable => T1_enable, clk => clock);
		
T2_latch      : DataRegister 
		generic map(data_width => 16)
		port map(Din => D2_dataout, Dout => T2_out, enable => T2_enable, clk => clock);
		
T3_latch      : DataRegister 
		generic map(data_width => 16)
		port map(Din => Alu_out, Dout => T3_out, enable => T3_enable, clk => clock);
		
T4_latch      : DataRegister 
		generic map(data_width => 16)
		port map(Din => Mem_out, Dout => T4_out, enable => T4_enable, clk => clock);
		
T5_latch      : DataRegister 
		generic map(data_width => 16)
		port map(Din => T5_mux_out, Dout => T5_out, enable => T5_enable, clk => clock);
		
T6_latch      : IR_Latch 
		generic map(data_width => 16)
		port map(Din => T6_mux_out, Dout => T6_out, enable => T6_enable, clk => clock);

T6_flag      : flag 
		port map(Din => T6_out,Dout=>T6flag, clk => clock);
		
T7_latch      : DataRegister 
		generic map(data_width => 16)
		port map(Din => R7_out, Dout => T7_out, enable => T7_enable, clk => clock);
		
T8_latch      : DataRegister 
		generic map(data_width => 16)
		port map(Din => Priority_encoder_out2, Dout => T8_out, enable => T8_enable, clk => clock);
		
----------------------------------T10_latch-----------------------------------------------
T10_latch     : DataRegister 
	generic map(data_width => 3)
	port map(Din => Priority_encoder_out1, Dout => T10_out, enable => T10_enable, clk => clock);

---------------------------------ALU_a_mux-------------------------------------------------
ALU_amux <= "011" when (A1_mux_out ="111" and ALU_a_mux = "010")  else (ALU_a_mux);
ALU_a_mux_device: mux81
	 port map	(a0 => R7_out,a1 => T5_out, a2 => T1_out, a3 => T7_out,
				a4 => T6_out, a5 =>(others => '1'), a6 => (others => '1'), a7 =>(others => '1') , c => Alu_a_mux_out,
				s0 => ALU_amux(0), s1 => ALU_amux(1), s2 => ALU_amux(2));
		
----------------------------------ALU_b_mux-----------------------------------------------
ALU_bmux <= "001" when (A2_mux_out ="111" and ALU_b_mux = "000") else (ALU_b_mux);
ALU_b_mux_device: mux81 
	port map (a0 => T2_out, a1 => T7_out, a2 => (0 => '1',others =>'0'),
				a3 => Sign_extender_10_out, a4 => Shifter_out,
				a5 => T8_out, a6 =>(others =>'0'), a7 => (others => '1') , c => Alu_b_mux_out,
				s0 => ALU_bmux(0), s1 => ALU_bmux(1), s2 => ALU_bmux(2));

--------------------------------Mem_mux----------------------------------------------------
Mem_mux_device: mux41 
		generic map(data_width => 16)
		port map (a0 => T3_out, a1 => T2_out, a2 => R7_out, a3 => T5_out, c => Mem_mux_out, s0 => Mem_mux(0), s1 => Mem_mux(1));

-------------------------------A1_mux------------------------------------------------------			
A1_mux_device : mux21  
		generic map(data_width => 3)
		port map (a  => IR_out(11 downto 9), b => IR_out(8 downto 6), c => A1_mux_out, s => A1_mux);

------------------------------A2_mux--------------------------------------------------------		
A2_mux_device : mux41   
		generic map(data_width => 3)
		port map(a0 => IR_out(11 downto 9), a1 => IR_out(8 downto 6), a2 => T10_out, a3 => (others => '1'), c => A2_mux_out, s0 => A2_mux(0), s1 => A2_mux(1));

------------------------------A3_mux---------------------------------------------------------		
A3_mux_device : mux41 
		generic map(data_width => 3)
		port map(a0 => IR_out(5 downto 3), a1 => IR_out(11 downto 9), a2 => IR_out(8 downto 6), a3 => T10_out, c => A3_mux_out, s0 => A3_mux(0), s1 => A3_mux(1));

----------------------------D3_mux---------------------------------------------------		
D3_mux_device : mux41  
		generic map(data_width => 16)
		port map(a0 => T3_out, a1 => T4_out, a2 => Shifter_out, a3 => R7_out, c => D3_mux_out, s0 => D3_mux(0), s1 => D3_mux(1));

----------------------------T5_mux---------------------------------------------------
T5mux <= "00" when ((IR_out(11 downto 9) ="111" and T5_mux = "01") or (IR_out(8 downto 6) = "111" and T5_mux ="10")) else (T5_mux);		
T5_mux_device : mux41  
		generic map(data_width => 16)
		port map(a0 => T7_out, a1 => T1_out, a2 => T3_out, a3 => (others => '1'), c => T5_mux_out, s0 => T5mux(0), s1 => T5mux(1));


-----------------------------T6_mux-------------------------------------------------		
T6_mux_device : mux21   
		generic map(data_width => 16)
		port map(a => Sign_extender_7_out, b => T3_out, c => T6_mux_out, s => T6_mux);
		


end dataflow;

