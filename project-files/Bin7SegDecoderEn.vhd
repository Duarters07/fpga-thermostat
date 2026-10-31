library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity Bin7SegDecoderEn is

	 port(binInput : 	in 	std_logic_vector(3 downto 0);
			enable	:	in		std_logic;
			decOut_n : 	out 	std_logic_vector(6 downto 0));
	 
end Bin7SegDecoderEn;


architecture Behavioral of Bin7SegDecoderEn is

begin	
	
	decOut_n <=  (others => '1') when enable = '0' else
							 "1111001" when (binInput = "0001") else --1
							 "0100100" when (binInput = "0010") else --2
							 "0110000" when (binInput = "0011") else --3
							 "0011001" when (binInput = "0100") else --4
							 "0010010" when (binInput = "0101") else --5
							 "0000010" when (binInput = "0110") else --6
							 "1111000" when (binInput = "0111") else --7
							 "0000000" when (binInput = "1000") else --8
							 "0010000" when (binInput = "1001") else --9
							 "0011100" when (binInput = "1110") else -- Imprime o simbolo do grau
							 "1000000"; --0
end Behavioral;