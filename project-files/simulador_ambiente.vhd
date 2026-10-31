-- Simulador de Ambiente

Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


entity simulador_ambiente is

	port( clk			:	in		std_logic;
			enable		:	in		std_logic;
			radiadorOn	:	in		std_logic;
			tempAmb		:	out	std_logic_vector(8 downto 0));
			
end simulador_ambiente;


architecture Behavioral of simulador_ambiente is

	signal s_tempAmb	:	unsigned(8 downto 0)	:= "010111110";  --Temperatura inicial da sala a 19.0 ºC
	
	begin	
	
		process(clk)
		
		begin
		
			if (rising_edge(clk)) then
			
				if (enable = '1') then
				
					if (radiadorOn = '1') then
						s_tempAmb <= s_tempAmb + 1;
					else
						s_tempAmb <= s_tempAmb - 1;
					end if;
				end if;
			end if;
		tempAmb <= std_logic_vector(s_tempAmb);
	end process;
end Behavioral;