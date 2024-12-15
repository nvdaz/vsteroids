library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ship is
	port(
		clk : in std_logic;
		-- ctrl inputs
		is_p1 : in std_logic;
		up_in : in std_logic;
		reset : in std_logic;
		down_in : in std_logic;
		left_in : in std_logic;
		right_in : in std_logic;
		-- position
		ship_x, ship_y : out unsigned(13 downto 0);
		ship_rot : out unsigned(5 downto 0)
	);
end;



-- 0 to 7 = starting from North counterclockwise
architecture synth of ship is

    signal x_position, y_position : unsigned(13 downto 0);
    signal rotation : unsigned(5 downto 0);

    signal x_vel, y_vel : signed(13 downto 0);
	signal x_acc, y_acc : signed (13 downto 0);
	signal x_maxvel, y_maxvel : signed(13 downto 0);
	
	signal counter1, counter2 : unsigned(2 downto 0);
begin
	ship_x <= x_position;
	ship_y <= y_position;
	
	process(all) begin
            case rotation(5 downto 1) is
				when 5d"0"=>
					x_acc <= to_signed(0, 14);
					y_acc <= to_signed(-12, 14);
				when 5d"1"=>
					x_acc <= to_signed(-2, 14);
					y_acc <= to_signed(-12, 14);
				when 5d"2"=>
					x_acc <= to_signed(-5, 14);
					y_acc <= to_signed(-11, 14);
				when 5d"3"=>
					x_acc <= to_signed(-7, 14);
					y_acc <= to_signed(-10, 14);
				when 5d"4"=>
					x_acc <= to_signed(-8, 14);
					y_acc <= to_signed(-8, 14);
				when 5d"5"=>
					x_acc <= to_signed(-10, 14);
					y_acc <= to_signed(-7, 14);
				when 5d"6"=>
					x_acc <= to_signed(-11, 14);
					y_acc <= to_signed(-5, 14);
				when 5d"7"=>
					x_acc <= to_signed(-12, 14);
					y_acc <= to_signed(-2, 14);
				when 5d"8"=>
					x_acc <= to_signed(-12, 14);
					y_acc <= to_signed(0, 14);
				when 5d"9"=>
					x_acc <= to_signed(-12, 14);
					y_acc <= to_signed(2, 14);
				when 5d"10"=>
					x_acc <= to_signed(-11, 14);
					y_acc <= to_signed(5, 14);
				when 5d"11"=>
					x_acc <= to_signed(-10, 14);
					y_acc <= to_signed(7, 14);
				when 5d"12"=>
					x_acc <= to_signed(-8, 14);
					y_acc <= to_signed(8, 14);
				when 5d"13"=>
					x_acc <= to_signed(-7, 14);
					y_acc <= to_signed(10, 14);
				when 5d"14"=>
					x_acc <= to_signed(-5, 14);
					y_acc <= to_signed(11, 14);
				when 5d"15" =>
					x_acc <= to_signed(-2, 14);
					y_acc <= to_signed(12, 14);
				when 5d"16"=>
					x_acc <= to_signed(0, 14);
					y_acc <= to_signed(12, 14);
				when 5d"17"=>
					x_acc <= to_signed(2, 14);
					y_acc <= to_signed(12, 14);
				when 5d"18"=>
					x_acc <= to_signed(5, 14);
					y_acc <= to_signed(11, 14);
				when 5d"19"=>
					x_acc <= to_signed(7, 14);
					y_acc <= to_signed(10, 14);
				when 5d"20"=>
					x_acc <= to_signed(8, 14);
					y_acc <= to_signed(8, 14);
				when 5d"21"=>
					x_acc <= to_signed(10, 14);
					y_acc <= to_signed(7, 14);
				when 5d"22"=>
					x_acc <= to_signed(11, 14);
					y_acc <= to_signed(5, 14);
				when 5d"23"=>
					x_acc <= to_signed(12, 14);
					y_acc <= to_signed(2, 14);
				when 5d"24"=>
					x_acc <= to_signed(12, 14);
					y_acc <= to_signed(0, 14);
				when 5d"25"=>
					x_acc <= to_signed(12, 14);
					y_acc <= to_signed(-2, 14);
				when 5d"26"=>
					x_acc <= to_signed(11, 14);
					y_acc <= to_signed(-5, 14);
				when 5d"27"=>
					x_acc <= to_signed(10, 14);
					y_acc <= to_signed(-7, 14);
				when 5d"28"=>
					x_acc <= to_signed(8, 14);
					y_acc <= to_signed(-8, 14);
				when 5d"29"=>
					x_acc <= to_signed(7, 14);
					y_acc <= to_signed(-10, 14);
				when 5d"30"=>
					x_acc <= to_signed(5, 14);
					y_acc <= to_signed(-11, 14);
				when 5d"31"=>
					x_acc <= to_signed(2, 14);
					y_acc <= to_signed(-12, 14);
				when others =>
					x_acc <= to_signed(12, 14);
					y_acc <= to_signed(12, 14);
			end case;
			
			case rotation(5 downto 1) is
				when 5d"0"=>
					x_maxvel <= to_signed(0, 14);
					y_maxvel <= to_signed(-48, 14);
				when 5d"1"=>
					x_maxvel <= to_signed(-8, 14);
					y_maxvel <= to_signed(-48, 14);
				when 5d"2"=>
					x_maxvel <= to_signed(-20, 14);
					y_maxvel <= to_signed(-22, 14);
				when 5d"3"=>
					x_maxvel <= to_signed(-28, 14);
					y_maxvel <= to_signed(-40, 14);
				when 5d"4"=>
					x_maxvel <= to_signed(-32, 14);
					y_maxvel <= to_signed(-32, 14);
				when 5d"5"=>
					x_maxvel <= to_signed(-40, 14);
					y_maxvel <= to_signed(-28, 14);
				when 5d"6"=>
					x_maxvel <= to_signed(-44, 14);
					y_maxvel <= to_signed(-20, 14);
				when 5d"7"=>
					x_maxvel <= to_signed(-48, 14);
					y_maxvel <= to_signed(-8, 14);
				when 5d"8"=>
					x_maxvel <= to_signed(-48, 14);
					y_maxvel <= to_signed(0, 14);
				when 5d"9"=>
					x_maxvel <= to_signed(-48, 14);
					y_maxvel <= to_signed(8, 14);
				when 5d"10"=>
					x_maxvel <= to_signed(-44, 14);
					y_maxvel <= to_signed(20, 14);
				when 5d"11"=>
					x_maxvel <= to_signed(-40, 14);
					y_maxvel <= to_signed(28, 14);
				when 5d"12"=>
					x_maxvel <= to_signed(-32, 14);
					y_maxvel <= to_signed(32, 14);
				when 5d"13"=>
					x_maxvel <= to_signed(-28, 14);
					y_maxvel <= to_signed(40, 14);
				when 5d"14"=>
					x_maxvel <= to_signed(-20, 14);
					y_maxvel <= to_signed(44, 14);
				when 5d"15" =>
					x_maxvel <= to_signed(-8, 14);
					y_maxvel <= to_signed(44, 14);
				when 5d"16"=>
					x_maxvel <= to_signed(0, 14);
					y_maxvel <= to_signed(48, 14);
				when 5d"17"=>
					x_maxvel <= to_signed(8, 14);
					y_maxvel <= to_signed(48, 14);
				when 5d"18"=>
					x_maxvel <= to_signed(20, 14);
					y_maxvel <= to_signed(44, 14);
				when 5d"19"=>
					x_maxvel <= to_signed(28, 14);
					y_maxvel <= to_signed(40, 14);
				when 5d"20"=>
					x_maxvel <= to_signed(32, 14);
					y_maxvel <= to_signed(32, 14);
				when 5d"21"=>
					x_maxvel <= to_signed(40, 14);
					y_maxvel <= to_signed(28, 14);
				when 5d"22"=>
					x_maxvel <= to_signed(44, 14);
					y_maxvel <= to_signed(20, 14);
				when 5d"23"=>
					x_maxvel <= to_signed(48, 14);
					y_maxvel <= to_signed(8, 14);
				when 5d"24"=>
					x_maxvel <= to_signed(48, 14);
					y_maxvel <= to_signed(0, 14);
				when 5d"25"=>
					x_maxvel <= to_signed(48, 14);
					y_maxvel <= to_signed(-8, 14);
				when 5d"26"=>
					x_maxvel <= to_signed(44, 14);
					y_maxvel <= to_signed(-20, 14);
				when 5d"27"=>
					x_maxvel <= to_signed(40, 14);
					y_maxvel <= to_signed(-28, 14);
				when 5d"28"=>
					x_maxvel <= to_signed(32, 14);
					y_maxvel <= to_signed(-32, 14);
				when 5d"29"=>
					x_maxvel <= to_signed(28, 14);
					y_maxvel <= to_signed(-40, 14);
				when 5d"30"=>
					x_maxvel <= to_signed(20, 14);
					y_maxvel <= to_signed(-44, 14);
				when 5d"31"=>
					x_maxvel <= to_signed(8, 14);
					y_maxvel <= to_signed(-44, 14);
				when others =>
					x_maxvel <= to_signed(48, 14);
					y_maxvel <= to_signed(48, 14);
			end case;
	end process;

    process (clk) is begin
        if rising_edge(clk) then
			if reset then
				if is_p1 then
					x_position <= 10d"40" & 4d"0";
					y_position <= 10d"40" & 4d"0";
					rotation <= "110000";
				else
					x_position <= 10d"600" & 4d"0";
					y_position <= 10d"440" & 4d"0";
					rotation <= "010000";
				end if;
			else
				if up_in then
					x_vel <= (x_vel + x_acc) when (x_vel + x_acc) < x_maxvel and (x_vel + x_acc) > (14d"0" - x_maxvel) else x_maxvel;
					y_vel <= (y_vel + y_acc) when (y_vel + y_acc) < y_maxvel and (y_vel + y_acc) > (14d"0" - y_maxvel) else y_maxvel;
				else
					if counter1 = 3d"3" then
						if x_vel > 14d"0" then
							x_vel <= (x_vel - 14d"1") when (x_vel - 14d"1") > 14d"0" else 14d"0";
						else
							x_vel <= (x_vel + 14d"1") when (x_vel + 14d"1") < 14d"0" else 14d"0";
						end if;
						
						if y_vel > 14d"0" then
							y_vel <= (y_vel - 14d"1") when (y_vel - 14d"1") > 14d"0" else 14d"0";
						else
							y_vel <= (y_vel + 14d"1") when (y_vel + 14d"1") < 14d"0" else 14d"0";
						end if;
						counter1 <= 3d"0";
					else
						counter1 <= counter1 + 1;
					end if;
				end if;

				if counter2 = 3d"2" then
					if left_in then
						rotation <= rotation + 2;
					elsif right_in then
						rotation <= rotation - 2;
					end if;
					counter2 <= 3d"0";
				else
					counter2 <= counter2 + 1;
				end if;
				
				x_position <= (x_position + unsigned(x_vel)) when (x_position + unsigned(x_vel)) < 10d"640" & 4d"0"
					else 14d"0" when (x_position + unsigned(x_vel)) < 10d"700" & 4d"0"
								  else 10d"639" & 4d"0";
				y_position <= (y_position + unsigned(y_vel)) when (y_position + unsigned(y_vel)) < 10d"480" & 4d"0"
								  else 14d"0" when (y_position + unsigned(y_vel)) < 10d"600" & 4d"0"
								  else 10d"479" & 4d"0";
			end if;
		end if;
	end process;
	
	ship_rot <= rotation;
end;


