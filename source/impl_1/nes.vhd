library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity nes is
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
end nes;

architecture synth of nes is
	component HSOSC is
		generic (CLKHF_DIV : String := "0b00");
		port (CLKHFPU : in std_logic := 'X';
			  CLKHFEN : in std_logic := 'X';
			  CLKHF : out std_logic := 'X');
	end component;

	signal clk : std_logic;
	signal nes_clk : std_logic;
	signal counter : unsigned(19 downto 0) := (others => '0');
	signal NESClk : std_logic;
	signal NESCount : unsigned(7 downto 0);
	signal shiftData1 : unsigned(7 downto 0);
	signal shiftData2 : unsigned(7 downto 0);
	
	signal nes_buffer1 : unsigned(7 downto 0);
	signal nes_buffer2 : unsigned(7 downto 0);

begin
	osc : HSOSC generic map (CLKHF_DIV => "0b00")
		  port map (CLKHFPU => '1', CLKHFEN => '1', CLKHF => clk);

	process (clk) is begin
	if rising_edge (clk) then
			counter <= counter + 1;
	end if;
    end process;
	  
	NESClk <= counter(8);
	NESCount <= counter(16 downto 9);

	latch <= '1' when NESCount = "11111111" else '0';
	nes_clk <= NESClk when (NESCount < 8) else '0';

	process (nes_clk) is begin
		if rising_edge (nes_clk) then
			  --shiftData(0) <= inputData;    --A
			  --shiftData(1) <= shiftData(0); --B
			  --shiftData(2) <= shiftData(1); --Select
			  --shiftData(3) <= shiftData(2); --Start
			  --shiftData(4) <= shiftData(3); --Up
			  --shiftData(5) <= shiftData(4); --Down
			  --shiftData(6) <= shiftData(5); --Left
			  --shiftData(7) <= shiftData(6); --Right
			  
			  shiftData1 <= shiftData1(6 downto 0) & inputData1;
			  shiftData2 <= shiftData2(6 downto 0) & inputData2;

			  
		 end if;
	 end process;
	 
	 process(clk) begin
		if rising_edge(clk) then
			  if NESCount = 8 then
				nes_buffer1 <= not shiftData1(7 downto 0);
				nes_buffer2 <= not shiftData2(7 downto 0);
			  end if;
		end if;
	 end process;
	 
	 nes_clk_out <= nes_clk;
      outputData1 <= nes_buffer1;
	  outputData2 <= nes_buffer2;
end;




