library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Digi_clock_controll is
    generic(
        freq_teil : std_logic_vector(13 downto 0) := "00000000000010";
        g_NN_main : integer := 32;
        len_kette_main : integer := 6;
        nbit1_main : integer := 4;
        nbit2_main : integer := 4;
        max_count1_main : integer := 9;
        max_count2_main : integer := 6
    );
    Port(
        clk_top_main : in std_logic;
        set_main : in std_logic_vector(5 downto 0);
        enable_0 : in std_logic;
        AN : out std_logic_vector(7 downto 0);
        C : out std_logic_vector(7 downto 0)
    );
end Digi_clock_controll;

architecture arch_of_Digi_clock_controll of Digi_clock_controll is
    component Freq_Teiler
        generic(
                g_NN : integer := 32; --Bit Anzahl fuer Counter-Signal
                teiler : std_logic_vector(13 downto 0) := "00000000000010" --Um welchen Faktor Freq. geteilt werden soll.
        );
        Port(
                clk_in : in std_logic; -- Input fuer das Eingangstakt-Signal
                enable : in std_logic; -- Freq. Teiler ein- oder Ausschalten
                clk_out : out std_logic :='0' -- Ausgangstakt-Signal mit dem Anfangswert '0'
        );
    end component;
    
    component zaehler_kette
        generic(
                len_kette : integer := 6;
                nbit1 : integer :=4;
                nbit2 : integer :=4;
                max_count1 : integer :=9;
                max_count2 : integer :=6
        );
        Port(
                clk_toplvl : in std_logic;
                A1 : out std_logic_vector(nbit1-1 downto 0);
                A2 : out std_logic_vector(nbit2-1 downto 0);
        
                A3 : out std_logic_vector(nbit1-1 downto 0);
                A4 : out std_logic_vector(nbit2-1 downto 0);
        
                A5 : out std_logic_vector(nbit1-1 downto 0);
                A6 : out std_logic_vector(nbit2-1 downto 0);
        
                set_toplvl : in std_logic_vector(len_kette-1 downto 0)
        );
    end component;
    
    component seven_segment_steuerung
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
    end component;
    
    signal internal_clk : std_logic_vector(1 downto 0);
    signal internal_enable : std_logic;
  
    
    signal internal_A1 : std_logic_vector(nbit1_main-1 downto 0);
    signal internal_A2 : std_logic_vector(nbit1_main-1 downto 0);
    signal internal_A3 : std_logic_vector(nbit1_main-1 downto 0);
    signal internal_A4 : std_logic_vector(nbit1_main-1 downto 0);
    signal internal_A5 : std_logic_vector(nbit1_main-1 downto 0);
    signal internal_A6 : std_logic_vector(nbit1_main-1 downto 0);
    
begin

    F0: Freq_Teiler generic map(g_NN_main,freq_teil) port map(clk_in=>clk_top_main,enable => enable_0,clk_out=>internal_clk(0));

    F1: Freq_Teiler generic map(g_NN_main,freq_teil) port map(clk_in=>internal_clk(0),enable=>internal_enable,clk_out=>internal_clk(1));

    Z0: zaehler_kette generic map(len_kette_main,nbit1_main,nbit2_main,max_count1_main,max_count2_main) port map(clk_toplvl=>internal_clk(1),set_toplvl=>set_main,A1=>internal_A1,A2=>internal_A2,A3=>internal_A3,A4=>internal_A4,A5=>internal_A5,A6=>internal_A6);

    Seg0: seven_segment_steuerung port map(number_s_i=>internal_A1,number_10s_i=>internal_A2,number_m_i=>internal_A3,number_10m_i=>internal_A4,number_h_i=>internal_A5,number_10h_i=>internal_A6,clk_i=>internal_clk(0),position_o=>AN,number_out_o=>C);

    

end arch_of_Digi_clock_controll;
