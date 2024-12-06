library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TrafficLightController is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        toggle   : in  STD_LOGIC;
        red      : out STD_LOGIC;
        yellow   : out STD_LOGIC;
        green    : out STD_LOGIC;
        light_sel: out STD_LOGIC_VECTOR(1 downto 0)
    );
end TrafficLightController;

architecture Behavioral of TrafficLightController is

    type State_Type is (IDLE_STATE, RED_STATE, YELLOW_STATE, GREEN_STATE);
    signal current_state, next_state: State_Type;

    signal light_index : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal counter : INTEGER range 0 to 1 := 0;

begin
    -- Proses utama untuk transisi state dan perubahan arah
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= IDLE_STATE;
            counter <= 0;
            light_index <= "00";
        elsif rising_edge(clk) then
            if toggle = '1' then
                if counter = 1 then
                    counter <= 0;
                    current_state <= next_state;

                    -- Pergantian arah setelah siklus penuh
                    if current_state = GREEN_STATE and next_state = RED_STATE then
                        light_index <= std_logic_vector(unsigned(light_index) + 1);
                    end if;
                else
                    counter <= counter + 1;
                end if;
            else
                current_state <= IDLE_STATE;
                counter <= 0;
            end if;
        end if;
    end process;

    -- Proses untuk transisi state
    process(current_state)
    begin
        case current_state is
            when IDLE_STATE =>
                if toggle = '1' then
                    next_state <= RED_STATE;
                else
                    next_state <= IDLE_STATE;
                end if;

            when RED_STATE =>
                next_state <= YELLOW_STATE;

            when YELLOW_STATE =>
                next_state <= GREEN_STATE;

            when GREEN_STATE =>
                next_state <= RED_STATE;

            when others =>
                next_state <= IDLE_STATE;
        end case;
    end process;

    -- Output logic
    process(current_state, light_index)
    begin
        -- Default semua merah
        red <= '1';
        yellow <= '0';
        green <= '0';
        light_sel <= light_index;

        -- Lampu untuk arah yang aktif
        case light_index is
            when "00" => -- Utara
                if current_state = GREEN_STATE then
                    red <= '0';
                    green <= '1';
                elsif current_state = YELLOW_STATE then
                    red <= '0';
                    yellow <= '1';
                end if;

            when "01" => -- Timur
                if current_state = GREEN_STATE then
                    red <= '0';
                    green <= '1';
                elsif current_state = YELLOW_STATE then
                    red <= '0';
                    yellow <= '1';
                end if;

            when "10" => -- Selatan
                if current_state = GREEN_STATE then
                    red <= '0';
                    green <= '1';
                elsif current_state = YELLOW_STATE then
                    red <= '0';
                    yellow <= '1';
                end if;

            when "11" => -- Barat
                if current_state = GREEN_STATE then
                    red <= '0';
                    green <= '1';
                elsif current_state = YELLOW_STATE then
                    red <= '0';
                    yellow <= '1';
                end if;

            when others =>
                red <= '1';
                yellow <= '0';
                green <= '0';
        end case;
    end process;
end Behavioral;