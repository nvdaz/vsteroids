library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga is
	port (
		clk : in std_logic;
		valid : out std_logic;
		row : out unsigned(9 downto 0);
		col : out unsigned(9 downto 0);
		hsync : out std_logic;
		vsync : out std_logic
	);
end;

architecture synth of vga is
	signal rowcount : unsigned(9 downto 0);
	signal colcount : unsigned(9 downto 0);
begin	
	process (clk) begin 
	if rising_edge(clk) then
		if (colcount >= 799) then 
			colcount <= "0000000000";
			rowcount <= rowcount + "1";
		else 
			colcount <= colcount + "1";
		end if;

		if (rowcount >= 524) then 
			rowcount <= "0000000000";
		end if;
	end if; 
	end process;
		 
	hsync <= '0' when (656 <= colcount and colcount < 752) else '1';
	vsync <= '0' when (490 <= rowcount and rowcount < 492) else '1';
	valid <= '1' when colcount < 640 and rowcount < 480 else '0';

	col <= colcount;
	row <= rowcount;
end;