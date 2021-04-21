----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2019 03:17:54 PM
-- Design Name: 
-- Module Name: ALS_TBENCH - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALS_TBENCH is
--  Port ( );
end ALS_TBENCH;

architecture Behavioral of ALS_TBENCH is
component LIGHT_SENSOR is
port (
    enable: in std_logic:='0';
    in_clk: in std_logic:='0';
    out_sclk: out std_logic:='1';
    in_miso: in std_logic;
    out_chip_select:out std_logic:='1';
    y:out std_logic_vector(3 downto 0):=(others=>'0')
);
end component;
signal enable: std_logic;
signal in_clk: std_logic:='0';
signal out_sclk:std_logic:='1';
signal in_miso:std_logic;
signal out_chip_select:std_logic:='1';
signal y: std_logic_vector(3 downto 0):=(others=>'0');

begin
in_clk<= not in_clk after 2 ns;

uut: entity work.LIGHT_SENSOR 
port map(
in_clk=>in_clk,
enable=>enable,
y=>y,
out_sclk=>out_sclk,
in_miso=>in_miso,
out_chip_select=>out_chip_select
);
testing: process is
begin
wait for 200 ns;
enable<='1';

wait for 600 ns;
end process;

input: process is
begin
wait for 734 ns;--1
in_MISO<='0';
wait for 40 ns;--2
in_MISO<='0';
wait for 40 ns;--3
in_MISO<='0';
wait for 40 ns;--4
in_MISO<='1';
wait for 40 ns;--5
in_MISO<='1';
wait for 40 ns;
in_MISO<='1';
wait for 40 ns;
in_MISO<='1';
wait for 40 ns;
in_MISO<='1';
wait for 40 ns;--9
in_MISO<='1';
wait for 40 ns;
in_MISO<='1';
wait for 40 ns;
in_MISO<='0';
wait for 40 ns;
in_MISO<='0';
wait for 40 ns;--13
in_MISO<='0';
wait for 40 ns;
in_MISO<='0';
wait for 40 ns;--15
in_MISO<='0';

wait for 600 ns;
end process;
end Behavioral;
