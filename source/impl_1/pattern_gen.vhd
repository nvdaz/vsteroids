library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pattern_gen is
	port (
			clk : in std_logic;
			vsync : in std_logic;
			row : in unsigned(9 downto 0);
			col : in unsigned(9 downto 0);
			valid : in std_logic;

			ship1_reset : in std_logic;
			ship1_x : in unsigned(9 downto 0); 
			ship1_y : in unsigned(9 downto 0);
			ship1_rot : in unsigned(5 downto 0);

			ship2_reset : in std_logic;
			ship2_x : in unsigned(9 downto 0);
			ship2_y : in unsigned(9 downto 0);
			ship2_rot : in unsigned(5 downto 0);

			ship1_alive : out std_logic;
			ship2_alive : out std_logic;

			ship1_proj1_x, ship1_proj1_y, ship1_proj2_x, ship1_proj2_y, ship1_proj3_x, ship1_proj3_y : in unsigned(9 downto 0);
			ship1_proj_alive : in std_logic_vector(2 downto 0);

			ship2_proj1_x, ship2_proj1_y, ship2_proj2_x, ship2_proj2_y, ship2_proj3_x, ship2_proj3_y : in unsigned(9 downto 0);
			ship2_proj_alive : in std_logic_vector(2 downto 0);
			
			asteroid1_x, asteroid1_y, asteroid2_x, asteroid2_y, asteroid3_x, asteroid3_y : in unsigned(9 downto 0);
			
			state : unsigned(2 downto 0);
			
			rgb : out std_logic_vector(0 to 5)
	);
end;

architecture synth of pattern_gen is
	constant START : unsigned(2 downto 0) := 3d"0";
	constant GAME : unsigned(2 downto 0) := 3d"1";
	constant P1W : unsigned(2 downto 0) := 3d"2";
	constant P2W : unsigned(2 downto 0) := 3d"3";
	constant TIE : unsigned(2 downto 0) := 3d"4";

	signal sprite1_output : std_logic_vector(5 downto 0);
	signal ship1_occupies : std_logic_vector(5 downto 0);
	signal ship1_spriteX, ship1_spriteY : unsigned(9 downto 0);
	
	signal ship2_sprite_out : std_logic_vector(5 downto 0);
	signal ship2_occupies : std_logic_vector(5 downto 0);
	signal ship2_sprite_x, ship2_sprite_y : unsigned(9 downto 0);
	
	signal ship1_proj1_sprite_x, ship1_proj1_sprite_y, ship1_proj2_sprite_x, ship1_proj2_sprite_y, ship1_proj3_sprite_x, ship1_proj3_sprite_y : unsigned(9 downto 0);
	signal ship1_proj_occupies : std_logic_vector(2 downto 0);
	
	signal ship2_proj1_sprite_x, ship2_proj1_sprite_y, ship2_proj2_sprite_x, ship2_proj2_sprite_y, ship2_proj3_sprite_x, ship2_proj3_sprite_y : unsigned(9 downto 0);
	signal ship2_proj_occupies : std_logic_vector(2 downto 0);
	
	signal asteroid1_sprite_x, asteroid1_sprite_y : unsigned(9 downto 0);
	signal asteroid1_sprite_output, asteroid1_occupies : std_logic_vector(5 downto 0);
	
	signal asteroid2_sprite_x, asteroid2_sprite_y : unsigned(9 downto 0);
	signal asteroid2_sprite_output, asteroid2_occupies : std_logic_vector(5 downto 0);
	
	signal asteroid3_sprite_x, asteroid3_sprite_y : unsigned(9 downto 0);
	signal asteroid3_sprite_output, asteroid3_occupies : std_logic_vector(5 downto 0);
	
	signal vsteroids_sprite_x, vsteroids_sprite_y : unsigned(9 downto 0);
	signal vsteroids_sprite_output, vsteroids_sprite_render : std_logic_vector(5 downto 0);
	
	signal press_start_sprite_x, press_start_sprite_y : unsigned(9 downto 0);
	signal press_start_sprite_output, press_start_sprite_render : std_logic_vector(5 downto 0);
	
	signal game_over_sprite_x, game_over_sprite_y : unsigned(9 downto 0);
	signal game_over_sprite_output, game_over_sprite_render : std_logic_vector(5 downto 0);
	
	signal player1_wins_sprite_x, player1_wins_sprite_y : unsigned(9 downto 0);
	signal player1_wins_sprite_output, player1_wins_sprite_render : std_logic_vector(5 downto 0);
	
	signal player2_wins_sprite_x, player2_wins_sprite_y : unsigned(9 downto 0);
	signal player2_wins_sprite_output, player2_wins_sprite_render : std_logic_vector(5 downto 0);
	
	signal tie_sprite_x, tie_sprite_y : unsigned(9 downto 0);
	signal tie_sprite_output, tie_sprite_render : std_logic_vector(5 downto 0);
	
	signal in_game_screen, player1_wins_screen, player2_wins_screen, tie_screen : std_logic_vector(5 downto 0);
		
	signal counter : unsigned(9 downto 0);
	
	signal gamestart_screen : std_logic_vector(5 downto 0);
	
	component ship_sprite_32 is
		port(
			clk : in std_logic;
			x : in unsigned(4 downto 0); -- 0 to 19
			y : in unsigned(4 downto 0); -- 0 to 19
			rot : in unsigned(4 downto 0);
			rgb : out std_logic_vector(5 downto 0)
		);
	end component;
	
	component asteroid_sprite is
		port(
			clk : in std_logic;
			x : in unsigned(4 downto 0); -- 0 to 31
			y : in unsigned(4 downto 0); -- 0 to 31
			
			rgb : out std_logic_vector(5 downto 0)
		);
	end component;
	
	
	component start_sprite is
		port(
			x : in unsigned(5 downto 0); -- 0 to 54
			y : in unsigned(3 downto 0); -- 0 to 15
			
			rgb : out unsigned(5 downto 0)
		);
	end component;
	
	component vsteroids_sprite is
		port(
			clk : in std_logic;
			x : in unsigned(5 downto 0); -- 0 to 46
			y : in unsigned(2 downto 0); -- 0 to 6
			
			rgb : out std_logic_vector(5 downto 0)
		);
	end component;
		
	component press_start_sprite is
		port(
			clk : in std_logic;
			x : in unsigned(5 downto 0); -- 0 to 54
			y : in unsigned(2 downto 0); -- 0 to 4
			
			rgb : out std_logic_vector(5 downto 0)
		);
	end component;
	
	component tie_sprite is
		port(
			clk : in std_logic;
			x : in unsigned(4 downto 0); -- 0 to 17
			y : in unsigned(2 downto 0); -- 0 to 4
			
			rgb : out std_logic_vector(5 downto 0)
		);
	end component;

	component game_over_sprite is
		port(
			clk : in std_logic;
			x : in unsigned(5 downto 0); -- 0 to 43
			y : in unsigned(2 downto 0); -- 0 to 4
			
			rgb : out std_logic_vector(5 downto 0)
		);
	end component;
	
	
	component player1_wins_sprite is
		port(
			clk : in std_logic;
			x : in unsigned(5 downto 0); -- 0 to 61
			y : in unsigned(2 downto 0); -- 0 to 4
			
			rgb : out std_logic_vector(5 downto 0)
		);
	end component;
	
	
	component player2_wins_sprite is
		port(
			clk : in std_logic;
			x : in unsigned(5 downto 0); -- 0 to 62
			y : in unsigned(2 downto 0); -- 0 to 4
			
			rgb : out std_logic_vector(5 downto 0)
		);
	end component;


