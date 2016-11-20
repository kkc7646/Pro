----------------------------------------------Implementation-------------------------------------
library std;
library ieee;
use ieee.std_logic_1164.all;

entity controller is
  port(opcode                          : in std_logic_vector(3 downto 0);
			 cz                              : in std_logic_vector(1 downto 0);
			 T6flag,c, z                     : in std_logic;
			 clock                           : in std_logic;
			 Mem_mux                         : out std_logic_vector(1 downto 0);
			 A1_mux                          : out std_logic;
			 A2_mux                          : out std_logic_vector(1 downto 0);
			 A3_mux                          : out std_logic_vector(2 downto 0);
			 D3_mux                          : out std_logic_vector(1 downto 0);
			 ALU_a_mux                       : out std_logic_vector(2 downto 0);
			 ALU_b_mux                       : out std_logic_vector(2 downto 0);
			 T5_mux                          : out std_logic_vector(1 downto 0);
			 T6_mux,Mem_enable,IR_enable,
			 RF_enable,R7_enable,T1_enable,
			 T2_enable,T3_enable,T4_enable,
			 T5_enable,T6_enable,T7_enable,
			 T8_enable,T10_enable,flagset    : out std_logic;
			 ALU_opcode                      : out std_logic_vector(1 downto 0));
end entity controller ;

