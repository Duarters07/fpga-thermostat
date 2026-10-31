-- Controlo on off do radiador

library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity Controler_On_Off is

    port (clk			:	in		std_logic;
			 enable		:	in		std_logic;
          TRef			: 	in  	std_logic_vector(1 downto 0);
          TH        	: 	in  	std_logic_vector(8 downto 0);
			 
          LedOut		:	out 	std_logic;      
          OutP    	: 	out 	std_logic);
                
end Controler_On_Off;


architecture Behavioral of Controler_On_Off is

    signal s_EA    : std_logic := '0';
	 
	begin 
   
		process(clk)
			
			begin
			
				if (rising_edge(clk)) then
					if (enable = '1') then
				
						if (TRef = "00") then
							if (TH >= "000110001") then 
								 s_EA <= '0';        
							elsif (TH <= "000011111") then
								 s_EA <= '1';
							end if;
						elsif(TRef = "01") then
							if (TH >= "010101110") then
								 s_EA <= '0';
							elsif (TH <= "010010010") then
								 s_EA <= '1';
							end if;    
						elsif (TRef = "10") then
							if (TH >= "011011011") then
								 s_EA <= '0';
							elsif (TH <= "010110101") then
								 s_EA <= '1';
							end if;
						end if;
					end if;
				end if;
    end process;
    OutP <= s_EA;
	 LedOut	<= s_EA;
    
end Behavioral;
		
			