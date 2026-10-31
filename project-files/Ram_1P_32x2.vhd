library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;



entity Ram_1P_32x2 is

	port( clk				:	in  std_logic;
			writeEn			:  in  std_logic;
			writeDt			:	in  std_logic_vector(1 downto 0);
			address			: 	in  std_logic_vector(4 downto 0);
			readAd			:  in  std_logic_vector(4 downto 0);
			
			LGel				:	out	std_logic;
			LLua				:	out	std_logic;
			LSol				:	out	std_logic;
			
			readDt			:	out std_logic_vector(1 downto 0));
			
end Ram_1P_32x2;

architecture Behavioral of Ram_1P_32x2 is

	constant NUM_WORDS	: Integer := 24;
	
	Subtype	TData		is std_logic_vector(1 downto 0);
	type		TRam		is array (0 to NUM_WORDS - 1) of TData;
	
	signal	s_memory : TRam := (
		0	=> "00",
		1	=> "00",
		2	=> "00",
		3	=> "00",
		4	=> "00",
		5	=> "01",
		6	=> "01",
		7	=> "10",
		8	=> "10",
		9	=> "10",
		10 => "10",
		11 => "10",
		12 => "10",
		13 => "10",
		14 => "10",
		15 => "10",
		16	=> "10",
		17	=> "10",
		18	=> "01",
		19	=> "01",
		20	=> "00",
		21 => "00",
		22 => "00",
		23 => "00");
		
	
	signal s_LGel, s_LLua, s_LSol	:	std_logic;
	
begin
	
	process(clk)
	
	begin
	
		if (rising_edge(clk))then
		
			s_LGel	<= '0';
			s_LLua	<=	'0';
			s_LSol	<=	'0';
		
			if(writeEn = '1') then
				
				s_memory(to_integer (unsigned (address))) <= writeDt;
				
				if (writeDt = "00") then
					s_LGel <= '1';
				elsif (writeDt = "01") then
					s_LLua	<= '1';
				elsif (writeDt = "10") then
					s_LSol	<=	'1';
				end if;
				
			else
				
				if (s_memory(to_integer(unsigned(readAd))) = "00") then
					s_LGEl <= '1';
				elsif (s_memory(to_integer(unsigned(readAd))) = "01") then
					s_LLua	<= '1';
				elsif ( s_memory(to_integer(unsigned(readAd))) = "10" ) then
					s_LSol	<= '1';
				end if;
				
			end if;
	
		end if;
	end process;
	
	readDt <= s_memory(to_integer(unsigned(readAd)));
	
	LGel	<=	s_LGel;
	LLua	<=	s_LLua;
	LSol	<=	s_LSol;

end Behavioral;