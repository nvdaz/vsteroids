-- autogenerated from in2.png (rotation 0)
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ship_spritee is
    port(
        x : in unsigned(4 downto 0); -- 0 to 19
        y : in unsigned(4 downto 0); -- 0 to 19
        bitmap : out std_logic
    );
end ship_spritee;

architecture synth of ship_spritee is

signal linear_position : unsigned(8 downto 0);
	signal ywide : unsigned(8 downto 0);
begin
	ywide <= "0000" & y;
    linear_position <= "0000" & x + ywide+ywide+ywide+ywide+ywide+ywide+ywide+ywide+ywide+ywide+ywide+ywide+ywide+ywide+ywide+ywide+ywide+ywide+ywide+ywide; -- x20 TODO shift 4 + shift 2 
    with linear_position select bitmap <=
				'1' when "000011101",
				'1' when "000011110",
				'1' when "000110000",
				'1' when "000110001",
				'1' when "000110010",
				'1' when "000110011",
				'1' when "001000010",
				'1' when "001000011",
				'1' when "001000100",
				'1' when "001000101",
				'1' when "001000110",
				'1' when "001000111",
				'1' when "001001000",
				'1' when "001001001",
				'1' when "001010110",
				'1' when "001010111",
				'1' when "001011000",
				'1' when "001011001",
				'1' when "001011010",
				'1' when "001011011",
				'1' when "001011100",
				'1' when "001011101",
				'1' when "001101010",
				'1' when "001101011",
				'1' when "001101100",
				'1' when "001101101",
				'1' when "001101110",
				'1' when "001101111",
				'1' when "001110000",
				'1' when "001110001",
				'1' when "001111101",
				'1' when "001111110",
				'1' when "001111111",
				'1' when "010000000",
				'1' when "010000001",
				'1' when "010000010",
				'1' when "010000011",
				'1' when "010000100",
				'1' when "010000101",
				'1' when "010000110",
				'1' when "010010001",
				'1' when "010010010",
				'1' when "010010011",
				'1' when "010010100",
				'1' when "010010101",
				'1' when "010010110",
				'1' when "010010111",
				'1' when "010011000",
				'1' when "010011001",
				'1' when "010011010",
				'1' when "010100101",
				'1' when "010100110",
				'1' when "010100111",
				'1' when "010101000",
				'1' when "010101001",
				'1' when "010101010",
				'1' when "010101011",
				'1' when "010101100",
				'1' when "010101101",
				'1' when "010101110",
				'1' when "010111000",
				'1' when "010111001",
				'1' when "010111010",
				'1' when "010111011",
				'1' when "010111100",
				'1' when "010111101",
				'1' when "010111110",
				'1' when "010111111",
				'1' when "011000000",
				'1' when "011000001",
				'1' when "011000010",
				'1' when "011000011",
				'1' when "011001100",
				'1' when "011001101",
				'1' when "011001110",
				'1' when "011001111",
				'1' when "011010000",
				'1' when "011010001",
				'1' when "011010010",
				'1' when "011010011",
				'1' when "011010100",
				'1' when "011010101",
				'1' when "011010110",
				'1' when "011010111",
				'1' when "011100000",
				'1' when "011100001",
				'1' when "011100010",
				'1' when "011100011",
				'1' when "011100100",
				'1' when "011100101",
				'1' when "011100110",
				'1' when "011100111",
				'1' when "011101000",
				'1' when "011101001",
				'1' when "011101010",
				'1' when "011101011",
				'1' when "011110011",
				'1' when "011110100",
				'1' when "011110101",
				'1' when "011110110",
				'1' when "011110111",
				'1' when "011111000",
				'1' when "011111001",
				'1' when "011111010",
				'1' when "011111011",
				'1' when "011111100",
				'1' when "011111101",
				'1' when "011111110",
				'1' when "011111111",
				'1' when "100000000",
				'1' when "100000111",
				'1' when "100001000",
				'1' when "100001001",
				'1' when "100001010",
				'1' when "100001011",
				'1' when "100001100",
				'1' when "100001111",
				'1' when "100010000",
				'1' when "100010001",
				'1' when "100010010",
				'1' when "100010011",
				'1' when "100010100",
				'1' when "100011011",
				'1' when "100011100",
				'1' when "100011101",
				'1' when "100011110",
				'1' when "100011111",
				'1' when "100100100",
				'1' when "100100101",
				'1' when "100100110",
				'1' when "100100111",
				'1' when "100101000",
				'1' when "100101111",
				'1' when "100110000",
				'1' when "100110001",
				'1' when "100110010",
				'1' when "100111001",
				'1' when "100111010",
				'1' when "100111011",
				'1' when "100111100",
				'1' when "101000011",
				'1' when "101000100",
				'1' when "101000101",
				'1' when "101001110",
				'1' when "101001111",
				'1' when "101010000",
				'0' when others;
end synth;
    