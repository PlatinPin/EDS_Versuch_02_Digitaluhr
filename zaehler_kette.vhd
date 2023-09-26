library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity zaehler_kette is
    generic(
        len_kette : integer := 6;
        nbit1 : integer :=4;
        nbit2 : integer :=4;
        max_count1 : integer :=9;
        max_count2 : integer :=6
    );
    port(
        clk_toplvl : in std_logic;
        A1 : out std_logic_vector(nbit1-1 downto 0);
        A2 : out std_logic_vector(nbit2-1 downto 0);
        
        A3 : out std_logic_vector(nbit1-1 downto 0);
        A4 : out std_logic_vector(nbit2-1 downto 0);
        
        A5 : out std_logic_vector(nbit1-1 downto 0);
        A6 : out std_logic_vector(nbit2-1 downto 0);
        
        set_toplvl : in std_logic_vector(len_kette-1 downto 0)
    );
end zaehler_kette;

architecture arch_of_zaehler_kette of zaehler_kette is
    component mod_N_Zaehler
        generic(
            nbit : integer := 3;
            max_count : integer :=6
        );
        Port(
                clk : in std_logic;
                set : in std_logic;
                y : out std_logic_vector(nbit-1 downto 0);
                ov : out std_logic :='0'
        );
    end component;
   
    signal internal_clk : std_logic_vector(len_kette-2 downto 0);
    
begin

    U0: mod_N_Zaehler generic map(nbit1,max_count1) port map(clk=>clk_toplvl,set=>set_toplvl(0),y=>A1,ov=>internal_clk(0)); 
    U1: mod_N_Zaehler generic map(nbit2,max_count2) port map(clk=>internal_clk(0),set=>set_toplvl(1),y=>A2,ov=>internal_clk(1));
    
    U2: mod_N_Zaehler generic map(nbit1,max_count1) port map(clk=>internal_clk(1),set=>set_toplvl(2),y=>A3,ov=>internal_clk(2));
    U3: mod_N_Zaehler generic map(nbit2,max_count2) port map(clk=>internal_clk(2),set=>set_toplvl(3),y=>A4,ov=>internal_clk(3));
    
    U4: mod_N_Zaehler generic map(nbit1,max_count1) port map(clk=>internal_clk(3),set=>set_toplvl(3),y=>A5,ov=>internal_clk(4));
    U5: mod_N_Zaehler generic map(nbit2,max_count2) port map(clk=>internal_clk(4),set=>set_toplvl(4),y=>A6);

end arch_of_zaehler_kette;