architecture Behave of controller is
	type FsmState is (S1,S2,S3,S4,S8,S9,S12,S13,S14,S15,S16,S17,S18,S19,S20,S21,S23,S24,S25,S26,S27,S28,S29);
	signal fsm_state : FsmState := S1;
	begin
	process(fsm_state,opcode,T6flag,c,z,clock,cz)
		variable next_state  :FsmState;
		variable cflag,zflag : std_logic;
	begin
			next_state := fsm_state;
		case fsm_state is
     
     when S1 => 
    		Mem_mux<="10"; ALU_a_mux <= "000"; ALU_b_mux <= "010"; Mem_enable <='0'; T5_mux <= "00";
    		T6_mux <= '0';A1_mux <= '0'; A2_mux <= "00"; A3_mux <= "000"; D3_mux <= "00";
				IR_enable <='1'; RF_enable <= '0'; R7_enable <= '1'; T1_enable <= '0'; T2_enable <= '0';
				T3_enable<='0'; T4_enable<='0'; T5_enable<= '0' ;T6_enable <='0'; T7_enable<='1' ; 		
				T8_enable<='0';	T10_enable <='0'; ALU_opcode <="00";
				flagset <= '0';
				if ((opcode = "0000")or (opcode ="0010")) and ((cz="01" and z ='0')or (cz ="10" and c ='0')) then
							next_state :=S1;
			elsif(((opcode = "0000")or (opcode ="0010")) and (((cz ="00")or(cz="01" and z ='1'))or (cz ="10" and c ='1'))) or (opcode ="0001") or (opcode ="1100") or (opcode ="0110") or (opcode ="0111") then
					next_state :=S2;
		  elsif (opcode = "1001" or opcode = "1000") then
							next_state :=S18;
			elsif (opcode = "0100" or opcode = "0101") then
		   				next_state :=S12;
		   elsif  (opcode = "0011") then
				next_state:=S17;
			end if;

     when S2 =>
      A1_mux <= '0';A2_mux <= "01" ; T6_mux <= '0'; ALU_a_mux <= "011" ;ALU_b_mux <= "011" ; ALU_opcode <= "00" ;
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '0'; R7_enable <= '0';
			T1_enable <='1' ; T2_enable <= '1' ; T3_enable  <= '1'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '1';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
			flagset <= '0';
				   if (opcode = "0000") then
							next_state := S3;
					elsif(opcode = "0001") then 
							next_state := S13;
					elsif(opcode = "0010") then
						next_state:=S9 ;
					elsif (opcode = "1100") then 
						next_state:=S21;
					elsif ((opcode = "0110") or (opcode = "0111")) and (T6flag = '1') then 
						next_state:= S23; 
					elsif ((opcode = "0110") or (opcode = "0111")) and (T6flag = '0') then 
						next_state:=S1;
					end if;
												 
     when S3 =>
      ALU_a_mux <= "010" ;ALU_b_mux <= "000" ; ALU_opcode <= "00" ;
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '0'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '1'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
			flagset <= '1';
				next_state := S4;
				
     when S4 =>
      A3_mux <= "000" ;D3_mux <= "00" ;
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '1'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '0'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
      flagset <= '0';
				next_state := S1;
				
     when S8 => 
    	A3_mux <= "010" ;D3_mux <= "00" ;
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '1'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '0'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0';
      flagset <= '0';
				next_state := S1;
			
     when S9 =>
      ALU_a_mux <= "010" ;ALU_b_mux <= "000" ; ALU_opcode <= "10" ;
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '0'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '1'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0';
			flagset <= '1';
				next_state := S4;

     when S12 =>
			A1_mux <= '1' ; A2_mux <= "00" ;      
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '0'; R7_enable <= '0';
			T1_enable <='1' ; T2_enable <= '1' ; T3_enable  <= '0'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
			flagset <= '0';
				if (opcode = "0100") or (opcode = "0101") then	
						next_state := S13; 
				elsif (opcode = "1001") then
						next_state := S20;
				end if;

     when S13 =>
      ALU_a_mux <= "010" ;ALU_b_mux <= "011" ; ALU_opcode <= "00" ;      
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '0'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '1'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
			flagset <= '1';
				 if (opcode = "0001") then 
							next_state := S8;
					elsif (opcode = "0101") then
							next_state := S16; 
					elsif (opcode = "0100") then
							next_state := S14;
					end if;

     when  S14 =>
    	Mem_mux <= "00";
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '0'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '0'; 
			T4_enable <='1' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
			flagset <= '0';
				next_state := S15;
				
		 when S15 => 
    	A3_mux <= "001" ;D3_mux <= "01" ;
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '1'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '0'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
			flagset <= '0';
				next_state := S1;

     when S16 =>
      Mem_mux <= "00";
			Mem_enable <= '1'; IR_enable <='0'; RF_enable <= '0'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '0'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
      flagset <= '0';
				next_state := S1;

     when S17 =>
      A3_mux <= "001" ;D3_mux <= "10" ;
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '1'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '0'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
      flagset <= '0';
				next_state := S1;

     when S18 =>
      A3_mux <= "001" ;D3_mux <= "11" ;
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '1'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '0'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
      flagset <= '0';
				 if (opcode = "1001") then
						next_state := S12; 
				elsif (opcode = "1000") then
						next_state := S19; 
				end if;

     when  S19 =>
			ALU_a_mux <= "011" ;ALU_b_mux <= "011" ; ALU_opcode <= "00" ;
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '0'; R7_enable <= '1';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '0'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
      flagset <= '0';
				next_state := S1;

		 when  S20 =>
			ALU_a_mux <= "010" ;ALU_b_mux <= "110" ; ALU_opcode <= "00" ;
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '0'; R7_enable <= '1';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '0'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
      flagset <= '0';
				next_state := S1;

	 	 when S21 => 
    	ALU_a_mux <= "010" ;ALU_b_mux <= "000" ; ALU_opcode <= "01" ;A3_mux <= "100" ;D3_mux <= "00" ;
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= z; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '0'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
      flagset <= '0';
				next_state := S1;

     when S23 =>
      T5_mux <= "01";
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '0'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '0'; 
			T4_enable <='0' ; T5_enable <= '1' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '1' ; T10_enable <= '1'; 
      flagset <= '0';
				 if (opcode = "0110") then 
					next_state := S24 ;
				elsif(opcode = "0111")  then
					next_state := S28;
					end if;

     when S24 =>
      Mem_mux <= "11"; ALU_a_mux <= "100" ;ALU_b_mux <= "101" ; ALU_opcode <= "11" ;
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '0'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '1'; 
			T4_enable <='1' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
      flagset <= '0';
				next_state := S25;

     when S25 =>
      A3_mux <= "011" ;D3_mux <= "01" ; T6_mux <= '1';     
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '1'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '0'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '1';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
				next_state := S26;

    when  S26 =>	
			ALU_a_mux <= "001" ;ALU_b_mux <= "010" ; ALU_opcode <= "00" ;
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '0'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '1'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
	    flagset <= '0';			
			 if (T6flag = '1') then
					next_state := S27;
			elsif (T6flag = '0') then
					next_state := S1 ;
			end if;
			
	  when S27 => 
			T5_mux <= "10";    
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '0'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '0'; 
			T4_enable <='0' ; T5_enable <= '1' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '1' ; T10_enable <= '1'; 
			flagset <= '0';	
				 if  (opcode = "0110") then 
					  next_state := S24;
				elsif (opcode = "0111") then
						next_state := S28;
				end if;
				
    when S28 =>
      A2_mux <= "10"; ALU_a_mux <= "100" ;ALU_b_mux <= "010" ; ALU_opcode <= "11" ;
			Mem_enable <= '0'; IR_enable <='0'; RF_enable <= '0'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '1' ; T3_enable  <= '1'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '0';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
      flagset <= '0';
				next_state := S29;

    when S29 =>
      Mem_mux <= "11"; T6_mux <= '1';
			Mem_enable <= '1'; IR_enable <='0'; RF_enable <= '0'; R7_enable <= '0';
			T1_enable <='0' ; T2_enable <= '0' ; T3_enable  <= '0'; 
			T4_enable <='0' ; T5_enable <= '0' ; T6_enable  <= '1';
			T7_enable <='0' ; T8_enable <= '0' ; T10_enable <= '0'; 
      flagset <= '0';
				next_state := S26;

   end case;          

   if(rising_edge(clock)) then
       fsm_state <= next_state;
   end if;
   
	end process;
end Behave;
