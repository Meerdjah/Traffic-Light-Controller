library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TrafficLightController_tb is
-- Testbench tidak memiliki port
end TrafficLightController_tb;

architecture Behavioral of TrafficLightController_tb is
    -- Komponen yang akan diuji
    component TrafficLightController
        Port (
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            toggle   : in  STD_LOGIC;
            red      : out STD_LOGIC;
            yellow   : out STD_LOGIC;
            green    : out STD_LOGIC;
            light_sel: out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    -- Sinyal untuk menghubungkan testbench ke UUT
    signal clk_tb      : STD_LOGIC := '0';
    signal reset_tb    : STD_LOGIC := '0';
    signal toggle_tb   : STD_LOGIC := '0';
    signal red_tb      : STD_LOGIC;
    signal yellow_tb   : STD_LOGIC;
    signal green_tb    : STD_LOGIC;
    signal light_sel_tb: STD_LOGIC_VECTOR(1 downto 0);

    -- Clock period untuk simulasi
    constant clk_period : time := 1 ps;

begin
    -- Instansiasi UUT
    UUT: TrafficLightController
        Port map (
            clk      => clk_tb,
            reset    => reset_tb,
            toggle   => toggle_tb,
            red      => red_tb,
            yellow   => yellow_tb,
            green    => green_tb,
            light_sel=> light_sel_tb
        );

    -- Clock generator
    clk_process: process
    begin
        while True loop
            clk_tb <= '0';
            wait for clk_period / 2;
            clk_tb <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process untuk memberikan input
    stimulus_process: process
    begin
        -- Reset sistem
        reset_tb <= '1';
        wait for clk_period * 2;  -- Tunggu 2 clock cycle
        reset_tb <= '0';

        -- Aktifkan toggle untuk memulai siklus lampu lalu lintas
        toggle_tb <= '1';
        wait for clk_period * 40; -- Tunggu untuk beberapa siklus lampu lalu lintas

        -- Nonaktifkan toggle (lampu berhenti)
        toggle_tb <= '0';
        wait for clk_period * 20;  -- Tunggu beberapa waktu

        -- Aktifkan kembali toggle
        toggle_tb <= '1';
        wait for clk_period * 40; -- Tunggu untuk beberapa siklus lampu lalu lintas

        -- Akhiri simulasi
        wait;
    end process;
end Behavioral;
