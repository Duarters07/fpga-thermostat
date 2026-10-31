-- Este componente é que define que formato é impresso nos displays.(ou modo normal, ou Acerto das horas/minutos)

library ieee;
use ieee.std_logic_1164.all;

entity RelogioControler is

    port(
			clk               : in std_logic;
			EstadoH           : in std_logic;
			EstadoM				: in std_logic;
			EstadoNormal		: in std_logic;
			
			H_horas_Dez			:	in 	std_logic_vector(3 downto 0);
			H_horas_Uni			:	in		std_logic_vector(3 downto 0);
			M_Min_Dez         :	in		std_logic_vector(3 downto 0);
			M_Min_Uni			:	in		std_logic_vector(3 downto 0);
			clk_Min_Dez			:	in		std_logic_vector(3 downto 0);
			clk_Min_Uni 	   : 	in 	std_logic_vector(3 downto 0);
			clk_Hora_Dez		:	in		std_logic_vector(3 downto 0);
			clk_Hora_Uni		:	in		std_logic_vector(3 downto 0);
				
			h_Dez					:	out	std_logic_vector(3 downto 0);
			h_Uni					:	out	std_logic_vector(3 downto 0);
			M_Dez					:	out	std_logic_vector(3 downto 0);
			M_Uni					:	out	std_logic_vector(3 downto 0));	
			
end RelogioControler;

architecture Behavioral of RelogioControler is

	signal tempHDez, tempHUni	:	std_logic_vector(3 downto 0);

	begin
	
		process(clk)
		
		begin
		
			if (rising_edge(clk)) then
			
				if (EstadoH = '1') then
					h_Dez	<= H_horas_Dez;
					h_Uni	<=	H_horas_Uni;
					
					M_Dez <= "0000";
					M_Uni	<= "0000";
					
					tempHDez <= H_horas_Dez;
					tempHUni	<= H_horas_Uni;
				
				elsif (EstadoM = '1') then
					h_Dez <= tempHDez;
					h_Uni <=	tempHUni;
					
					M_Dez <= M_Min_Dez;
					M_Uni	<= M_Min_Uni;
				
				elsif (EstadoNormal = '1') then
					
					h_Dez	<= clk_Hora_Dez;
					h_Uni	<=	clk_Hora_Uni;
					
					M_Dez <= clk_Min_Dez;
					M_Uni	<=	clk_Min_Uni;
				
				end if;
			end if;
				
		end process;

end Behavioral;
