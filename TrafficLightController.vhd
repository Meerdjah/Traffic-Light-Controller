architecture Behavioral of TrafficLightController is

    type State_Type is (IDLE_STATE, RED_STATE, YELLOW_STATE, GREEN_STATE, PEDESTRIAN_STATE);
    signal previous_state, current_state, next_state: State_Type;

    signal light_index : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal counter : INTEGER range 0 to 1 := 0;

    -- Timer for pedestrian green light
    signal pedestrian_timer : INTEGER range 0 to 255 := 0; -- Max duration for pedestrian light (in clock cycles)

begin
    -- Proses utama untuk transisi state dan perubahan arah
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= IDLE_STATE;
            previous_state <= IDLE_STATE;
            counter <= 0;
            light_index <= "00";
            pedestrian_timer <= 0;
        elsif rising_edge(clk) then
            if toggle = '1' then
                if counter = 1 then
                    counter <= 0;
                    previous_state <= current_state; -- menyimpan state sebelumnya
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
                previous_state <= IDLE_STATE;
                counter <= 0;
            end if;
        end if;
    end process;

    -- Proses untuk transisi state
    process(previous_state, current_state, Pedestrian_button_north, Pedestrian_button_south, Pedestrian_button_west, Pedestrian_button_east, Timer)
    begin
        case current_state is
            when IDLE_STATE =>
                if toggle = '1' then
                    next_state <= RED_STATE;
                else
                    next_state <= IDLE_STATE;
                end if;

            when RED_STATE =>
                -- Jika tombol pedestrian ditekan, masuk ke state pedestrian
                if Pedestrian_button_north = '1' then
                    next_state <= PEDESTRIAN_STATE;
                elsif Pedestrian_button_south = '1' then
                    next_state <= PEDESTRIAN_STATE;
                elsif Pedestrian_button_west = '1' then
                    next_state <= PEDESTRIAN_STATE;
                elsif Pedestrian_button_east = '1' then
                    next_state <= PEDESTRIAN_STATE;
                else
                    next_state <= YELLOW_STATE;
                end if;

            when YELLOW_STATE =>
                if previous_state = RED_STATE then
                    next_state <= GREEN_STATE;
                else
                    next_state <= RED_STATE;
                end if;

            when GREEN_STATE =>
                next_state <= YELLOW_STATE;

            when PEDESTRIAN_STATE =>
                -- Timer untuk pedestrian hanya diatur di sini
                pedestrian_timer <= to_integer(unsigned(Timer)); -- Mengambil nilai dari input Timer
                if pedestrian_timer = 0 then
                    next_state <= RED_STATE; -- Kembali ke RED state setelah pedestrian selesai
                end if;

            when others =>
                next_state <= IDLE_STATE;
        end case;
    end process;

    -- Output logic
    process(current_state, light_index, Pedestrian_button_north, Pedestrian_button_south, Pedestrian_button_west, Pedestrian_button_east)
    begin
        -- Default semua lampu merah
        red_north <= '1'; yellow_north <= '0'; green_north <= '0';
        red_east  <= '1'; yellow_east  <= '0'; green_east  <= '0';
        red_south <= '1'; yellow_south <= '0'; green_south <= '0';
        red_west  <= '1'; yellow_west  <= '0'; green_west  <= '0';

        -- Default semua lampu belok kiri
        green_left_north <= '0'; red_left_north  <= '1';
        green_left_east  <= '0'; red_left_east   <= '1';
        green_left_south <= '0'; red_left_south  <= '1';
        green_left_west  <= '0'; red_left_west  <= '1';

        -- Default lampu pedestrian merah
        pedestrian_red_north <= '1'; pedestrian_green_north <= '0';
        pedestrian_red_east  <= '1'; pedestrian_green_east  <= '0';
        pedestrian_red_south <= '1'; pedestrian_green_south <= '0';
        pedestrian_red_west  <= '1'; pedestrian_green_west  <= '0';

        -- Logika untuk lampu pedestrian green
        if Pedestrian_button_north = '1' then
            pedestrian_green_north <= '1';
            pedestrian_red_north <= '0';
        end if;

        if Pedestrian_button_east = '1' then
            pedestrian_green_east <= '1';
            pedestrian_red_east <= '0';
        end if;

        if Pedestrian_button_south = '1' then
            pedestrian_green_south <= '1';
            pedestrian_red_south <= '0';
        end if;

        if Pedestrian_button_west = '1' then
            pedestrian_green_west <= '1';
            pedestrian_red_west <= '0';
        end if;

        -- Lampu untuk arah yang aktif
        case light_index is
            when "00" => -- Utara
                if current_state = GREEN_STATE then
                    red_north <= '0'; green_north <= '1';
                    green_left_north <= '1'; red_left_north <= '0';
                elsif current_state = YELLOW_STATE then
                    red_north <= '0'; yellow_north <= '1';
                end if;

            when "01" => -- Timur
                if current_state = GREEN_STATE then
                    red_east <= '0'; green_east <= '1';
                    green_left_east  <= '1'; red_left_east  <= '0';
                elsif current_state = YELLOW_STATE then
                    red_east <= '0'; yellow_east <= '1';
                end if;

            when "10" => -- Selatan
                if current_state = GREEN_STATE then
                    red_south <= '0'; green_south <= '1';
                    green_left_south <= '1'; red_left_south <= '0';
                elsif current_state = YELLOW_STATE then
                    red_south <= '0'; yellow_south <= '1';
                end if;

            when "11" => -- Barat
                if current_state = GREEN_STATE then
                    red_west <= '0'; green_west <= '1';
                    green_left_west  <= '1'; red_left_west  <= '0';
                elsif current_state = YELLOW_STATE then
                    red_west <= '0'; yellow_west <= '1';
                end if;

            when others =>
                red_north <= '1'; yellow_north <= '0'; green_north <= '0';
                red_east  <= '1'; yellow_east  <= '0'; green_east  <= '0';
                red_south <= '1'; yellow_south <= '0'; green_south <= '0';
                red_west  <= '1'; yellow_west  <= '0'; green_west  <= '0';

                green_left_north <= '0'; red_left_north  <= '1';
                green_left_east  <= '0'; red_left_east   <= '1';
                green_left_south <= '0'; red_left_south  <= '1';
                green_left_west  <= '0'; red_left_west  <= '1';
        end case;
    end process;
end Behavioral;