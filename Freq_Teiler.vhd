-- VHDL-Beschreibung fuer einen Variablen Frequenzteiler.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all; 


entity Freq_Teiler is
    generic(
        g_NN : integer := 32; --Bit Anzahl fuer Counter-Signal
        teiler : std_logic_vector(13 downto 0) := "00000000000010" --Um welchen Faktor Freq. geteilt werden soll.
    );
    port(
        clk_in : in std_logic; -- Input fuer das Eingangstakt-Signal
        enable : in std_logic; -- Freq. Teiler ein- oder Ausschalten
        clk_out : out std_logic :='0' -- Ausgangstakt-Signal mit dem Anfangswert '0'
    );
end Freq_Teiler;

architecture arch_of_freq_teiler of Freq_Teiler is
    signal count : std_logic_vector(g_NN-1 downto 0) :=(others => '0');
    signal cout : std_logic :='0';
begin
    process(clk_in)
        begin
            if(enable = '1') then -- Wenn Freq. Teiler eingeschaltet ist...
                if(rising_edge(clk_in)) then -- Bei Steigender Taktflanke des Eingangstakts
                    count <= count +1; -- Counter um 1 erhoehen
                end if;
                if(count = teiler) then -- Wenn Counter gleich Teilungsfaktor ist...
                    clk_out <= not cout; -- Signal cout Initalisiert mit '0' negieren.
                    cout <= not cout; -- Signal gleichzeitig Negieren.
                    count <= "00000000000000000000000000000000"; -- Counter auf 0 zuruecksetzten
                end if;
            elsif(enable='0') then -- Wenn Freq. Teiler Ausgeschaltet ist
                clk_out <= '0'; -- Ausgangstakt '0'
            end if;
    end process;


end arch_of_freq_teiler;
