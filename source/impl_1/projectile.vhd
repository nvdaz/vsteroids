library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity projectile is
port(
    clk : in std_logic;
    fired_in : in std_logic;

    x_position_in : in unsigned(13 downto 0);
    y_position_in : in unsigned(13 downto 0);

    rotation_in : in unsigned(5 downto 0);
    x_position_out : out unsigned(9 downto 0);
    y_position_out : out unsigned(9 downto 0);
    alive : out std_logic
);

end;

architecture synth of projectile is

	signal x_vel, y_vel : signed(13 downto 0); 

	signal x_position, y_position : unsigned(13 downto 0);
	signal x_position_start, y_position_start : unsigned(13 downto 0);
	signal rotation : unsigned(5 downto 0);

	signal fired : std_logic;
	signal counter : unsigned(19 downto 0);

begin
	x_position_out <= x_position(13 downto 4);
    y_position_out <= y_position(13 downto 4);
	
	process (all) begin
		case rotation(5 downto 1) is
				when 5d"0"=>
					x_position_start <= to_unsigned(144, 14);
					y_position_start <= to_unsigned(0, 14);
				when 5d"1"=>
					x_position_start <= to_unsigned(96, 14);
					y_position_start <= to_unsigned(0, 14);
				when 5d"2"=>
					x_position_start <= to_unsigned(80, 14);
					y_position_start <= to_unsigned(16, 14);
				when 5d"3"=>
					x_position_start <= to_unsigned(48, 14);
					y_position_start <= to_unsigned(48, 14);
				when 5d"4"=>
					x_position_start <= to_unsigned(48, 14);
					y_position_start <= to_unsigned(48, 14);
				when 5d"5"=>
					x_position_start <= to_unsigned(80, 14);
					y_position_start <= to_unsigned(80, 14);
				when 5d"6"=>
					x_position_start <= to_unsigned(48, 14);
					y_position_start <= to_unsigned(96, 14);
				when 5d"7"=>
					x_position_start <= to_unsigned(48, 14);
					y_position_start <= to_unsigned(112, 14);
				when 5d"8"=>
					x_position_start <= to_unsigned(16, 14);
					y_position_start <= to_unsigned(160, 14);
				when 5d"9"=>
					x_position_start <= to_unsigned(48, 14);
					y_position_start <= to_unsigned(224, 14);
				when 5d"10"=>
					x_position_start <= to_unsigned(32, 14);
					y_position_start <= to_unsigned(240, 14);
				when 5d"11"=>
					x_position_start <= to_unsigned(64, 14);
					y_position_start <= to_unsigned(256, 14);
				when 5d"12"=>
					x_position_start <= to_unsigned(64, 14);
					y_position_start <= to_unsigned(272, 14);
				when 5d"13"=>
					x_position_start <= to_unsigned(80, 14);
					y_position_start <= to_unsigned(288, 14);
				when 5d"14"=>
					x_position_start <= to_unsigned(96, 14);
					y_position_start <= to_unsigned(304, 14);
				when 5d"15" =>
					x_position_start <= to_unsigned(128, 14);
					y_position_start <= to_unsigned(304, 14);
				when 5d"16"=>
					x_position_start <= to_unsigned(176, 14);
					y_position_start <= to_unsigned(304, 14);
				when 5d"17"=>
					x_position_start <= to_unsigned(192, 14);
					y_position_start <= to_unsigned(304, 14);
				when 5d"18"=>
					x_position_start <= to_unsigned(224, 14);
					y_position_start <= to_unsigned(288, 14);
				when 5d"19"=>
					x_position_start <= to_unsigned(240, 14);
					y_position_start <= to_unsigned(272, 14);
				when 5d"20"=>
					x_position_start <= to_unsigned(256, 14);
					y_position_start <= to_unsigned(256, 14);
				when 5d"21"=>
					x_position_start <= to_unsigned(272, 14);
					y_position_start <= to_unsigned(240, 14);
				when 5d"22"=>
					x_position_start <= to_unsigned(288, 14);
					y_position_start <= to_unsigned(224, 14);
				when 5d"23"=>
					x_position_start <= to_unsigned(304, 14);
					y_position_start <= to_unsigned(176, 14);
				when 5d"24"=>
					x_position_start <= to_unsigned(304, 14);
					y_position_start <= to_unsigned(160, 14);
				when 5d"25"=>
					x_position_start <= to_unsigned(304, 14);
					y_position_start <= to_unsigned(128, 14);
				when 5d"26"=>
					x_position_start <= to_unsigned(288, 14);
					y_position_start <= to_unsigned(80, 14);
				when 5d"27"=>
					x_position_start <= to_unsigned(272, 14);
					y_position_start <= to_unsigned(64, 14);
				when 5d"28"=>
					x_position_start <= to_unsigned(256, 14);
					y_position_start <= to_unsigned(48, 14);
				when 5d"29"=>
					x_position_start <= to_unsigned(240, 14);
					y_position_start <= to_unsigned(32, 14);
				when 5d"30"=>
					x_position_start <= to_unsigned(208, 14);
					y_position_start <= to_unsigned(16, 14);
				when 5d"31"=>
					x_position_start <= to_unsigned(176, 14);
					y_position_start <= to_unsigned(0, 14);
				when others =>
					x_position_start <= to_unsigned(96, 14);
					y_position_start <= to_unsigned(96, 14);
			end case;
			
			case rotation(5 downto 1) is
				when 5d"0"=>
					x_vel <= to_signed(0, 14);
					y_vel <= to_signed(-144, 14);
				when 5d"1"=>
					x_vel <= to_signed(-24, 14);
					y_vel <= to_signed(-144, 14);
				when 5d"2"=>
					x_vel <= to_signed(-60, 14);
					y_vel <= to_signed(-132, 14);
				when 5d"3"=>
					x_vel <= to_signed(-84, 14);
					y_vel <= to_signed(-120, 14);
				when 5d"4"=>
					x_vel <= to_signed(-96, 14);
					y_vel <= to_signed(-96, 14);
				when 5d"5"=>
					x_vel <= to_signed(-120, 14);
					y_vel <= to_signed(-84, 14);
				when 5d"6"=>
					x_vel <= to_signed(-132, 14);
					y_vel <= to_signed(-60, 14);
				when 5d"7"=>
					x_vel <= to_signed(-144, 14);
					y_vel <= to_signed(-24, 14);
				when 5d"8"=>
					x_vel <= to_signed(-144, 14);
					y_vel <= to_signed(0, 14);
				when 5d"9"=>
					x_vel <= to_signed(-144, 14);
					y_vel <= to_signed(24, 14);
				when 5d"10"=>
					x_vel <= to_signed(-132, 14);
					y_vel <= to_signed(60, 14);
				when 5d"11"=>
					x_vel <= to_signed(-120, 14);
					y_vel <= to_signed(84, 14);
				when 5d"12"=>
					x_vel <= to_signed(-96, 14);
					y_vel <= to_signed(96, 14);
				when 5d"13"=>
					x_vel <= to_signed(-84, 14);
					y_vel <= to_signed(120, 14);
				when 5d"14"=>
					x_vel <= to_signed(-60, 14);
					y_vel <= to_signed(132, 14);
				when 5d"15" =>
					x_vel <= to_signed(-24, 14);
					y_vel <= to_signed(132, 14);
				when 5d"16"=>
					x_vel <= to_signed(0, 14);
					y_vel <= to_signed(144, 14);
				when 5d"17"=>
					x_vel <= to_signed(24, 14);
					y_vel <= to_signed(144, 14);
				when 5d"18"=>
					x_vel <= to_signed(60, 14);
					y_vel <= to_signed(132, 14);
				when 5d"19"=>
					x_vel <= to_signed(84, 14);
					y_vel <= to_signed(120, 14);
				when 5d"20"=>
					x_vel <= to_signed(96, 14);
					y_vel <= to_signed(96, 14);
				when 5d"21"=>
					x_vel <= to_signed(120, 14);
					y_vel <= to_signed(84, 14);
				when 5d"22"=>
					x_vel <= to_signed(132, 14);
					y_vel <= to_signed(60, 14);
				when 5d"23"=>
					x_vel <= to_signed(144, 14);
					y_vel <= to_signed(24, 14);
				when 5d"24"=>
					x_vel <= to_signed(144, 14);
					y_vel <= to_signed(0, 14);
				when 5d"25"=>
					x_vel <= to_signed(144, 14);
					y_vel <= to_signed(-24, 14);
				when 5d"26"=>
					x_vel <= to_signed(132, 14);
					y_vel <= to_signed(-60, 14);
				when 5d"27"=>
					x_vel <= to_signed(120, 14);
					y_vel <= to_signed(-84, 14);
				when 5d"28"=>
					x_vel <= to_signed(96, 14);
					y_vel <= to_signed(-96, 14);
				when 5d"29"=>
					x_vel <= to_signed(84, 14);
					y_vel <= to_signed(-120, 14);
				when 5d"30"=>
					x_vel <= to_signed(60, 14);
					y_vel <= to_signed(-132, 14);
				when 5d"31"=>
					x_vel <= to_signed(24, 14);
					y_vel <= to_signed(-132, 14);
				when others =>
					x_vel <= to_signed(144, 14);
					y_vel <= to_signed(144, 14);
			end case;
		end process;
	
	process (clk) begin
    if rising_edge(clk) then
		if(counter < 20d"60") then
			counter <= counter + 1;
		else
			counter <= 20d"0";
			alive <= '0';
		end if;

		fired <= fired_in;
        if fired_in and not fired then
			rotation <= rotation_in;
			alive <= '1';
			counter <= 20d"0";

            x_position <= x_position_in + x_position_start;
			y_position <= y_position_in + y_position_start;
        else
				x_position <= (x_position + unsigned(x_vel)) when (x_position + unsigned(x_vel)) < 10d"640" & 4d"0"
					else 14d"0" when (x_position + unsigned(x_vel)) < 10d"700" & 4d"0"
								  else 10d"639" & 4d"0";
				y_position <= (y_position + unsigned(y_vel)) when (y_position + unsigned(y_vel)) < 10d"480" & 4d"0"
								  else 14d"0" when (y_position + unsigned(y_vel)) < 10d"600" & 4d"0"
								  else 10d"479" & 4d"0";
			end if;


		end if;
	end process;

end;

