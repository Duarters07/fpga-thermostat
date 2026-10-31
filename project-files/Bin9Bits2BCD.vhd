-- Conversor de 9bits para 2 bcd.

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Bin9Bits2BCD is

    port(bin   			:	in		std_logic_vector(8 downto 0);
			bcd_deicmas		:	out	std_logic_vector(3 downto 0);
			bcd_unidades	:	out 	std_logic_vector(3 downto 0);
			bcd_dezenas		:	out	std_logic_vector(3 downto 0);
			bcd_Graus		:	out	std_logic_vector(3 downto 0));
	 
end Bin9Bits2BCD;

architecture Behavioral of Bin9Bits2BCD is

	signal decimas, unidades, dezenas	:	unsigned(8 downto 0);
	
	begin
	
		dezenas <= unsigned(bin) / 100;
		bcd_dezenas <= std_logic_vector(dezenas)(3 downto 0);
		
		
		
		unidades <=(unsigned(bin) / 10) mod 10;
      bcd_unidades <= std_logic_vector(unidades)(3 downto 0);
		
		decimas			<=	unsigned(bin) mod 10;
      bcd_deicmas	<=	std_logic_vector(decimas)(3 downto 0);
		
		bcd_Graus	<= "1110";


end Behavioral;