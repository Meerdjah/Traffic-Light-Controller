library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TrafficLightController_tb is
end TrafficLightController_tb;

architecture Behavioral of TrafficLightController_tb is
    -- Component Declaration
    component TrafficLightController
        Port (
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            toggle   : in  STD_LOGIC;

            Pedestrian_button_north : in  STD_LOGIC;
            Pedestrian_button_east  : in  STD_LOGIC;
            Pedestrian_button_south : in  STD_LOGIC;
            Pedestrian_button_west  : in  STD_LOGIC;

            Timer   : in  STD_LOGIC_VECTOR(7 downto 0);

            red_north  : out STD_LOGIC;
            yellow_north: out STD_LOGIC;
            green_north: out STD_LOGIC;
            green_left_north : out STD_LOGIC;
            red_left_north   : out STD_LOGIC;

            green_pedestrian_north : out STD_LOGIC;
            red_pedestrian_north   : out STD_LOGIC;

            red_east   : out STD_LOGIC;
            yellow_east: out STD_LOGIC;
            green_east : out STD_LOGIC;
            green_left_east  : out STD_LOGIC;
            red_left_east    : out STD_LOGIC;

            green_pedestrian_east : out STD_LOGIC;
            red_pedestrian_east   : out STD_LOGIC;

            red_south  : out STD_LOGIC;
            yellow_south: out STD_LOGIC;
            green_south: out STD_LOGIC;
            green_left_south : out STD_LOGIC;
            red_left_south   : out STD_LOGIC;

            green_pedestrian_south : out STD_LOGIC;
            red_pedestrian_south   : out STD_LOGIC;

            red_west   : out STD_LOGIC;
            yellow_west: out STD_LOGIC;
            green_west : out STD_LOGIC;
            green_left_west  : out STD_LOGIC;
            red_left_west    : out STD_LOGIC;

            green_pedestrian_west : out STD_LOGIC;
            red_pedestrian_west   : out STD_LOGIC
        );
    end component;

    -- Signals for Inputs
    signal clk      : STD_LOGIC := '0';
    signal reset    : STD_LOGIC := '0';
    signal toggle   : STD_LOGIC := '0';

    signal Pedestrian_button_north : STD_LOGIC := '0';
    signal Pedestrian_button_east  : STD_LOGIC := '0';
    signal Pedestrian_button_south : STD_LOGIC := '0';
    signal Pedestrian_button_west  : STD_LOGIC := '0';

    signal Timer   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

    -- Signals for Outputs
    signal red_north, yellow_north, green_north : STD_LOGIC;
    signal green_left_north, red_left_north     : STD_LOGIC;

    signal green_pedestrian_north, red_pedestrian_north : STD_LOGIC;

    signal red_east, yellow_east, green_east : STD_LOGIC;
    signal green_left_east, red_left_east   : STD_LOGIC;

    signal green_pedestrian_east, red_pedestrian_east : STD_LOGIC;

    signal red_south, yellow_south, green_south : STD_LOGIC;
    signal green_left_south, red_left_south    : STD_LOGIC;

    signal green_pedestrian_south, red_pedestrian_south : STD_LOGIC;

    signal red_west, yellow_west, green_west : STD_LOGIC;
    signal green_left_west, red_left_west   : STD_LOGIC;

    signal green_pedestrian_west, red_pedestrian_west : STD_LOGIC;

begin
    -- Instantiate the Traffic Light Controller
    uut: TrafficLightController
        Port map (
            clk => clk,
            reset => reset,
            toggle => toggle,

            Pedestrian_button_north => Pedestrian_button_north,
            Pedestrian_button_east  => Pedestrian_button_east,
            Pedestrian_button_south => Pedestrian_button_south,
            Pedestrian_button_west  => Pedestrian_button_west,

            Timer => Timer,

            red_north => red_north,
            yellow_north => yellow_north,
            green_north => green_north,
            green_left_north => green_left_north,
            red_left_north => red_left_north,

            green_pedestrian_north => green_pedestrian_north,
            red_pedestrian_north => red_pedestrian_north,

            red_east => red_east,
            yellow_east => yellow_east,
            green_east => green_east,
            green_left_east => green_left_east,
            red_left_east => red_left_east,

            green_pedestrian_east => green_pedestrian_east,
            red_pedestrian_east => red_pedestrian_east,

            red_south => red_south,
            yellow_south => yellow_south,
            green_south => green_south,
            green_left_south => green_left_south,
            red_left_south => red_left_south,

            green_pedestrian_south => green_pedestrian_south,
            red_pedestrian_south => red_pedestrian_south,

            red_west => red_west,
            yellow_west => yellow_west,
            green_west => green_west,
            green_left_west => green_left_west,
            red_left_west => red_left_west,

            green_pedestrian_west => green_pedestrian_west,
            red_pedestrian_west => red_pedestrian_west
        );

    -- Clock Generation
    clk_process: process
    begin
        while True loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
    end process;

    -- Stimulus Process
    stimulus: process
    begin
        -- Reset the system
        reset <= '1';
        wait for 50 ns;
        reset <= '0';

        -- Enable toggle to start system
        toggle <= '1';
        Timer <= "00001111"; -- Timer set to 15 clock cycles

        -- Simulate pedestrian button press
        wait for 100 ns;
        Pedestrian_button_north <= '1';
        wait for 50 ns;
        Pedestrian_button_north <= '0';

        -- Simulate pedestrian button press for east
        wait for 200 ns;
        Pedestrian_button_east <= '1';
        wait for 50 ns;
        Pedestrian_button_east <= '0';

        -- Simulate pedestrian button press for south
        wait for 200 ns;
        Pedestrian_button_south <= '1';
        wait for 50 ns;
        Pedestrian_button_south <= '0';

        -- Simulate pedestrian button press for west
        wait for 200 ns;
        Pedestrian_button_west <= '1';
        wait for 50 ns;
        Pedestrian_button_west <= '0';

        -- Stop the toggle
        wait for 500 ns;
        toggle <= '0';

        wait;
    end process;
end Behavioral;

