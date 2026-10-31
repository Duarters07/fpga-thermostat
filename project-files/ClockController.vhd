Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


entity ClockController is

	port( clk		:	in		std_logic;
			normal	:	in		std_logic;
			AcerH		:	in		std_logic;
			AcerM		:	in		std_logic;
			newH		:	in		std_logic_vector(4 downto 0);
			newM		:	in		std_logic_vector(5 downto 0);
			
			outHora	:	out		std_logic_vector(4 downto 0);
			outMin	:	out		std_logic_vector(5 downto 0));
			
end ClockController;


architecture Behavioral of ClockController is

	signal s_newH	:	unsigned(4 downto 0)	:= (others => '0');
	signal s_newM	:	unsigned(5 downto 0)	:= (others => '0');
	
	begin
	
		process(clk)
		
		begin
		
			if (rising_edge(clk)) then
				
				if (AcerH = '1') then
					s_newH <= unsigned(newH);
				
				elsif (AcerM = '1') then
					s_newM <= unsigned(newM);
				end if;
			end if;
		end process;
		outHora 	<= std_logic_vector(s_newH);
		outMin	<=	std_logic_vector(s_newM);
end Behavioral;