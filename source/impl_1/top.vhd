library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
	port (
		-- VGA
		ext_osc : in std_logic;
		rgb : out std_logic_vector(5 downto 0);
		hsync : out std_logic;
		vsync : out std_logic;

		nes1_in : in std_logic; -- from physical NES
		nes2_in : in std_logic;
		nes_latch : out std_logic; -- reset, for physical NES
		debug_tail : out std_logic;
		nes_clk_o : out std_logic -- for physical NES	
	);
end;


architecture synth of top is
	constant START : unsigned(2 downto 0) := 3d"0";
	constant GAME : unsigned(2 downto 0) := 3d"1";
	constant P1W : unsigned(2 downto 0) := 3d"2";
	constant P2W : unsigned(2 downto 0) := 3d"3";
	constant TIE : unsigned(2 downto 0) := 3d"4";
	
	signal clk : std_logic;
	signal row : unsigned(9 downto 0);
	signal col : unsigned(9 downto 0);
	signal valid : std_logic;
		
	signal player1_input : unsigned(7 downto 0);
	signal player2_input : unsigned(7 downto 0);
	
	signal ship1_x, ship1_y : unsigned(13 downto 0);
	signal ship1_rot : unsigned(5 downto 0);
	
	signal ship1_alive : std_logic;
	
	signal ship1_reset : std_logic;
	
	signal ship2_x, ship2_y : unsigned(13 downto 0);
	signal ship2_rot : unsigned(5 downto 0);
	
	signal ship2_alive : std_logic;
	
	signal ship2_reset : std_logic;

	signal nes2_clk_o : std_logic;
	
	signal ship1_proj1_x, ship1_proj1_y, ship1_proj2_x, ship1_proj2_y, ship1_proj3_x, ship1_proj3_y : unsigned(9 downto 0);
	signal ship1_proj_alive : std_logic_vector(2 downto 0);
	
	signal ship2_proj1_x, ship2_proj1_y, ship2_proj2_x, ship2_proj2_y, ship2_proj3_x, ship2_proj3_y : unsigned(9 downto 0);
	signal ship2_proj_alive : std_logic_vector(2 downto 0);
	
	signal asteroid1_x, asteroid1_y, asteroid2_x, asteroid2_y, asteroid3_x, asteroid3_y : unsigned(9 downto 0);
		
	signal counter : unsigned(12 downto 0);
	
	signal state : unsigned(2 downto 0);
	
	-- NULL for pll
	signal pll_tail : std_logic;
	
	component mypll is
		port(
			ref_clk_i: in std_logic; -- Input clock
			rst_n_i: in std_logic; -- Reset (active low)
			outcore_o: out std_logic; -- Output to pins
			outglobal_o: out std_logic -- Output for clock network
		);
	end component;
	
	component vga is
		port (
			clk : in std_logic;
			valid : out std_logic;
			row : out unsigned(9 downto 0);
			col : out unsigned(9 downto 0);
			hsync : out std_logic;
			vsync : out std_logic
		);
	end component;
	
	component pattern_gen is
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
	end component;
	
	component nes is
      port (
		  inputData1 : in std_logic; -- from physical NES
		  inputData2 : in std_logic;
		  latch : out std_logic; -- reset, for physical NES
		  nes_clk_out : out std_logic; -- for physical NES
		  -- Right = 0
			-- Left = 1
			-- Down = 2
			-- Up = 3
			-- Start = 4
			-- Select = 5
			-- B = 6
			-- A = 7
		  outputData1 : out unsigned(7 downto 0); -- button press data
		  outputData2 : out unsigned(7 downto 0)
		  
      );
	end component;
	
	component ship is
		port(
			clk : in std_logic;
			reset : in std_logic;
			-- ctrl inputs
			is_p1 : in std_logic;
			up_in : in std_logic;
			down_in : in std_logic;
			left_in : in std_logic;
			right_in : in std_logic;
			-- position
			ship_x, ship_y : out unsigned(13 downto 0);
			ship_rot : out unsigned(5 downto 0)
		);
	end component;
	
	component state_machine is
	port(
		clk : in std_logic;
		p1_start : in std_logic;
		p2_start : in std_logic;
		no_collision_p1 : in std_logic;
		no_collision_p2 : in std_logic;
		
		state_out : out unsigned(2 downto 0)
	);
	end component;
	
	component projectile_controller is
		port(
			clk : in std_logic;
			fired_in : in std_logic;

			ship_position_x : in unsigned(13 downto 0);
			ship_position_y : in unsigned(13 downto 0);
			rotation : in unsigned(5 downto 0);
			
			x_position_out1 : out unsigned(9 downto 0);
			y_position_out1 : out unsigned(9 downto 0);

			x_position_out2 : out unsigned(9 downto 0);
			y_position_out2 : out unsigned(9 downto 0);

			x_position_out3 : out unsigned(9 downto 0);
			y_position_out3 : out unsigned(9 downto 0);

			proj_alive : out std_logic_vector(2 downto 0)
		);
	end component;
	
	component asteroid is
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
	end component;

