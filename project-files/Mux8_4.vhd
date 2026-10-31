-- Este componente define se que modo(normal, acerto ou programação) é impresso nos display 7 segmentos

Library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity Mux8_4 is

	port( d0, d1, d2, d3, d6, d7				:	in		std_logic_vector(3 downto 0);
			sel										:	in		std_logic;
			out0, out1, out2, out3				:	out	std_logic_vector(3 downto 0));
			
end Mux8_4;


architecture Behavioral of Mux8_4 is

	begin
	
		out0	<= d0 when (sel = '0') else
						"0000";
						
		out1	<= d1 when (sel = '0') else
						"0000";
						
		out2	<= d2 when (sel = '0') else
						d6;
		
		out3	<= d3 when (sel = '0') else
						d7;
						
end Behavioral;