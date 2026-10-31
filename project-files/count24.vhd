-- Contador de modulo 24

Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;



entity count24 is

	port( clk		:	in		std_logic;
			enable	:	in		std_logic;
			btn_Up	:	in		std_logic;
			btn_Down	:	in		std_logic;
			count		:	out	std_logic_vector(4 downto 0));
			
end count24;



architecture Behavioral of count24 is

	signal s_count	:	unsigned(4 downto 0)	:= (others => '0');
	
	begin
	
		process(clk)
		
		begin
		
			if (rising_edge(clk)) then
				if (enable = '1') then
					if (btn_Up = '1') then
					
						s_count <= s_count + 1;
					
						if (s_count = 23) then
							s_count <= (others => '0');
						end if;
					elsif (btn_Down = '1') then
						s_count <= s_count - 1;
						
						if (s_count = 0) then
							s_count <= "10111";
						end if;
					end if;
				else
					s_count <= (others => '0');
				end if;
				
			end if;
		end process;
	count <= std_logic_vector(s_count);
end Behavioral;