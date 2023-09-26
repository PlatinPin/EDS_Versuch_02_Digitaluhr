library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all; 
USE ieee.numeric_std.ALL;

entity mod_N_Zaehler is
    generic(
        nbit : integer := 4;
        max_count : integer :=10
    );
    Port(
        clk : in std_logic;
        set : in std_logic;
        y : out std_logic_vector(nbit-1 downto 0);
        ov : out std_logic :='0'
    );
end mod_N_Zaehler;

architecture arch_of_mod_N_Zaehler of mod_N_Zaehler is
    signal count : std_logic_vector(nbit-1 downto 0):=(others => '0');
    signal internal_ov : std_logic :='0';
begin
    process(clk)
        begin
            if(rising_edge(clk)) then
                count <= count +1;
                ov <='0';
                if( to_integer(unsigned(count))= max_count) then
                    ov <= '1';
                    count <= (others => '0');
                end if;
            end if;
            --if( to_integer(unsigned(count))= max_count) then
              --  ov <= '1';
                --count <= (others => '0');
           -- end if;
    end process;
    
    process(set)
        begin
            if (set='1') then
                count <= count+1;
                if( to_integer(unsigned(count))= max_count) then
                    ov <= '1';
                    count <= (others => '0');
                end if;
           end if;
    end process;

    
    y <= count;

end arch_of_mod_N_Zaehler;
