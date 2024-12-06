library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TrafficLightController_tb is
end TrafficLightController_tb;

architecture Behavioral of TrafficLightController_tb is

    -- Component Declaration
    component TrafficLightController
        Port (
            clk            : in  STD_LOGIC;
            reset          : in  STD_LOGIC;
            toggle         : in  STD_LOGIC;

            -- North
            red_north      : out STD_LOGIC;
            yellow_north   : out STD_LOGIC;
            green_north    : out STD_LOGIC;
            green_left_north : out STD_LOGIC;
            red_left_north : out STD_LOGIC;

            -- East
            red_east       : out STD_LOGIC;
            yellow_east    : out STD_LOGIC;
            green_east     : out STD_LOGIC;
            green_left_east : out STD_LOGIC;
            red_left_east  : out STD_LOGIC;

            -- South
            red_south      : out STD_LOGIC;
            yellow_south   : out STD_LOGIC;
            green_south    : out STD_LOGIC;
            green_left_south : out STD_LOGIC;
            red_left_south : out STD_LOGIC;

            -- West
            red_west       : out STD_LOGIC;
            yellow_west    : out STD_LOGIC;
            green_west     : out STD_LOGIC;
            green_left_west : out STD_LOGIC;
            red_left_west  : out STD_LOGIC
        );
    end component;

    -- Signals for Testbench
    signal clk            : STD_LOGIC := '0';
    signal reset          : STD_LOGIC := '0';
    signal toggle         : STD_LOGIC := '0';

    -- North Signals
    signal red_north      : STD_LOGIC;
    signal yellow_north   : STD_LOGIC;
    signal green_north    : STD_LOGIC;
    signal green_left_north : STD_LOGIC;
    signal red_left_north : STD_LOGIC;

    -- East Signals
    signal red_east       : STD_LOGIC;
    signal yellow_east    : STD_LOGIC;
    signal green_east     : STD_LOGIC;
    signal green_left_east : STD_LOGIC;
    signal red_left_east  : STD_LOGIC;

    -- South Signals
    signal red_south      : STD_LOGIC;
    signal yellow_south   : STD_LOGIC;
    signal green_south    : STD_LOGIC;
    signal green_left_south : STD_LOGIC;
    signal red_left_south : STD_LOGIC;

    -- West Signals
    signal red_west       : STD_LOGIC;
    signal yellow_west    : STD_LOGIC;
    signal green_west     : STD_LOGIC;
    signal green_left_west : STD_LOGIC;
    signal red_left_west  : STD_LOGIC;

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: TrafficLightController PORT MAP (
        clk            => clk,
        reset          => reset,
        toggle         => toggle,

        -- North
        red_north      => red_north,
        yellow_north   => yellow_north,
        green_north    => green_north,
        green_left_north => green_left_north,
        red_left_north => red_left_north,

        -- East
        red_east       => red_east,
        yellow_east    => yellow_east,
        green_east     => green_east,
        green_left_east => green_left_east,
        red_left_east  => red_left_east,

        -- South
        red_south      => red_south,
        yellow_south   => yellow_south,
        green_south    => green_south,
        green_left_south => green_left_south,
        red_left_south => red_left_south,

        -- West
        red_west       => red_west,
        yellow_west    => yellow_west,
        green_west     => green_west,
        green_left_west => green_left_west,
        red_left_west  => red_left_west
    );

    -- Clock process
    clk_process: process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Test full cycle through all directions
        for i in 0 to 3 loop 
            toggle <= '1'; 
            wait for CLK_PERIOD * 10; 
            wait for CLK_PERIOD * 2; 
        end loop;
    end process;

end Behavioral;