library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity projectile_controller is
	port(
		clk : in std_logic;
		fired_in : in std_logic;

		ship_position_x : in unsigned(9 downto 0);
		ship_position_y : in unsigned(9 downto 0);
		rotation : in unsigned(2 downto 0);
		
		x_position_out1 : out unsigned(9 downto 0);
		y_position_out1 : out unsigned(9 downto 0);

		x_position_out2 : out unsigned(9 downto 0);
		y_position_out2 : out unsigned(9 downto 0);

		x_position_out3 : out unsigned(9 downto 0);
		y_position_out3 : out unsigned(9 downto 0);

		proj_alive : out std_logic_vector(2 downto 0)
	);
end;

architecture synth of projectile_controller is

signal fired_proj : std_logic_vector(2 downto 0);
signal output_proj : std_logic_vector(2 downto 0);

component projectile is
	port(
		clk : in std_logic;
		fired_in : in std_logic;

		x_position_in : in unsigned(9 downto 0);
		y_position_in : in unsigned(9 downto 0);

		rotation_in : in unsigned(2 downto 0);
		x_position_out : out unsigned(9 downto 0);
		y_position_out : out unsigned(9 downto 0);
		alive : out std_logic
	);
end component;

begin

proj1 : projectile port map(clk, fired_proj(0), ship_position_x, ship_position_y, rotation, x_position_out1, y_position_out1, output_proj(0));
--proj2 : projectile port map(clk, fired_proj(1), ship_position_x, ship_position_y, rotation, x_position_out2, y_position_out2, output_proj(1));
--proj3 : projectile port map(clk, fired_proj(2), ship_position_x, ship_position_y, rotation, x_position_out3, y_position_out3, output_proj(2));


	x_position_out2 <= 10d"320";
	y_position_out2 <= 10d"240";
	proj_alive <= 3b"111";
--proj_alive <= output_proj;

output_proj(1) <= '1';
output_proj(2) <= '1';

process (clk) begin
    if rising_edge(clk) then
         if fired_in then
			fired_proj <= 3b"111";
			--if not output_proj(0) then
				--fired_proj(0) <= '1';
			--elsif output_proj(0) and not output_proj(1) then
				--fired_proj(1) <= '1';
			--elsif output_proj(0) and output_proj(1) and not output_proj(2) then
				--fired_proj(2) <= '1';
			--end if;
        end if;
    end if;
end process;

end;

