-- Gerador de Pulsos, gera 4 tipos de oulsos diferentes

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity pulse_gen is

port ( 	clk : in STD_LOGIC;
			acel	:	in	std_logic_vector(1 downto 0);
			pulse : out STD_LOGIC);

end pulse_gen;


architecture Behavioral of pulse_gen is

	signal s_div	:	unsigned(31 downto 0) := to_unsigned(50_000_000, 32);
	signal s_cnt 	:	unsigned(31 downto 0) := (others => '0');

begin

	process(clk)

	begin

		if (rising_edge(clk)) then
			pulse <= '0';
			if (s_cnt >= s_div) then
				s_cnt <= (others => '0');
			else
				
				case acel is
					when "01" => -- 60 pulsos por minuto
						 s_div <= to_unsigned(50_000_000, 32);
					when "10" => -- 600 pulsos por minuto
						 s_div <= to_unsigned(5_000_000, 32);
					when "11" => -- 3600 pulsos por minuto
						 s_div <= to_unsigned((50_000_000 / 60), 32);
					when others =>  -- 1 pulso por minuto
						 s_div <= to_unsigned(3_000_000_000, 32);
				end case;
			
				s_cnt <= s_cnt + 1;
				if (s_cnt = s_div-1) then
					s_cnt <= (others => '0');
					pulse <= '1';
				end if;
			end if;
		end if;
	end process;
	
	
end Behavioral;