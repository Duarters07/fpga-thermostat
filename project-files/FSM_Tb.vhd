-- Validação da máquina de estados

Library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity FSM_Tb is
end FSM_Tb;


architecture Stimulus of FSM_Tb is

	signal s_clk		:	std_logic;
	signal s_btn_P		:	std_logic;
	signal s_btn_S		:	std_logic;
	
	signal s_normalState		:	std_logic;
	signal s_acertMState		:	std_logic;
	signal s_acertHState		:	std_logic;
	signal s_selAcerOrProg	:	std_logic;
	signal s_SelStateProg	:	std_logic_vector(1 downto 0);
	signal s_proGelState		:	std_logic_vector(1 downto 0);
	signal s_proLuaState		:	std_logic_vector(1 downto 0);
	signal s_proSolState		:	std_logic_vector(1 downto 0);
	
	
	begin
	
		uut				:	entity work.FSM(Behavioral)
									port map( clk				=>	s_clk,
												 btn_P			=>	s_btn_P,
												 btn_S			=>	s_btn_S,
												 
												 selAcerOrProg	=>	s_selAcerOrProg,
												 SelStateProg	=>	s_SelStateProg,
												 normalState	=>	s_normalState,
												 acertMState	=> s_acertMState,
												 acertHState	=>	s_acertHState,
												 proGelState	=> s_proGelState,
												 proLuaState	=>	s_proLuaState,
												 proSolState	=> s_proSolState);
												 
		clk_proc	:	process
			begin
			
				s_clk	<=	'0';
					wait for 20 ns;
					s_clk	<=	'1';
					wait for 20 ns;
			end process;
			
			
			stim_proc	:	process
			begin	
				
				wait for 40 ns;
				s_btn_S	<= '1';
				wait for 40 ns;
				s_btn_S	<=	'0';
				wait for 20 ns;
				s_btn_S	<= '1';
				wait for 20 ns;
				s_btn_P	<= '1';
				wait for 20 ns;
				s_btn_P	<= '0';
				s_btn_S	<= '1';
				wait for 60 ns;
				s_btn_S	<= '0';
				wait for 20 ns;
				s_btn_P	<= '1';
				wait for 60 ns;
				s_btn_S	<= '1';
				s_btn_P	<= '0';
				wait for 40 ns;
				s_btn_S	<= '0';
				wait for 20 ns;
				s_btn_S	<=	'1';
				wait for 20 ns;
				s_btn_S	<= '0';
				wait for 20 ns;
				s_btn_P	<= '1';
				wait for 20 ns;
				s_btn_P	<= '0';
				wait for 100 ns;
		end process;
end Stimulus;