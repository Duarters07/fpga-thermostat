-- Unidade de display tempo com operação blink

Library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity DisplayUnit is
	
	port( clk		:	in		std_logic;
			
			AcerH		:	in		std_logic;
			AcerM		:	in		std_logic;
			
			min_U		:	in		std_logic_vector(3 downto 0);
			min_D		:	in		std_logic_vector(3 downto 0);
			horas_U	:	in		std_logic_vector(3 downto 0);
			horas_D	:	in		std_logic_vector(3 downto 0);
			
			dispOut0	:	out	std_logic_vector(6 downto 0);
			dispOut1	:	out	std_logic_vector(6 downto 0);
			dispOut2	:	out	std_logic_vector(6 downto 0);
			dispOut3	:	out	std_logic_vector(6 downto 0));
			
end DisplayUnit;


architecture Behavioral of DisplayUnit is

	signal s_blink, s_outOperatM, s_outOperatH		:	std_logic;
	
	begin
	
		pulseBlink		:	entity work.BlinkPulseGenerator(Behavioral)
									generic map( NUMBER_STEPS => 50_000_000)
										port map( clk		=>	clk,
													 blink 	=> s_blink);
													 
		operateBlink	:	entity work.BlinkOperation(Behavioral)
										port map( AcerH	=>	AcerH,
													 AcerM	=>	AcerM,
													 blink	=>	s_blink,
													 outOperatM	=>	s_outOperatM,
													 outOperatH	=>	s_outOperatH);
													 
	
		DisplayMinUni	:	entity work.Bin7SegDecoderEn(Behavioral)
									port map( binInput	=> min_U,
												 enable		=> s_outOperatM,
												 decOut_n	=> dispOut0);
												 
		DisplayMinDez	:	entity work.Bin7SegDecoderEn(Behavioral)
									port map( binInput	=> min_D,
												 enable		=> s_outOperatM,
												 decOut_n	=> dispOut1);
												 
												 
		DisplayHorUni	:	entity work.Bin7SegDecoderEn(Behavioral)
									port map( binInput	=> horas_U,
												 enable		=> s_outOperatH,
												 decOut_n	=> dispOut2);
												
		DisplayHorDez	:	entity work.Bin7SegDecoderEn(Behavioral)
									port map( binInput	=> horas_D,
												 enable		=> s_outOperatH,
												 decOut_n	=> dispOut3);
												 
end Behavioral;