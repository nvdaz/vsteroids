library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity asteroid is
port(
    clk : in std_logic;
    reset : in std_logic;
    asteroid_x_position_in : in unsigned(9 downto 0);
    asteroid_y_position_in : in unsigned(9 downto 0);
    
    asteroid_x_velocity : in signed(9 downto 0);
    asteroid_y_velocity : in signed(9 downto 0);
    
    asteroid_x_position_out : out unsigned(9 downto 0);
    asteroid_y_position_out : out unsigned(9 downto 0)
);

end;

architecture synth of asteroid is
	signal x_pos_signal : unsigned(9 downto 0);
	signal y_pos_signal : unsigned(9 downto 0);
	signal x_velo_signal : signed(9 downto 0);
	signal y_velo_signal : signed(9 downto 0);
begin

process(clk) begin
    if rising_edge (clk) then
        if reset then
            x_pos_signal <= asteroid_x_position_in;
            y_pos_signal <= asteroid_y_position_in;

			x_velo_signal <= asteroid_x_velocity;
			y_velo_signal <= asteroid_y_velocity;
        else
            --if x_pos_signal > 10d"407" then
                --x_velo_signal <= 10d"0" - x_velo_signal;
				--x_pos_signal <= 10d"0";
				--x_pos_signal <= x_pos_signal - unsigned(x_velo_signal);
			--else
				--x_pos_signal <= x_pos_signal + unsigned(x_velo_signal);
			--end if;
			
            --if y_pos_signal > 10d"247" then
                --y_velo_signal <= 10d"0" - y_velo_signal;
				--y_pos_signal <= 10d"0";
				--y_pos_signal <= y_pos_signal - unsigned(y_velo_signal);
			--else
				--y_pos_signal <= y_pos_signal + unsigned(y_velo_signal);
            --end if;
			x_pos_signal <= x_pos_signal + unsigned(x_velo_signal);
			y_pos_signal <= y_pos_signal + unsigned(y_velo_signal);
        end if;
    end if;
end process;
    asteroid_x_position_out <= x_pos_signal;
    asteroid_y_position_out <= y_pos_signal;
end;




