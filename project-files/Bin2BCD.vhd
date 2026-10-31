-- Conversor binário para 2 bcd

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Bin2BCD is
    port (
        binInput : in std_logic_vector(4 downto 0);
        output0 : out std_logic_vector(3 downto 0);
        output1 : out std_logic_vector(3 downto 0)
    );
end Bin2BCD;

architecture Behavioral of Bin2BCD is
    signal s_input : unsigned(4 downto 0);
	 signal s_output0, s_output1 : unsigned(3 downto 0);
begin
    s_input <= unsigned(binInput);

    process(s_input)
    begin
        case s_input is
            when "00000" =>
                s_output0 <= "0000";
                s_output1 <= "0000";
            when "00001" =>
                s_output0 <= "0001";
                s_output1 <= "0000";
            when "00010" =>
                s_output0 <= "0010";
                s_output1 <= "0000";
            when "00011" =>
                s_output0 <= "0011";
                s_output1 <= "0000";
            when "00100" =>
                s_output0 <= "0100";
                s_output1 <= "0000";
            when "00101" =>
                s_output0 <= "0101";
                s_output1 <= "0000";
            when "00110" =>
                s_output0 <= "0110";
                s_output1 <= "0000";
            when "00111" =>
                s_output0 <= "0111";
                s_output1 <= "0000";
            when "01000" =>
                s_output0 <= "1000";
                s_output1 <= "0000";
            when "01001" =>
                s_output0 <= "1001";
                s_output1 <= "0000";
            when "01010" =>
                s_output0 <= "0000";
                s_output1 <= "0001";
            when "01011" =>
                s_output0 <= "0001";
                s_output1 <= "0001";
            when "01100" =>
                s_output0 <= "0010";
                s_output1 <= "0001";
            when "01101" =>
                s_output0 <= "0011";
                s_output1 <= "0001";
            when "01110" =>
                s_output0 <= "0100";
                s_output1 <= "0001";
            when "01111" =>
                s_output0 <= "0101";
                s_output1 <= "0001";
            when "10000" =>
                s_output0 <= "0110";
                s_output1 <= "0001";
				when "10001" =>
					 s_output0 <= "0111";
                s_output1 <= "0001";
				when "10010" =>
					 s_output0 <= "1000";
                s_output1 <= "0001";
				when "10011" =>
					 s_output0 <= "1001";
                s_output1 <= "0001";
				when "10100" =>
					 s_output0 <= "0000";
                s_output1 <= "0010";
				when "10101" =>
					 s_output0 <= "0001";
                s_output1 <= "0010";
				when "10110" =>
					 s_output0 <= "0010";
                s_output1 <= "0010";
				when "10111" =>
					 s_output0 <= "0011";
                s_output1 <= "0010";
            when others =>
                s_output0 <= "0000";
                s_output1 <= "0000";
        end case;
    end process;

    output0 <= std_logic_vector(s_output0(3 downto 0));
    output1 <= std_logic_vector(s_output1(3 downto 0));
end Behavioral;
