library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity state_machine is
port(
    clk : in std_logic;
    p1_start : in std_logic;
    p2_start : in std_logic;
    no_collision_p1 : in std_logic;
    no_collision_p2 : in std_logic;
	
	state_out : out unsigned(2 downto 0)
);
end state_machine;

architecture synth of state_machine is
	constant START : unsigned(2 downto 0) := 3d"0";
	constant GAME : unsigned(2 downto 0) := 3d"1";
	constant P1W : unsigned(2 downto 0) := 3d"2";
	constant P2W : unsigned(2 downto 0) := 3d"3";
	constant TIE : unsigned(2 downto 0) := 3d"4";

	signal xor_out : std_logic;
	signal ff1_out : std_logic;
	signal s : unsigned(2 downto 0);
	
	signal wasp1_start, wasp2_start : std_logic;
begin
	
	state_out <= s;

  process (clk) is begin
  if rising_edge(clk) then 
		wasp1_start <= p1_start;
		wasp2_start <= p2_start;
	  case s is
		when START =>   
			if (p1_start = '1' and wasp1_start = '0') or (p2_start = '1' and wasp2_start = '0') then
				s <= GAME;
			end if;
		when GAME =>
			if no_collision_p1 = '0' and no_collision_p2 = '0' then
				s <= TIE;
			elsif no_collision_p1 = '0' then
				s <= P2W;
			elsif no_collision_p2 = '0' then
				s <= P1W;
			end if;
		when P1W => --render p1 win until start is pressed
			if p1_start = '1' or p2_start = '1' then
				s <= START;
			end if;
		when P2W => --render p2 win until start is pressed
			if p1_start = '1'  or p2_start = '1' then
				s <= START;
			end if;
		when TIE => --render tie win start is pressed
			if p1_start = '1' or p2_start = '1' then
				s <= START;
			end if;
		when others =>
			s <= START;
		end case;
  end if;
  end process;
end synth;

