-- Este componente é que define quando e o onde opera a operação blink


Library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity BlinkOperation is

	port( AcerH			:	in		std_logic;
			AcerM			:	in		std_logic;
			Blink			:	in		std_logic;
			
			outOperatM	:	out	std_logic;
			outOperatH	:	out	std_logic);
			
end BlinkOperation;


architecture Behavioral of BlinkOperation is

	begin
	
		process(AcerH, AcerM)
		
		begin
		
			if (AcerH = '1') then
				outOperatH	<= Blink;
				outOperatM	<= '1';
			elsif (AcerM = '1') then
				outOperatH	<= '1';
				outOperatM	<= Blink;
			else
				outOperatH	<= '1';
				outOperatM	<= '1';
			end if;
		end process;
				
		
		
end Behavioral;