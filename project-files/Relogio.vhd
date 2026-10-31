-- Componente que simula o bloco relógio 

Library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity Relogio is

	port(	clk			:	in		std_logic;
			enable		:	in		std_logic;
			
			normalState	:	in		std_logic;
			AcertMState	:	in		std_logic;
			AcertHState	:	in		std_logic;
			
			btn_Up		:	in		std_logic;
			btn_Down		:	in		std_logic;
			
			Min_U		:	out	std_logic_vector(3 downto 0);
			Min_D		:	out	std_logic_vector(3 downto 0);
			Horas_U	:	out	std_logic_vector(3 downto 0);
			Horas_D	:	out	std_logic_vector(3 downto 0);
			RamRead	:	out	std_logic_vector(4 downto 0));

end Relogio;


architecture Behavioral of Relogio is

	signal	s_countMin		:	std_logic_vector(5 downto 0);
	signal	s_countHoras	:	std_logic_vector(4 downto 0);
	
	signal	s_M_min_U, s_M_min_D			:	std_logic_vector(3 downto 0);
	signal	s_H_horas_U, s_H_horas_D	:	std_logic_vector(3 downto 0);
	
	signal	s_normal_min_U, s_normal_min_D			:	std_logic_vector(3 downto 0);
	signal	s_normal_horas_U, s_normal_horas_D		:	std_logic_vector(3 downto 0);
	
	signal s_formatM, s_outMin			:	std_logic_vector(5 downto 0);
	signal s_formatH, s_outHora		:	std_logic_vector(4 downto 0);
	
	begin
	
		countMin		:	entity work.count60(Behavioral)
								port map( clk			=>	clk,
											 enable		=>	AcertMState,
											 btn_Up		=>	btn_Up,
											 btn_Down	=>	btn_Down,
											 count		=>	s_countMin);
											 
		countHoras	:	entity work.count24(Behavioral)
								port map( clk			=>	clk,
											 enable		=>	AcertHState,
											 btn_Up		=>	btn_Up,
											 btn_Down	=>	btn_Down,
											 count		=>	s_countHoras);
											 
		BinBcdMin	:	entity work.BinMinBCD(Behavioral)
								port map( BinMin		=>	s_countMin,
											 OutMin0		=> s_M_min_U,	
											 OutMin1		=> s_M_min_D);
		
		BinbcdHor	:	entity work.Bin2BCD(Behavioral)
								port map( binInput	=> s_countHoras,
											 output0		=>	s_H_horas_U,
											 output1		=>	s_H_horas_D);
		
		ControlClk	:	entity work.ClockController(Behavioral)
								port map( clk			=>	clk,
											 normal		=>	normalState,
											 AcerH		=>	AcertHState,
											 AcerM		=> AcertMState,
											 newH			=>	s_countHoras,
											 newM			=> s_countMin,
											 outHora		=> s_formatH,
											 outMin		=> s_formatM);
											 
		Normal		:	entity work.NormalMod(Behavioral)
								port map( clk			=>	clk,
											 enable		=> enable,
											 AcerH		=> AcertHState,
											 AcerM		=> AcertMState,
											 newH			=>	s_formatH,
											 newMin		=>	s_formatM,
											 outHora		=>	s_outHora,
											 outMin		=> s_outMin);
											 
		BinMBCDNorm	:	entity work.BinMinBCD(Behavioral)
								port map( BinMin		=>	s_outMin,
											 OutMin0		=> s_normal_min_U,	
											 OutMin1		=> s_normal_min_D);
		
		Bin2BCDNor	:	entity work.Bin2BCD(Behavioral)
								port map( binInput	=> s_outHora,
											 output0		=>	s_normal_horas_U,
											 output1		=>	s_normal_horas_D);
							
		Rel			:	entity work.RelogioControler(Behavioral)
								port map( clk			=>	clk,
											 EstadoH		=> AcertHState,
											 EstadoM		=>	AcertMState,
											 EstadoNormal	=> normalState,
											 H_horas_Dez	=>	s_H_horas_D,
											 H_horas_Uni	=>	s_H_horas_U,
											 M_Min_Dez		=>	s_M_min_D,
											 M_Min_Uni		=> s_M_min_U,
											 clk_Min_Dez	=> s_normal_min_D,
											 clk_Min_Uni	=>	s_normal_min_U,
											 clk_Hora_Dez	=>	s_normal_horas_D,
											 clk_Hora_Uni	=>	s_normal_horas_U,
											 h_Dez			=> Horas_D,
											 h_Uni			=>	Horas_U,
											 m_Dez			=>	Min_D,
											 m_Uni			=>	Min_U);
		
		
		RamRead	<=	s_outHora;
end Behavioral;
		
		