begin
	the_pll : mypll port map (ext_osc, '1', pll_tail, outglobal_o => clk);
	the_vga : vga port map (clk, valid, row, col, hsync, vsync);
	the_patterngen : pattern_gen 
		port map (clk => clk, 
				  vsync => vsync,
				  row => row, 
				  col => col, 
				  valid => valid, 
				  
				  -- ship 1 & 2
				  ship1_reset => ship1_reset, 
				  ship1_x => ship1_x(13 downto 4), 
				  ship1_y => ship1_y(13 downto 4) ,
				  ship1_rot => ship1_rot, 
				  ship2_reset => ship2_reset, 
				  ship2_x => ship2_x(13 downto 4), 
				  ship2_y => ship2_y(13 downto 4), 
				  ship2_rot => ship2_rot, 

				  -- ship state OUT
				  ship1_alive => ship1_alive, 
				  ship2_alive => ship2_alive, 
				  
				  -- ship 1 projectiles
				  ship1_proj1_x => ship1_proj1_x, 
				  ship1_proj1_y => ship1_proj1_y, 
				  ship1_proj2_x => ship1_proj2_x, 
				  ship1_proj2_y => ship1_proj2_y, 
				  ship1_proj3_x => ship1_proj3_x, 
				  ship1_proj3_y => ship1_proj3_y,
				  ship1_proj_alive => ship1_proj_alive,

				  -- ship 2 projectiles
				  ship2_proj1_x => ship2_proj1_x, 
				  ship2_proj1_y => ship2_proj1_y, 
				  ship2_proj2_x => ship2_proj2_x, 
				  ship2_proj2_y => ship2_proj2_y, 
				  ship2_proj3_x => ship2_proj3_x, 
				  ship2_proj3_y => ship2_proj3_y, 
				  ship2_proj_alive => ship2_proj_alive,
				  
				  asteroid1_x => asteroid1_x,
				  asteroid1_y => asteroid1_y,
				  asteroid2_x => asteroid2_x,
				  asteroid2_y => asteroid2_y,
				  asteroid3_x => asteroid3_x,
				  asteroid3_y => asteroid3_y,
				  
				  state => state,
				  rgb => rgb);


	tnes : nes port map (nes1_in, nes2_in, nes_latch, nes_clk_o, player1_input, player2_input);
	
	ship1 : ship port map(vsync, '1' when state = START else '0', '1', player1_input(6), '0', player1_input(1), player1_input(0), ship1_x, ship1_y, ship1_rot);
	ship2 : ship port map(vsync, '1' when state = START else '0', '0', player2_input(6), '0', player2_input(1), player2_input(0), ship2_x, ship2_y, ship2_rot);
	
	proj1 : projectile_controller port map(vsync, player1_input(7), ship1_x, ship1_y, ship1_rot, ship1_proj1_x, ship1_proj1_y, ship1_proj2_x, ship1_proj2_y, ship1_proj3_x, ship1_proj3_y, ship1_proj_alive);
	proj2 : projectile_controller port map(vsync, player2_input(7), ship2_x, ship2_y, ship2_rot, ship2_proj1_x, ship2_proj1_y, ship2_proj2_x, ship2_proj2_y, ship2_proj3_x, ship2_proj3_y, ship2_proj_alive);
	
	asteroid1 : asteroid port map(vsync, '1' when state = START else '0', 10d"140", 10d"160", to_signed(1, 10), to_signed(1, 10), asteroid1_x, asteroid1_y);
	asteroid2 : asteroid port map(vsync, '1' when state = START else '0', 10d"432", 10d"123", to_signed(1, 10), to_signed(-1, 10), asteroid2_x, asteroid2_y);
	asteroid3 : asteroid port map(vsync, '1' when state = START else '0', 10d"343", 10d"220", to_signed(-1, 10), to_signed(1, 10), asteroid3_x, asteroid3_y);

	the_state_machine : state_machine
		port map(clk => vsync,
				 p1_start => player1_input(4),
				 p2_start => player2_input(4),
				 no_collision_p1 => ship1_alive, -- TODO change to DEAD
				 no_collision_p2 => ship2_alive,
				 state_out => state);
	
	process (vsync) begin
		if rising_edge(vsync) then
			ship1_reset <= player1_input(4) when ship1_alive = '1' else '1';
			ship2_reset <= player2_input(4) when ship2_alive = '1' else '1';
		end if;
	end process;
	
	
	
	debug_tail <= ship1_alive;
end; 