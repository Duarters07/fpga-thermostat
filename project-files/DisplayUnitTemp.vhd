-- Unidade de display da temperatura.

Library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity DisplayUnitTemp is
	
	port( bin		:	in		std_logic_vector(8 downto 0);
			
			dispOut0	:	out	std_logic_vector(6 downto 0);
			dispOut1	:	out	std_logic_vector(6 downto 0);
			dispOut2	:	out	std_logic_vector(6 downto 0);
			dispOut3	:	out	std_logic_vector(6 downto 0));
			
end DisplayUnitTemp;


architecture Behavioral of DisplayUnitTemp is

	-- Sinais Bin9Bits2BCD
	signal s_bcd_deicmas, s_bcd_unidades, s_bcd_dezenas, s_bcd_Graus	:	std_logic_vector(3 downto 0);
	
	begin
	
		-- Bin9Bits2BCD
		BintoBCD			:	entity work.Bin9Bits2BCD(Behavioral)
									port map( bin			  	=>	bin,
												 bcd_deicmas	=> s_bcd_deicmas,
												 bcd_unidades	=> s_bcd_unidades,
												 bcd_dezenas	=> s_bcd_dezenas,
												 bcd_Graus		=>	s_bcd_Graus);
													 
		-- Display Graus
		DisplayGrau		:	entity work.Bin7SegDecoderEn(Behavioral)
									port map( binInput	=> s_bcd_Graus,
												 enable		=> '1',
												 decOut_n	=> dispOut0);
		-- Display Decimas								 
		DisplayDecimas	:	entity work.Bin7SegDecoderEn(Behavioral)
									port map( binInput	=> s_bcd_deicmas,
												 enable		=> '1',
												 decOut_n	=> dispOut1);
												 
		-- Display Unidades										 
		DisplayUni		:	entity work.Bin7SegDecoderEn(Behavioral)
									port map( binInput	=> s_bcd_unidades,
												 enable		=> '1',
												 decOut_n	=> dispOut2);
		-- Display Dezenas									
		DisplayDez		:	entity work.Bin7SegDecoderEn(Behavioral)
									port map( binInput	=> s_bcd_dezenas,
												 enable		=> '1',
												 decOut_n	=> dispOut3);
												 
end Behavioral;