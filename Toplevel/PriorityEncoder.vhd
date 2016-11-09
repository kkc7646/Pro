library std;
library ieee ;
use ieee.std_logic_1164.all ;

entity PriorityEncoder is
	port (x:in std_logic_vector(15 downto 0);
				y: out std_logic_vector(15 downto 0);
	 s: out std_logic_vector(2 downto 0));
end PriorityEncoder ;

architecture Structure of PriorityEncoder is
signal x0,x1,x2,x3,x4,x5,x6,x7,s0,s1,s2 : std_logic;
begin
	x0<= x(0);
	x1<= x(1);
	x2<= x(2);
	x3<= x(3);
	x4<= x(4);
	x5<= x(5);
	x6<= x(6);
	x7<= x(7);		


s0 <= (x1 and not x0) or
 (x3 and not x2 and not x1 and not x0) or
(x5 and not x4 and not x3 and not x2 and
 not x1 and not x0) or
(x7 and not x6 and not x5 and not x4
and not x3 and not x2 and not x1
and not x0);
 s1 <= (x2 and not x1 and not x0) or
(x3 and not x2 and not x1 and not x0) or
 (x6 and not x5 and not x4 and not x3 and
not x2 and not x1 and not x0) or
 (x7 and not x6 and not x5 and not x4 and
not x3 and not x2 and not x1 and not x0);
 s2 <= (x4 and not x3 and not x2 and
not x1 and not x0) or
 (x5 and not x4 and not x3 and not x2 and
not x1 and not x0) or
 (x6 and not x5 and not x4 and not x3
and not x2 and not x1 and not x0) or
 (x7 and not x6 and not x5 and not x4 and not x3
and not x2 and not x1 and not x0);

y(15 downto 8) <= "00000000";
y(7)<= (not s0) or (not s1) or (not s2);
y(6) <= (not s2) or (not s1) or s2;
y(5) <= (not s2) or (s1) or (not s0);
y(4) <= (not s2) or (s1) or (s0);
y(3)<=  (s2) or (not s1) or (not s0);
y(2) <= (s2) or (not s1) or (s0);
y(1) <= (s2) or (s1) or (not s0);
y(0) <= (s2) or (s1) or (s0);

s(0)<=s0;
s(1)<=s1;
s(2)<=s2;
end Structure ;
