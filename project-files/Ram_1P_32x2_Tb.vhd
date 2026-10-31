-- Validação da Ram

Library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity Ram_1P_32x2_Tb is
end Ram_1P_32x2_Tb;


architecture Stimulus of Ram_1P_32x2_Tb is

	signal s_clk			:	std_logic;
	signal s_writeEn		:	std_logic;
	signal s_writeDt		:	std_logic_vector(1 downto 0);
	signal s_address		:	std_logic_vector(4 downto 0);
	signal s_readAd		:	std_logic_vector(4 downto 0);
	
	signal s_LGel			:	std_logic;
	signal s_LLua			:	std_logic;
	signal s_LSol			:	std_logic;
	signal s_readDt		:	std_logic_vector(1 downto 0);
	
	
	begin
	
		Ram				:	entity work.Ram_1P_32x2(Behavioral)
									port map( clk			=>	s_clk,
												 writeEn		=> s_writeEn,
												 writeDt		=>	s_writeDt,
												 address		=>	s_address,
												 readAd		=>	s_readAd,
												 
												 LGel			=>	s_LGel,
												 LLua			=>	s_LLua,
												 LSol			=> s_LSol,
												 readDt		=>	s_readDt);
												 
		clk_proc	:	process
			begin
			
				s_clk	<=	'0';
					wait for 20 ns;
					s_clk	<=	'1';
					wait for 20 ns;
			end process;
			
			
			stim_proc	:	process
			begin	
				
				s_writeEn	<=	'1';
				wait for 20 ns;
				s_writeDt		<= "00";
				s_address	<=	"00000";
				wait for 20 ns;
				s_writeDt		<= "00";
				s_address	<=	"00001";
				wait for 20 ns;
				s_writeDt		<= "01";
				s_address	<=	"00010";
				wait for 20 ns;
				s_writeDt		<= "01";
				s_address	<=	"00011";
				wait for 20 ns;
				s_writeDt		<= "10";
				s_address	<=	"00100";
				wait for 20 ns;
				s_writeDt		<= "10";
				s_address	<=	"00101";
				wait for 20 ns;
				s_writeEn	<= '0';
				s_readAd		<= "00000";
				wait for 20 ns;
				s_readAd		<= "00001";
				wait for 20 ns;
				s_readAd		<= "00010";
				wait for 20 ns;
				s_readAd		<= "00011";
				wait for 20 ns;
				s_readAd		<= "00100";
				wait for 20 ns;
				s_readAd		<= "00101";
				wait for 100 ns;
		end process;
end Stimulus;