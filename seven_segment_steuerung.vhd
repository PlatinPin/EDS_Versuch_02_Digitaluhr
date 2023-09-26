library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.std_logic_unsigned.ALL;


entity seven_segment_steuerung is
    Port(
        number_s_i : in std_logic_vector(3 downto 0);
        number_10s_i : in std_logic_vector(3 downto 0);
        number_m_i : in std_logic_vector(3 downto 0);
        number_10m_i : in std_logic_vector(3 downto 0);
        number_h_i : in std_logic_vector(3 downto 0);
        number_10h_i : in std_logic_vector(3 downto 0);
        clk_i : in std_logic;
        position_o : out std_logic_vector(7 downto 0);
        number_out_o : out std_logic_vector(7 downto 0) 
    );
end seven_segment_steuerung;

architecture arch_of_segment_steurung of seven_segment_steuerung is
    type ram_type is array(9 downto 0) of std_logic_vector(7 downto 0);
    constant c_ANZEIGE : ram_type := (x"90",x"80",x"f8",x"82",x"92",x"99",x"B0",x"a4",x"f9",x"C0");
    signal b : integer := 0;
begin
    seg : process(clk_i)
        begin
            if (rising_edge(clk_i)) then
                if (b=0) then
                    position_o <= x"fe"; number_out_o <= c_ANZEIGE(conv_integer(number_s_i));
                end if;
                if (b=1) then
                    position_o <= x"fd"; number_out_o <= c_ANZEIGE(conv_integer(number_10s_i));
                end if;
                if (b=2) then
                    position_o <= x"fb"; number_out_o <= c_ANZEIGE(conv_integer(number_m_i));
                end if;
                if (b=3) then
                    position_o <= x"f7"; number_out_o <= c_ANZEIGE(conv_integer(number_10m_i));
                end if;
                if (b=4) then
                    position_o <= x"ef"; number_out_o <= c_ANZEIGE(conv_integer(number_h_i));
                end if;
                if (b=5) then
                    position_o <= x"df"; number_out_o <= c_ANZEIGE(conv_integer(number_10h_i));
                end if;
                if (b=6) then
                    position_o <= x"bf"; number_out_o <= c_ANZEIGE(0);
                end if;
                if (b=7) then
                    position_o <= x"7f"; number_out_o <= c_ANZEIGE(0);
                end if;
                b <= (b+1) mod 8;
              end if;
            end process;

end arch_of_segment_steurung;
