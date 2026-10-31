-- Máquina de estados

Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


entity FSM is

	port( clk				:	in		std_logic;
			btn_P				:	in		std_logic;
			btn_S				:	in		std_logic;
			
			selAcerOrProg	:	out	std_logic; -- Selecionar quando está no modo de programação ou Acerto/Normal
			
			SelStateProg	:	out	std_logic_vector(1 downto 0);  -- Seleciona o nivel da temperatura a entrar na Ram
			
			normalState		:	out	std_logic; -- Estado Normal
			acertMState		:	out	std_logic; -- Estado Acerto Minutos
			acertHState		:	out	std_logic; -- Estado Acerto Horas
			proGelState		:	out	std_logic_vector(1 downto 0);  -- Estado programação do nivel anti congelamento;
			proLuaState		:	out	std_logic_vector(1 downto 0);  -- Estado programação do nivel economia;
			proSolState		:	out	std_logic_vector(1 downto 0)); -- Estado programação do nivel conforto.
			
	
end FSM;


architecture Behavioral of FSM is

	type TState is (ENormal, AcerH, AcerM, ProgGel, ProgLua, ProgSol);
	signal s_currentState, S_nextState	:	TState := ENormal;
	
	signal hora_D_atual, hora_U_atual, Min_D_atual, Min_U_atual	:	std_logic_vector(3 downto 0) := "0000";
	
	signal s_countUni	:	unsigned(3 downto 0) := "0000";
	signal s_countDez	:	unsigned(3 downto 0) := "0000";
	
	signal	s_PGel	:	std_logic	:= '1';
	signal	s_PLua	:	std_logic	:=	'0';
	signal	s_PSol	:	std_logic	:=	'0';
	
	signal	s_SelStateProg	:	std_logic_vector(1 downto 0);
	
	
	
	begin
	
		sync_proc	:	process(clk)
		
		begin
			
			if (rising_edge(clk)) then
					s_currentState <= S_nextState;
			end if;
		
		end process;
		
		
		comb_proc	:	process(s_currentState, btn_S, btn_P)
		
		begin	
		
			case (s_currentState) is
				
				-- Modo Normal
				when ENormal =>
					
					normalState <= '1';
					acertHState <= '0';
					acertMState	<= '0';
					proGelState	<= "00";
					proLuaState	<=	"00";
					proSolState <= "00";
					
					selAcerOrProg	<=	'0';  
					SelStateProg <= s_SelStateProg;
					
				
					-- Iniciar o novo estado
					
					if (btn_S = '1') then
						s_nextState <= AcerH;
					elsif (btn_P = '1')then
						s_nextState <= ProgGel;
					else
						s_nextState <= ENormal;
					end if;
				
				-- Modo de Acerto das Horas
				when AcerH =>
				
					normalState <= '0';
					acertHState <= '1';
					acertMState	<= '0';
					proGelState	<= "00";
					proLuaState	<=	"00";
					proSolState <= "00";
					
					selAcerOrProg	<=	'0';
					
					SelStateProg <= s_SelStateProg;
					
				
					-- Iniciar o novo estado
					if (btn_S = '1') then
						s_nextState <= AcerM;
					else
						s_nextState <= AcerH;
					end if;
						
				when AcerM =>
					normalState <= '0';
					acertHState <= '0';
					acertMState	<= '1';
					proGelState	<= "00";
					proLuaState	<=	"00";
					proSolState <= "00";
					
					selAcerOrProg	<=	'0';
					
					SelStateProg <= s_SelStateProg;
										
					--Iniciar o novo estado
					if (btn_S = '1') then
						s_nextState <= ENormal;
					else
						s_nextState <= AcerM;
					end if;					
					
				when ProgGel =>
				
					normalState <= '0';
					acertHState <= '0';
					acertMState	<= '0';
					proGelState	<= "00";
					proLuaState	<=	"00";
					proSolState <= "00";
					
					selAcerOrProg	<=	'1';
					
					s_SelStateProg <= "00";
					SelStateProg <= s_SelStateProg;
				
					
					--Iniciar o novo estado
					if (btn_S = '1') then
						s_nextState <= ProgLua;
					elsif (btn_P = '1') then
						s_nextState <= ENormal;
					else
						s_nextState <= ProgGel;
					end if;
					
				
				when ProgLua =>
				
					normalState <= '0';
					acertHState <= '0';
					acertMState	<= '0';
					proGelState	<= "00";
					proLuaState	<=	"01";
					proSolState <= "00";
					
					selAcerOrProg	<=	'1';
					
					s_SelStateProg <= "01";
					SelStateProg <= s_SelStateProg;
				
					
					-- Iniciar um novo estado
					if (btn_S = '1') then
						s_nextState <= ProgSol;
					elsif (btn_P = '1') then
						s_nextState <= ENormal;
					else
						s_nextState <= ProgLua;
					end if;
					
					
				when ProgSol => 
				
					normalState <= '0';
					acertHState <= '0';
					acertMState	<= '0';
					proGelState	<= "00";
					proLuaState	<=	"00";
					proSolState <= "10";
					
					selAcerOrProg	<=	'1';
					
					s_SelStateProg <= "10";
					SelStateProg <= s_SelStateProg;
				
					
					-- Iniciar um novo estado
					if (btn_S = '1') then
						s_nextState <= ProgGel;
					elsif (btn_P = '1') then
						s_nextState <= ENormal;
					else
						s_nextState <= ProgSol;
					end if;
				end case;
			
			end process;

end Behavioral;