begin
	-- ship sprite accessing
	ship1_spriteX <= (col - ship1_X);
	ship1_spriteY <= (row - ship1_y);
	ship2_sprite_x <= (col - ship2_X);
	ship2_sprite_y <= (row - ship2_y);

	-- projectile sprite accessing
	ship1_proj1_sprite_x <= col - ship1_proj1_x; -- ship 1
	ship1_proj1_sprite_y <= row - ship1_proj1_y;
	ship1_proj2_sprite_x <= col - ship1_proj2_x;
	ship1_proj2_sprite_y <= row - ship1_proj2_y;
	ship1_proj3_sprite_x <= col - ship1_proj3_x;
	ship1_proj3_sprite_y <= row - ship1_proj3_y;
	
	ship2_proj1_sprite_x <= col - ship2_proj1_x; -- ship 2
	ship2_proj1_sprite_y <= row - ship2_proj1_y;
	ship2_proj2_sprite_x <= col - ship2_proj2_x;
	ship2_proj2_sprite_y <= row - ship2_proj2_y;
	ship2_proj3_sprite_x <= col - ship2_proj3_x;
	ship2_proj3_sprite_y <= row - ship2_proj3_y;
	
	asteroid1_sprite_x <= col - asteroid1_x;
	asteroid1_sprite_y <= row - asteroid1_y;
	asteroid1_occupies <= asteroid1_sprite_output when asteroid1_sprite_x < 32 and asteroid1_sprite_y < 32 else 6d"0";
	
	asteroid2_sprite_x <= col - asteroid2_x;
	asteroid2_sprite_y <= row - asteroid2_y;
	asteroid2_occupies <= asteroid2_sprite_output when asteroid2_sprite_x < 32 and asteroid2_sprite_y < 32 else 6d"0";
	
	asteroid3_sprite_x <= col - asteroid3_x;
	asteroid3_sprite_y <= row - asteroid3_y;
	asteroid3_occupies <= asteroid3_sprite_output when asteroid3_sprite_x < 32 and asteroid3_sprite_y < 32 else 6d"0";
	
	press_start_sprite_x <= (2b"00" & col(9 downto 2)) - 9d"48";
	press_start_sprite_y <= (2b"00" & row(9 downto 2)) - 9d"56";
	press_start_sprite_render <= press_start_sprite_output when press_start_sprite_x < 55 and press_start_sprite_y < 5 else 6d"0";
	
	vsteroids_sprite_x <= (3b"000" & col(9 downto 3)) - 9d"16";
	vsteroids_sprite_y <= (3b"000" & row(9 downto 3)) - 9d"20";
	vsteroids_sprite_render <= vsteroids_sprite_output when vsteroids_sprite_x < 47 and vsteroids_sprite_y < 7 else 6d"0";
	
	game_over_sprite_x <= (3b"000" & col(9 downto 3)) - 9d"14";
	game_over_sprite_y <= (3b"000" & row(9 downto 3)) - 9d"26";
	game_over_sprite_render <= game_over_sprite_output when game_over_sprite_x < 50 and game_over_sprite_y < 5 else 6d"0";
	
	player1_wins_sprite_x <= (2b"00" & col(9 downto 2)) - 9d"48";
	player1_wins_sprite_y <= (2b"00" & row(9 downto 2)) - 9d"66";
	player1_wins_sprite_render <= player1_wins_sprite_output when player1_wins_sprite_x < 63 and player1_wins_sprite_y < 5 else 6d"0";
	
	player2_wins_sprite_x <= (2b"00" & col(9 downto 2)) - 9d"48";
	player2_wins_sprite_y <= (2b"00" & row(9 downto 2)) - 9d"66";
	player2_wins_sprite_render <= player2_wins_sprite_output when player2_wins_sprite_x < 63 and player2_wins_sprite_y < 5 else 6d"0";

	tie_sprite_x <= (2b"00" & col(9 downto 2)) - 9d"68";
	tie_sprite_y <= (2b"00" & row(9 downto 2)) - 9d"66";
	tie_sprite_render <= tie_sprite_output when tie_sprite_x < 18 and tie_sprite_y < 5 else 6d"0";

	t_shipsprite1 : ship_sprite_32 port map(clk, ship1_spritex(4 downto 0), ship1_spritey(4 downto 0), ship1_rot(5 downto 1), sprite1_output);
	t_shipsprite2 : ship_sprite_32 port map(clk, ship2_sprite_x(4 downto 0), ship2_sprite_y(4 downto 0), ship2_rot(5 downto 1), ship2_sprite_out);

	ship1_occupies <= sprite1_output when ship1_spriteX < 20 and ship1_spriteY < 20 else 6d"0";
	ship2_occupies <= ship2_sprite_out when ship2_sprite_x < 20 and ship2_sprite_y < 20 else 6d"0";

	t_asteroid1_sprite : asteroid_sprite port map (clk, asteroid1_sprite_x(4 downto 0), asteroid1_sprite_y(4 downto 0), asteroid1_sprite_output);
	t_asteroid2_sprite : asteroid_sprite port map (clk, asteroid2_sprite_x(4 downto 0), asteroid2_sprite_y(4 downto 0), asteroid2_sprite_output);
	t_asteroid3_sprite : asteroid_sprite port map (clk, asteroid3_sprite_x(4 downto 0), asteroid3_sprite_y(4 downto 0), asteroid3_sprite_output);
	t_vsteroids_sprite : vsteroids_sprite port map (clk, vsteroids_sprite_x(5 downto 0), vsteroids_sprite_y(2 downto 0), vsteroids_sprite_output);
	t_tie_sprite : tie_sprite port map(clk, tie_sprite_x(4 downto 0), tie_sprite_y(2 downto 0), tie_sprite_output);
	t_press_start_sprite_output : press_start_sprite port map (clk, press_start_sprite_x(5 downto 0), press_start_sprite_y(2 downto 0), press_start_sprite_output);
	t_game_over_sprite : game_over_sprite port map (clk, game_over_sprite_x(5 downto 0), game_over_sprite_y(2 downto 0), game_over_sprite_output);
	t_player1_wins_sprite : player1_wins_sprite port map (clk, player1_wins_sprite_x(5 downto 0), player1_wins_sprite_y(2 downto 0), player1_wins_sprite_output);
	t_player2_wins_sprite : player2_wins_sprite port map (clk, player2_wins_sprite_x(5 downto 0), player2_wins_sprite_y(2 downto 0), player2_wins_sprite_output);

	ship1_proj_occupies(0) <= ship1_proj_alive(0) when ship1_proj1_sprite_x < 5 and ship1_proj1_sprite_y < 5 else '0';
	ship1_proj_occupies(1) <= ship1_proj_alive(1) when ship1_proj2_sprite_x < 5 and ship1_proj2_sprite_y < 5 else '0';
	ship1_proj_occupies(2) <= ship1_proj_alive(2) when ship1_proj3_sprite_x < 5 and ship1_proj3_sprite_y < 5 else '0';

	ship2_proj_occupies(0) <= ship2_proj_alive(0) when ship2_proj1_sprite_x < 5 and ship2_proj1_sprite_y < 5 else '0';
	ship2_proj_occupies(1) <= ship2_proj_alive(1) when ship2_proj2_sprite_x < 5 and ship2_proj2_sprite_y < 5 else '0';
	ship2_proj_occupies(2) <= ship2_proj_alive(2) when ship2_proj3_sprite_x < 5 and ship2_proj3_sprite_y < 5 else '0';
			
	in_game_screen <= "110011" when (ship1_occupies /= 6b"0" and ship2_occupies/= 6b"0")
		 else "110000" when ship1_occupies /= 6b"0"
		 else "000111" when ship2_occupies /= 6b"0" 
		 else "111111" when (ship1_proj_occupies /= 3b"0" and ship2_proj_occupies /= 3b"0")
		 else "110000" when ship1_proj_occupies /= 3b"0"
		 else "000111" when ship2_proj_occupies /= 3b"0"
		 else asteroid1_occupies when asteroid1_occupies /= 6b"0"
		 else asteroid2_occupies when asteroid2_occupies /= 6b"0"
		 else asteroid3_occupies when asteroid3_occupies /= 6b"0"
		 else "111111" when (row mod 40 + (col + counter) mod 40 = 0) -- row right
							or ( (row+20) mod 40 + (col - counter) mod 40 = 0) -- row left
							or ( (row + counter) mod 40  + col mod 40 = 0) -- col down
							or ( (row - counter) mod 40 + (col + 20) mod 40 = 0) -- col up
							or ( (row) mod 40 + counter + col mod 40 = 0)
							or ( (row) mod 40 - counter + (col + 20) mod 40 = 0)
		 else "000000";
		 
		player1_wins_screen <= player1_wins_sprite_render when (player1_wins_sprite_render /= 6d"0" and counter(5) = '0')
								else game_over_sprite_render when game_over_sprite_render /= 6d"0"
								else "000000";
		player2_wins_screen <= player2_wins_sprite_render when (player2_wins_sprite_render /= 6d"0" and counter(5) = '0')
								else game_over_sprite_render;
		tie_screen <= tie_sprite_render when (tie_sprite_render /= 6d"0" and counter(5) = '0')
								else game_over_sprite_render when game_over_sprite_render /= 6d"0"
								else 6d"0";
		gamestart_screen <= vsteroids_sprite_render when vsteroids_sprite_render /= 6d"0"
								else press_start_sprite_render when (press_start_sprite_render /= 6d"0" and counter(5) = '0')
								else "111111" when ((row mod 40) + ((col + ('0' & counter(9 downto 1))) mod 20) = 0) or ((row+20) mod 40) + ((col - ('0' & counter(9 downto 1))) mod 20) = 0
								else "000000"; 
		 
	with state & valid select rgb <=
		gamestart_screen when START & '1',
		in_game_screen when GAME & '1',
		player1_wins_screen when P1W & '1',
		player2_wins_screen when P2W & '1',
		tie_screen when TIE & '1',
		"000000" when others;

	-- collision checks
	process (clk) begin
	if rising_edge(clk) then
			
		if state = GAME then
			-- ship 1 collision check
			if ship1_alive = '1' then
				ship1_alive <= '0' when ship1_occupies /= 6b"0" and (ship2_occupies /= 6b"0" or ship2_proj_occupies /= 3b"0" or asteroid1_occupies /= 6b"0" or asteroid2_occupies /= 6b"0" or asteroid3_occupies /= 6b"0") else '1';
			elsif ship1_reset then
				ship1_alive <= '1';
			end if;
			
			-- ship 2 collision check
			if ship2_alive = '1' then
				ship2_alive <= '0' when ship2_occupies /= 6b"0" and (ship1_occupies /= 6b"0" or ship1_proj_occupies /= 3b"0" or asteroid1_occupies /= 6b"0" or asteroid2_occupies /= 6b"0" or asteroid3_occupies /= 6b"0") else '1';
			elsif ship2_reset then
				ship2_alive <= '1';
			end if;
		end if;

	end if;
	end process;	
	
	process (vsync) begin
	if rising_edge(vsync) then
		counter <= counter + 1;
	end if;
	end process;
end;
