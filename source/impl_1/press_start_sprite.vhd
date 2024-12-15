-- autogenerated from logos/press_start.png
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity press_start_sprite is
    port(
		clk : in std_logic;
        x : in unsigned(5 downto 0); -- 0 to 54
        y : in unsigned(2 downto 0); -- 0 to 4
        
        rgb : out std_logic_vector(5 downto 0)
    );
end press_start_sprite;

architecture synth of press_start_sprite is

signal ymul : unsigned(8 downto 0);
signal linear_position : unsigned(11 downto 0);

signal color_index : unsigned(1 downto 0);

begin
    ymul <= y * 6b"110111";
    linear_position <= x + ("000" & ymul); -- 0 to 274

    process(clk) begin
	if rising_edge(clk) then
        case linear_position(8 downto 0) is
			when 9x"00" => color_index <= 2d"0"; -- (0, 0, 0)
			when 9x"37" => color_index <= 2d"0"; -- (0, 1, 0)
			when 9x"6e" => color_index <= 2d"0"; -- (0, 2, 0)
			when 9x"a5" => color_index <= 2d"0"; -- (0, 3, 0)
			when 9x"dc" => color_index <= 2d"0"; -- (0, 4, 0)
			when 9x"01" => color_index <= 2d"0"; -- (1, 0, 0)
			when 9x"38" => color_index <= 2d"1"; -- (1, 1, 0)
			when 9x"6f" => color_index <= 2d"0"; -- (1, 2, 0)
			when 9x"a6" => color_index <= 2d"1"; -- (1, 3, 0)
			when 9x"dd" => color_index <= 2d"1"; -- (1, 4, 0)
			when 9x"02" => color_index <= 2d"0"; -- (2, 0, 0)
			when 9x"39" => color_index <= 2d"2"; -- (2, 1, 0)
			when 9x"70" => color_index <= 2d"0"; -- (2, 2, 0)
			when 9x"a7" => color_index <= 2d"2"; -- (2, 3, 0)
			when 9x"de" => color_index <= 2d"2"; -- (2, 4, 0)
			when 9x"03" => color_index <= 2d"1"; -- (3, 0, 0)
			when 9x"3a" => color_index <= 2d"0"; -- (3, 1, 0)
			when 9x"71" => color_index <= 2d"1"; -- (3, 2, 0)
			when 9x"a8" => color_index <= 2d"2"; -- (3, 3, 0)
			when 9x"df" => color_index <= 2d"2"; -- (3, 4, 0)
			when 9x"04" => color_index <= 2d"2"; -- (4, 0, 0)
			when 9x"3b" => color_index <= 2d"1"; -- (4, 1, 0)
			when 9x"72" => color_index <= 2d"2"; -- (4, 2, 0)
			when 9x"a9" => color_index <= 2d"2"; -- (4, 3, 0)
			when 9x"e0" => color_index <= 2d"2"; -- (4, 4, 0)
			when 9x"05" => color_index <= 2d"0"; -- (5, 0, 0)
			when 9x"3c" => color_index <= 2d"0"; -- (5, 1, 0)
			when 9x"73" => color_index <= 2d"0"; -- (5, 2, 0)
			when 9x"aa" => color_index <= 2d"0"; -- (5, 3, 0)
			when 9x"e1" => color_index <= 2d"0"; -- (5, 4, 0)
			when 9x"06" => color_index <= 2d"0"; -- (6, 0, 0)
			when 9x"3d" => color_index <= 2d"1"; -- (6, 1, 0)
			when 9x"74" => color_index <= 2d"0"; -- (6, 2, 0)
			when 9x"ab" => color_index <= 2d"1"; -- (6, 3, 0)
			when 9x"e2" => color_index <= 2d"1"; -- (6, 4, 0)
			when 9x"07" => color_index <= 2d"0"; -- (7, 0, 0)
			when 9x"3e" => color_index <= 2d"2"; -- (7, 1, 0)
			when 9x"75" => color_index <= 2d"0"; -- (7, 2, 0)
			when 9x"ac" => color_index <= 2d"0"; -- (7, 3, 0)
			when 9x"e3" => color_index <= 2d"2"; -- (7, 4, 0)
			when 9x"08" => color_index <= 2d"1"; -- (8, 0, 0)
			when 9x"3f" => color_index <= 2d"0"; -- (8, 1, 0)
			when 9x"76" => color_index <= 2d"1"; -- (8, 2, 0)
			when 9x"ad" => color_index <= 2d"1"; -- (8, 3, 0)
			when 9x"e4" => color_index <= 2d"0"; -- (8, 4, 0)
			when 9x"09" => color_index <= 2d"2"; -- (9, 0, 0)
			when 9x"40" => color_index <= 2d"1"; -- (9, 1, 0)
			when 9x"77" => color_index <= 2d"2"; -- (9, 2, 0)
			when 9x"ae" => color_index <= 2d"2"; -- (9, 3, 0)
			when 9x"e5" => color_index <= 2d"1"; -- (9, 4, 0)
			when 9x"0a" => color_index <= 2d"0"; -- (10, 0, 0)
			when 9x"41" => color_index <= 2d"0"; -- (10, 1, 0)
			when 9x"78" => color_index <= 2d"0"; -- (10, 2, 0)
			when 9x"af" => color_index <= 2d"0"; -- (10, 3, 0)
			when 9x"e6" => color_index <= 2d"0"; -- (10, 4, 0)
			when 9x"0b" => color_index <= 2d"0"; -- (11, 0, 0)
			when 9x"42" => color_index <= 2d"1"; -- (11, 1, 0)
			when 9x"79" => color_index <= 2d"0"; -- (11, 2, 0)
			when 9x"b0" => color_index <= 2d"1"; -- (11, 3, 0)
			when 9x"e7" => color_index <= 2d"0"; -- (11, 4, 0)
			when 9x"0c" => color_index <= 2d"0"; -- (12, 0, 0)
			when 9x"43" => color_index <= 2d"2"; -- (12, 1, 0)
			when 9x"7a" => color_index <= 2d"0"; -- (12, 2, 0)
			when 9x"b1" => color_index <= 2d"2"; -- (12, 3, 0)
			when 9x"e8" => color_index <= 2d"0"; -- (12, 4, 0)
			when 9x"0d" => color_index <= 2d"0"; -- (13, 0, 0)
			when 9x"44" => color_index <= 2d"2"; -- (13, 1, 0)
			when 9x"7b" => color_index <= 2d"1"; -- (13, 2, 0)
			when 9x"b2" => color_index <= 2d"2"; -- (13, 3, 0)
			when 9x"e9" => color_index <= 2d"0"; -- (13, 4, 0)
			when 9x"0e" => color_index <= 2d"1"; -- (14, 0, 0)
			when 9x"45" => color_index <= 2d"2"; -- (14, 1, 0)
			when 9x"7c" => color_index <= 2d"2"; -- (14, 2, 0)
			when 9x"b3" => color_index <= 2d"2"; -- (14, 3, 0)
			when 9x"ea" => color_index <= 2d"1"; -- (14, 4, 0)
			when 9x"0f" => color_index <= 2d"2"; -- (15, 0, 0)
			when 9x"46" => color_index <= 2d"0"; -- (15, 1, 0)
			when 9x"7d" => color_index <= 2d"2"; -- (15, 2, 0)
			when 9x"b4" => color_index <= 2d"2"; -- (15, 3, 0)
			when 9x"eb" => color_index <= 2d"0"; -- (15, 4, 0)
			when 9x"10" => color_index <= 2d"0"; -- (16, 0, 0)
			when 9x"47" => color_index <= 2d"1"; -- (16, 1, 0)
			when 9x"7e" => color_index <= 2d"0"; -- (16, 2, 0)
			when 9x"b5" => color_index <= 2d"2"; -- (16, 3, 0)
			when 9x"ec" => color_index <= 2d"0"; -- (16, 4, 0)
			when 9x"11" => color_index <= 2d"0"; -- (17, 0, 0)
			when 9x"48" => color_index <= 2d"1"; -- (17, 1, 0)
			when 9x"7f" => color_index <= 2d"0"; -- (17, 2, 0)
			when 9x"b6" => color_index <= 2d"2"; -- (17, 3, 0)
			when 9x"ed" => color_index <= 2d"0"; -- (17, 4, 0)
			when 9x"12" => color_index <= 2d"0"; -- (18, 0, 0)
			when 9x"49" => color_index <= 2d"2"; -- (18, 1, 0)
			when 9x"80" => color_index <= 2d"1"; -- (18, 2, 0)
			when 9x"b7" => color_index <= 2d"0"; -- (18, 3, 0)
			when 9x"ee" => color_index <= 2d"1"; -- (18, 4, 0)
			when 9x"13" => color_index <= 2d"1"; -- (19, 0, 0)
			when 9x"4a" => color_index <= 2d"2"; -- (19, 1, 0)
			when 9x"81" => color_index <= 2d"2"; -- (19, 2, 0)
			when 9x"b8" => color_index <= 2d"1"; -- (19, 3, 0)
			when 9x"ef" => color_index <= 2d"2"; -- (19, 4, 0)
			when 9x"14" => color_index <= 2d"2"; -- (20, 0, 0)
			when 9x"4b" => color_index <= 2d"0"; -- (20, 1, 0)
			when 9x"82" => color_index <= 2d"2"; -- (20, 2, 0)
			when 9x"b9" => color_index <= 2d"2"; -- (20, 3, 0)
			when 9x"f0" => color_index <= 2d"0"; -- (20, 4, 0)
			when 9x"15" => color_index <= 2d"0"; -- (21, 0, 0)
			when 9x"4c" => color_index <= 2d"1"; -- (21, 1, 0)
			when 9x"83" => color_index <= 2d"0"; -- (21, 2, 0)
			when 9x"ba" => color_index <= 2d"2"; -- (21, 3, 0)
			when 9x"f1" => color_index <= 2d"0"; -- (21, 4, 0)
			when 9x"16" => color_index <= 2d"0"; -- (22, 0, 0)
			when 9x"4d" => color_index <= 2d"1"; -- (22, 1, 0)
			when 9x"84" => color_index <= 2d"0"; -- (22, 2, 0)
			when 9x"bb" => color_index <= 2d"2"; -- (22, 3, 0)
			when 9x"f2" => color_index <= 2d"0"; -- (22, 4, 0)
			when 9x"17" => color_index <= 2d"0"; -- (23, 0, 0)
			when 9x"4e" => color_index <= 2d"2"; -- (23, 1, 0)
			when 9x"85" => color_index <= 2d"1"; -- (23, 2, 0)
			when 9x"bc" => color_index <= 2d"0"; -- (23, 3, 0)
			when 9x"f3" => color_index <= 2d"1"; -- (23, 4, 0)
			when 9x"18" => color_index <= 2d"1"; -- (24, 0, 0)
			when 9x"4f" => color_index <= 2d"2"; -- (24, 1, 0)
			when 9x"86" => color_index <= 2d"2"; -- (24, 2, 0)
			when 9x"bd" => color_index <= 2d"1"; -- (24, 3, 0)
			when 9x"f4" => color_index <= 2d"2"; -- (24, 4, 0)
			when 9x"19" => color_index <= 2d"2"; -- (25, 0, 0)
			when 9x"50" => color_index <= 2d"2"; -- (25, 1, 0)
			when 9x"87" => color_index <= 2d"2"; -- (25, 2, 0)
			when 9x"be" => color_index <= 2d"2"; -- (25, 3, 0)
			when 9x"f5" => color_index <= 2d"2"; -- (25, 4, 0)
			when 9x"1a" => color_index <= 2d"2"; -- (26, 0, 0)
			when 9x"51" => color_index <= 2d"2"; -- (26, 1, 0)
			when 9x"88" => color_index <= 2d"2"; -- (26, 2, 0)
			when 9x"bf" => color_index <= 2d"2"; -- (26, 3, 0)
			when 9x"f6" => color_index <= 2d"2"; -- (26, 4, 0)
			when 9x"1b" => color_index <= 2d"2"; -- (27, 0, 0)
			when 9x"52" => color_index <= 2d"0"; -- (27, 1, 0)
			when 9x"89" => color_index <= 2d"2"; -- (27, 2, 0)
			when 9x"c0" => color_index <= 2d"2"; -- (27, 3, 0)
			when 9x"f7" => color_index <= 2d"0"; -- (27, 4, 0)
			when 9x"1c" => color_index <= 2d"0"; -- (28, 0, 0)
			when 9x"53" => color_index <= 2d"1"; -- (28, 1, 0)
			when 9x"8a" => color_index <= 2d"0"; -- (28, 2, 0)
			when 9x"c1" => color_index <= 2d"2"; -- (28, 3, 0)
			when 9x"f8" => color_index <= 2d"0"; -- (28, 4, 0)
			when 9x"1d" => color_index <= 2d"0"; -- (29, 0, 0)
			when 9x"54" => color_index <= 2d"1"; -- (29, 1, 0)
			when 9x"8b" => color_index <= 2d"0"; -- (29, 2, 0)
			when 9x"c2" => color_index <= 2d"2"; -- (29, 3, 0)
			when 9x"f9" => color_index <= 2d"0"; -- (29, 4, 0)
			when 9x"1e" => color_index <= 2d"0"; -- (30, 0, 0)
			when 9x"55" => color_index <= 2d"2"; -- (30, 1, 0)
			when 9x"8c" => color_index <= 2d"1"; -- (30, 2, 0)
			when 9x"c3" => color_index <= 2d"0"; -- (30, 3, 0)
			when 9x"fa" => color_index <= 2d"1"; -- (30, 4, 0)
			when 9x"1f" => color_index <= 2d"1"; -- (31, 0, 0)
			when 9x"56" => color_index <= 2d"2"; -- (31, 1, 0)
			when 9x"8d" => color_index <= 2d"2"; -- (31, 2, 0)
			when 9x"c4" => color_index <= 2d"1"; -- (31, 3, 0)
			when 9x"fb" => color_index <= 2d"2"; -- (31, 4, 0)
			when 9x"20" => color_index <= 2d"0"; -- (32, 0, 0)
			when 9x"57" => color_index <= 2d"2"; -- (32, 1, 0)
			when 9x"8e" => color_index <= 2d"2"; -- (32, 2, 0)
			when 9x"c5" => color_index <= 2d"2"; -- (32, 3, 0)
			when 9x"fc" => color_index <= 2d"2"; -- (32, 4, 0)
			when 9x"21" => color_index <= 2d"0"; -- (33, 0, 0)
			when 9x"58" => color_index <= 2d"2"; -- (33, 1, 0)
			when 9x"8f" => color_index <= 2d"2"; -- (33, 2, 0)
			when 9x"c6" => color_index <= 2d"2"; -- (33, 3, 0)
			when 9x"fd" => color_index <= 2d"2"; -- (33, 4, 0)
			when 9x"22" => color_index <= 2d"0"; -- (34, 0, 0)
			when 9x"59" => color_index <= 2d"0"; -- (34, 1, 0)
			when 9x"90" => color_index <= 2d"0"; -- (34, 2, 0)
			when 9x"c7" => color_index <= 2d"0"; -- (34, 3, 0)
			when 9x"fe" => color_index <= 2d"0"; -- (34, 4, 0)
			when 9x"23" => color_index <= 2d"0"; -- (35, 0, 0)
			when 9x"5a" => color_index <= 2d"1"; -- (35, 1, 0)
			when 9x"91" => color_index <= 2d"1"; -- (35, 2, 0)
			when 9x"c8" => color_index <= 2d"1"; -- (35, 3, 0)
			when 9x"ff" => color_index <= 2d"1"; -- (35, 4, 0)
			when 9x"24" => color_index <= 2d"0"; -- (36, 0, 0)
			when 9x"5b" => color_index <= 2d"2"; -- (36, 1, 0)
			when 9x"92" => color_index <= 2d"2"; -- (36, 2, 0)
			when 9x"c9" => color_index <= 2d"2"; -- (36, 3, 0)
			when 9x"100" => color_index <= 2d"2"; -- (36, 4, 0)
			when 9x"25" => color_index <= 2d"1"; -- (37, 0, 0)
			when 9x"5c" => color_index <= 2d"2"; -- (37, 1, 0)
			when 9x"93" => color_index <= 2d"2"; -- (37, 2, 0)
			when 9x"ca" => color_index <= 2d"2"; -- (37, 3, 0)
			when 9x"101" => color_index <= 2d"2"; -- (37, 4, 0)
			when 9x"26" => color_index <= 2d"2"; -- (38, 0, 0)
			when 9x"5d" => color_index <= 2d"0"; -- (38, 1, 0)
			when 9x"94" => color_index <= 2d"0"; -- (38, 2, 0)
			when 9x"cb" => color_index <= 2d"0"; -- (38, 3, 0)
			when 9x"102" => color_index <= 2d"0"; -- (38, 4, 0)
			when 9x"27" => color_index <= 2d"0"; -- (39, 0, 0)
			when 9x"5e" => color_index <= 2d"1"; -- (39, 1, 0)
			when 9x"95" => color_index <= 2d"0"; -- (39, 2, 0)
			when 9x"cc" => color_index <= 2d"1"; -- (39, 3, 0)
			when 9x"103" => color_index <= 2d"1"; -- (39, 4, 0)
			when 9x"28" => color_index <= 2d"0"; -- (40, 0, 0)
			when 9x"5f" => color_index <= 2d"2"; -- (40, 1, 0)
			when 9x"96" => color_index <= 2d"0"; -- (40, 2, 0)
			when 9x"cd" => color_index <= 2d"2"; -- (40, 3, 0)
			when 9x"104" => color_index <= 2d"2"; -- (40, 4, 0)
			when 9x"29" => color_index <= 2d"1"; -- (41, 0, 0)
			when 9x"60" => color_index <= 2d"0"; -- (41, 1, 0)
			when 9x"97" => color_index <= 2d"0"; -- (41, 2, 0)
			when 9x"ce" => color_index <= 2d"0"; -- (41, 3, 0)
			when 9x"105" => color_index <= 2d"0"; -- (41, 4, 0)
			when 9x"2a" => color_index <= 2d"2"; -- (42, 0, 0)
			when 9x"61" => color_index <= 2d"1"; -- (42, 1, 0)
			when 9x"98" => color_index <= 2d"1"; -- (42, 2, 0)
			when 9x"cf" => color_index <= 2d"1"; -- (42, 3, 0)
			when 9x"106" => color_index <= 2d"1"; -- (42, 4, 0)
			when 9x"2b" => color_index <= 2d"2"; -- (43, 0, 0)
			when 9x"62" => color_index <= 2d"2"; -- (43, 1, 0)
			when 9x"99" => color_index <= 2d"2"; -- (43, 2, 0)
			when 9x"d0" => color_index <= 2d"2"; -- (43, 3, 0)
			when 9x"107" => color_index <= 2d"2"; -- (43, 4, 0)
			when 9x"2c" => color_index <= 2d"0"; -- (44, 0, 0)
			when 9x"63" => color_index <= 2d"0"; -- (44, 1, 0)
			when 9x"9a" => color_index <= 2d"0"; -- (44, 2, 0)
			when 9x"d1" => color_index <= 2d"0"; -- (44, 3, 0)
			when 9x"108" => color_index <= 2d"0"; -- (44, 4, 0)
			when 9x"2d" => color_index <= 2d"0"; -- (45, 0, 0)
			when 9x"64" => color_index <= 2d"1"; -- (45, 1, 0)
			when 9x"9b" => color_index <= 2d"0"; -- (45, 2, 0)
			when 9x"d2" => color_index <= 2d"1"; -- (45, 3, 0)
			when 9x"109" => color_index <= 2d"1"; -- (45, 4, 0)
			when 9x"2e" => color_index <= 2d"0"; -- (46, 0, 0)
			when 9x"65" => color_index <= 2d"2"; -- (46, 1, 0)
			when 9x"9c" => color_index <= 2d"0"; -- (46, 2, 0)
			when 9x"d3" => color_index <= 2d"0"; -- (46, 3, 0)
			when 9x"10a" => color_index <= 2d"2"; -- (46, 4, 0)
			when 9x"2f" => color_index <= 2d"1"; -- (47, 0, 0)
			when 9x"66" => color_index <= 2d"0"; -- (47, 1, 0)
			when 9x"9d" => color_index <= 2d"1"; -- (47, 2, 0)
			when 9x"d4" => color_index <= 2d"1"; -- (47, 3, 0)
			when 9x"10b" => color_index <= 2d"0"; -- (47, 4, 0)
			when 9x"30" => color_index <= 2d"2"; -- (48, 0, 0)
			when 9x"67" => color_index <= 2d"1"; -- (48, 1, 0)
			when 9x"9e" => color_index <= 2d"2"; -- (48, 2, 0)
			when 9x"d5" => color_index <= 2d"2"; -- (48, 3, 0)
			when 9x"10c" => color_index <= 2d"1"; -- (48, 4, 0)
			when 9x"31" => color_index <= 2d"0"; -- (49, 0, 0)
			when 9x"68" => color_index <= 2d"2"; -- (49, 1, 0)
			when 9x"9f" => color_index <= 2d"2"; -- (49, 2, 0)
			when 9x"d6" => color_index <= 2d"2"; -- (49, 3, 0)
			when 9x"10d" => color_index <= 2d"2"; -- (49, 4, 0)
			when 9x"32" => color_index <= 2d"0"; -- (50, 0, 0)
			when 9x"69" => color_index <= 2d"2"; -- (50, 1, 0)
			when 9x"a0" => color_index <= 2d"2"; -- (50, 2, 0)
			when 9x"d7" => color_index <= 2d"2"; -- (50, 3, 0)
			when 9x"10e" => color_index <= 2d"2"; -- (50, 4, 0)
			when 9x"33" => color_index <= 2d"0"; -- (51, 0, 0)
			when 9x"6a" => color_index <= 2d"0"; -- (51, 1, 0)
			when 9x"a1" => color_index <= 2d"0"; -- (51, 2, 0)
			when 9x"d8" => color_index <= 2d"0"; -- (51, 3, 0)
			when 9x"10f" => color_index <= 2d"0"; -- (51, 4, 0)
			when 9x"34" => color_index <= 2d"0"; -- (52, 0, 0)
			when 9x"6b" => color_index <= 2d"1"; -- (52, 1, 0)
			when 9x"a2" => color_index <= 2d"1"; -- (52, 2, 0)
			when 9x"d9" => color_index <= 2d"1"; -- (52, 3, 0)
			when 9x"110" => color_index <= 2d"1"; -- (52, 4, 0)
			when 9x"35" => color_index <= 2d"0"; -- (53, 0, 0)
			when 9x"6c" => color_index <= 2d"2"; -- (53, 1, 0)
			when 9x"a3" => color_index <= 2d"2"; -- (53, 2, 0)
			when 9x"da" => color_index <= 2d"2"; -- (53, 3, 0)
			when 9x"111" => color_index <= 2d"2"; -- (53, 4, 0)
			when 9x"36" => color_index <= 2d"1"; -- (54, 0, 0)
			when 9x"6d" => color_index <= 2d"2"; -- (54, 1, 0)
			when 9x"a4" => color_index <= 2d"2"; -- (54, 2, 0)
			when 9x"db" => color_index <= 2d"2"; -- (54, 3, 0)
			when 9x"112" => color_index <= 2d"2"; -- (54, 4, 0)
			when others => color_index <= 2d"0";
        end case;

        case color_index is
			when 2d"0" => rgb <= "111111"; -- (3, 3, 3)
			when 2d"1" => rgb <= "101010"; -- (1, 1, 1)
			when 2d"2" => rgb <= "000000"; -- (0, 0, 0)
           when others => rgb <= "000000";
           end case;
	end if;
    end process;
end synth;
