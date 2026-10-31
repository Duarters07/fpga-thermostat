-- Conversor de binário para os display de minutos

Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity BinMinBCD is

	port( BinMin	:	in		std_logic_vector(5 downto 0);
			OutMin0	:	out	std_logic_vector(3 downto 0);
			OutMin1	:	out	std_logic_vector(3 downto 0));
			
end BinMinBCD;



architecture Behavioral of BinMinBCD is

	signal s_BinMin	:	unsigned(5 downto 0);
	
	begin
	
		s_BinMin	<=	unsigned(BinMin);
		
		OutMin0	<=	std_logic_vector(s_BinMin rem 10)(3 downto 0);
		OutMin1	<=	std_logic_vector((s_BinMin - (s_BinMin rem 10)) / 10)(3 downto 0);
	
end Behavioral;