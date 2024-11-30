library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TrafficLightController is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        toggle   : in  STD_LOGIC;  -- Toggle input on/off
        red      : out STD_LOGIC;
        yellow   : out STD_LOGIC;
        green    : out STD_LOGIC;
        light_sel: out STD_LOGIC_VECTOR(1 downto 0)  -- Lampu mana yang nyala
    );
end TrafficLightController;

architecture Behavioral of TrafficLightController is

    type State_Type is (IDLE_STATE, RED_STATE, YELLOW_STATE, GREEN_STATE);
    signal current_state, next_state: State_Type;

    -- Buat bantu cek lampu mana yang nyala
    signal light_index : STD_LOGIC_VECTOR(1 downto 0) := "00";

    -- Timing counter
    signal counter : INTEGER range 0 to 50 := 0;

begin
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= IDLE_STATE;
            counter <= 0;
            light_index <= "00";
        elsif rising_edge(clk) then
            if toggle = '1' then
                current_state <= next_state;
                if current_state /= IDLE_STATE then
                    if counter = 50 then
                        counter <= 0;
                        light_index <= std_logic_vector(unsigned(light_index) + 1); -- Muter terus (Kalau udah '11', balik lagi ke '00')
                    else
                        counter <= counter + 1;
                    end if;
                end if;
            else
                current_state <= IDLE_STATE;
                counter <= 0;
            end if;
        end if;
    end process;

    process(current_state, toggle, counter)
    begin
        case current_state is
            when IDLE_STATE =>
                if toggle = '1' then
                    next_state <= RED_STATE;
                else
                    next_state <= IDLE_STATE;
                end if;

            when RED_STATE =>
                if counter = 50 then
                    next_state <= GREEN_STATE;
                else
                    next_state <= RED_STATE;
                end if;

            when GREEN_STATE =>
                if counter = 50 then
                    next_state <= YELLOW_STATE;
                else
                    next_state <= GREEN_STATE;
                end if;

            when YELLOW_STATE =>
                if counter = 50 then
                    next_state <= RED_STATE;
                else
                    next_state <= YELLOW_STATE;
                end if;

            when others =>
                next_state <= IDLE_STATE;
        end case;
    end process;

    process(current_state, light_index)
    begin
        -- Default
        red <= '0';
        yellow <= '0';
        green <= '0';
        light_sel <= light_index;

        case current_state is
            when IDLE_STATE =>
                red <= '0';
                yellow <= '0';
                green <= '0';

            when RED_STATE =>
                red <= '1';

            when GREEN_STATE =>
                green <= '1';

            when YELLOW_STATE =>
                yellow <= '1';

            when others =>
                red <= '0';
                yellow <= '0';
                green <= '0';
        end case;
    end process;

end Behavioral;

