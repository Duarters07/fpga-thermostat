Library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity Mux3_1 is

	port( d0, d1, d2		:	in		std_logic_vector(1 downto 0);
			sel				:	in		std_logic_vector(1 downto 0);
			out0				:	out	std_logic_vector(1 downto 0));
			
end Mux3_1;


architecture Behavioral of Mux3_1 is

	begin
	
		out0	<= d0 when (sel = "00") else
					d1 when (sel = "01") else
					d2;
						
end Behavioral;