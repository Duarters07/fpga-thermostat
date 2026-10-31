Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


entity NormalMod is
	port( clk		:	in		std_logic;
			enable	:	in		std_logic;
			AcerH		:	in 	std_logic;
			AcerM		:	in		std_logic;
			
			newH		:	in		std_logic_vector(4 downto 0);
			newMin	:	in		std_logic_vector(5 downto 0);
			
			outHora	:	out	std_logic_vector(4 downto 0);
			outMin	:	out	std_logic_vector(5 downto 0));
			
end NormalMod;

architecture Behavioral of NormalMod is
	
	signal s_min		:	unsigned(5 downto 0) := (others => '0');
	signal s_hora		:	unsigned(4 downto 0)	:=	(others => '0');
	
	signal s_countMin		:	unsigned(5 downto 0) := (others => '0');
	signal s_countHora	:	unsigned(4 downto 0)	:= (others => '0');
	
	begin
	
		process(clk)
		
		begin
		
			if (rising_edge(clk)) then
				
					if (AcerM = '1') then
					
						s_min <= unsigned(newMin);
						s_countMin <= s_min;
						
					elsif ( AcerH = '1') then
					
						s_hora 	<= unsigned(newH);
						s_countHora	<= s_hora;
				
					else
						if (enable = '1') then
						
							if (s_countMin = "111011") then
								s_countMin <= (others => '0');
								
								if (s_countHora = "10111") then
									s_countHora <= (others => '0');
								else
									s_countHora <= s_countHora + 1;
								end if;
								
							else
								s_countMin <= s_countMin + 1;
							end if;
						end if;
					end if;
			end if;
			
			outHora	<= std_logic_vector(s_countHora);
			outMin	<= std_logic_vector(s_countMin);
			
		end process;
		
end Behavioral;