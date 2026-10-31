-- Projeto Final

Library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity ProjetoFinal is

	port( clock_50		:	in		std_logic;
			SW				:	in		std_logic_vector(1 downto 0);
			KEY			:	in		std_logic_vector(3 downto 0);
			
			LEDR			:	out	std_logic_vector(0 downto 0);
			LEDG			:	out	std_logic_vector(2 downto 0);
			HEX0			:	out	std_logic_vector(7 downto 0);
			HEX1			:	out	std_logic_vector(7 downto 0);
			HEX2			:	out	std_logic_vector(7 downto 0);
			HEX3			:	out	std_logic_vector(7 downto 0);
			HEX4			:	out	std_logic_vector(7 downto 0);
			HEX5			:	out	std_logic_vector(7 downto 0);
			HEX6			:	out	std_logic_vector(7 downto 0);
			HEX7			:	out	std_logic_vector(7 downto 0));
			
end ProjetoFinal;

architecture Shell of ProjetoFinal is

	-- Sinal do Pulso
	signal sinal_pulso	:	std_logic;
	
	-- Sinal do Pulso 1 seg
	signal s_pulso_seg	:	std_logic;
	
	-- Debounce saida Botões
	signal saida_Key0, saida_Key1, saida_Key2, saida_Key3 	:	std_logic;
	
	--Sinais saida maquina de estados
	signal s_selAcerOrProg	:	std_logic;
	signal s_SelStateProg	:	std_logic_vector(1 downto 0);
	signal s_normalState, s_acertMState, s_acertHState	:	std_logic;
	signal s_proGelState, s_proLuaState, s_proSolState	:	std_logic_vector(1 downto 0);
	
	-- Sinais Relogio
	signal s_Min_U, s_Min_D, s_Horas_U, s_Horas_D	:	std_logic_vector(3 downto 0);
	signal s_RamRead	:	std_logic_vector(4 downto 0);
	
	-- Sinais Programação
	signal s_Horas_D_P, s_Horas_U_P	:	std_logic_vector(3 downto 0);
	signal s_RamAdd	:	std_logic_vector(4 downto 0);
	
	--Sinai Mux3_1
	signal s_out	:	std_logic_vector(1 downto 0);
	
	-- Sinais Ram
	signal s_readDt	:	std_logic_vector(1 downto 0);
	
	-- Sinais Controler_On_Off
	signal s_OutP	:	std_logic;
	
	-- Sinais simulador_ambiente
	signal s_tempAmb	:	std_logic_vector(8 downto 0);
	
	-- Mux8_4
	signal s_out0, s_out1, s_out2, s_out3	:	std_logic_vector(3 downto 0);

	begin
	
		-- Gerador de Pulsos
		pulseGen			:	entity work.pulse_gen(Behavioral)
									port map( clk		=>	clock_50,
												 acel		=>	SW(1 downto 0),
												 pulse	=>	sinal_pulso);
										
		-- Debounce Botão Key0 - Botao decremento
		debounceKEY0_m	:	entity work.DebounceUnit(Behavioral)
									port map( refClk		=>	clock_50,
												 dirtyIn		=>	KEY(0),
												 pulsedOut	=>	saida_Key0);
												 
		-- Debounce Botão Key1 - Botao incremento
		debounceKEY1_M	:	entity work.DebounceUnit(Behavioral)
									port map( refClk		=>	clock_50,
												 dirtyIn		=>	KEY(1),
												 pulsedOut	=>	saida_Key1);
												 
												 
		-- Debounce Botão Key2 - Botao Programação
		debounceKEY2_P	:	entity work.DebounceUnit(Behavioral)
									port map( refClk		=>	clock_50,
												 dirtyIn		=>	KEY(2),
												 pulsedOut	=>	saida_Key2);
												 
		-- Debounce Botão Key3 - Botao Acerto
		debounceKEY3_S	:	entity work.DebounceUnit(Behavioral)
									port map( refClk		=>	clock_50,
												 dirtyIn		=>	KEY(3),
												 pulsedOut	=>	saida_Key3);
												 
		-- Máquina de estados finita
		fsm				:	entity work.FSM(Behavioral)
									port map( clk				=>	clock_50,
												 btn_P			=>	saida_Key3,
												 btn_S			=>	saida_Key2,
												 
												 selAcerOrProg	=>	s_selAcerOrProg,
												 SelStateProg	=>	s_SelStateProg,
												 normalState	=>	s_normalState,
												 acertMState	=> s_acertMState,
												 acertHState	=>	s_acertHState,
												 proGelState	=> s_proGelState,
												 proLuaState	=>	s_proLuaState,
												 proSolState	=> s_proSolState);
												 
		-- Relogio
		relogio			:	entity work.Relogio(Behavioral)
									port map( clk				=>	clock_50,
												 enable			=>	sinal_pulso,
												 normalState	=> s_normalState,
												 AcertMState	=>	s_acertMState,
												 AcertHState	=> s_acertHState,
												 btn_Up			=> saida_Key1,
												 btn_Down		=> saida_Key0,
													
												 Min_U			=> s_Min_U,
												 Min_D			=>	s_Min_D,
												 Horas_U			=>	s_Horas_U,
												 Horas_D			=> s_Horas_D,
												 RamRead			=> s_RamRead);
							
		-- Programação
		ModProgramacao	:	entity work.Programacao(behavioral)
									port map( clk			=>	clock_50,
												 enable		=>	s_selAcerOrProg,
												 btn_Up		=> saida_Key1,
												 btn_Down	=>	saida_Key0,
												 
												 Horas_D		=>	s_Horas_D_P,
												 Horas_U		=> s_Horas_U_P,
												 RamAdd		=> s_RamAdd);
												 
		-- Mux3_1
		multi3_1			:	entity work.Mux3_1(Behavioral)
									port map( d0	=>	s_proGelState,
												 d1	=> s_proLuaState,
												 d2	=>	s_proSolState,
												 sel	=> s_SelStateProg,
												 
												 out0	=>	s_out);
												 
		-- Ram_1P_32x2
		Ram				:	entity work.Ram_1P_32x2(Behavioral)
									port map( clk			=>	clock_50,
												 writeEn		=> s_selAcerOrProg,
												 writeDt		=>	s_out,
												 address		=>	s_RamAdd,
												 readAd		=>	s_RamRead,
												 
												 LGel			=>	LEDG(0),
												 LLua			=>	LEDG(1),
												 LSol			=> LEDG(2),
												 readDt		=>	s_readDt);
												 
		-- Controler_On_Off
		ControloOnOff	:	entity work.Controler_On_Off(Behavioral)
									port map( clk			=>	clock_50,
												 enable		=>	sinal_pulso,
												 TRef			=>	s_readDt,
												 TH			=>	s_tempAmb,
												 
												 LedOut		=>	LEDR(0),
												 OutP			=>	s_OutP);
												 
		-- simulador_ambiente
		simAmb			:	entity work.simulador_ambiente(Behavioral)
									port map( clk			=> clock_50,
												 enable		=> sinal_pulso,
												 radiadorOn	=> s_OutP,
												 
												 tempAmb		=> s_tempAmb);
												 
		-- Unidade Display Temperatura
		DisplayTempera	:	entity work.DisplayUnitTemp(Behavioral)
									port map( bin		=>	s_tempAmb,
												
												 dispOut0	=>	HEX4(6 downto 0),
												 dispOut1	=>	HEX5(6 downto 0),
												 dispOut2	=>	HEX6(6 downto 0),
												 dispOut3	=>	HEX7(6 downto 0));
												 
												 
		-- Mux8_4
		Mux8_1			:	entity work.Mux8_4(Behavioral)
									port map( d0		=>	s_Min_U,
												 d1		=>	s_Min_D,
												 d2		=>	s_Horas_U,
												 d3		=>	s_Horas_D,
												 d6		=>	s_Horas_U_P,
												 d7		=>	s_Horas_D_P,
												 sel		=>	s_selAcerOrProg,
												 
												 out0		=> s_out0,
												 out1		=> s_out1,
												 out2		=> s_out2,
												 out3		=> s_out3);
												 
		-- Display Uni
		DisplayHoras	:	entity work.DisplayUnit(Behavioral)
									port map( clk		=>	clock_50,
												 AcerH	=>	s_acertHState,
												 AcerM	=>	s_acertMState,
												 min_U	=> s_out0,
												 min_D	=>	s_out1,
												 horas_U	=> s_out2,
												 horas_D	=> s_out3,
												 
												 dispOut0	=>	HEX0(6 downto 0),
												 dispOut1	=>	HEX1(6 downto 0),
												 dispOut2	=>	HEX2(6 downto 0),
												 dispOut3	=>	HEX3(6 downto 0));
												 
end Shell;