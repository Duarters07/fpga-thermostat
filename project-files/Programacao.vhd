Library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity Programacao is

	port( clk		:	in		std_logic;
			enable	:	in		std_logic;
			
			btn_Up	:	in		std_logic;
			btn_Down	:	in		std_logic;
			
			Horas_D	:	out	std_logic_vector(3 downto 0);
			Horas_U	:	out	std_logic_vector(3 downto 0);
			RamAdd	:	out	std_logic_vector(4 downto 0));

end Programacao;


architecture Behavioral of Programacao is

	signal	s_count	:	std_logic_vector(4 downto 0);
	
	begin
	
		countHoras		:	entity work.count24(Behavioral)
									port map( clk			=>	clk,
												 enable		=>	enable,
												 btn_Up 		=>	btn_Up,
												 btn_Down	=>	btn_Down,
												 count 		=>	s_count);
												 
		bin2Bcd			:	entity work.Bin2BCD(Behavioral)
									port map( binInput	=>	s_count,
												 output0		=>	Horas_U,
												 output1		=>	Horas_D);

		RamAdd <= s_count;
end Behavioral;