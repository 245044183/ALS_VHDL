----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2019 03:17:10 PM
-- Design Name: 
-- Module Name: MASTER_TBENCH - Behavioral
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

entity MASTER_TBENCH is

end MASTER_TBENCH;

architecture Behavioral of MASTER_TBENCH is
component spi_master is
port (
    in_clk: in std_logic;      --FPGA clock
    --reset:  in std_logic;      --out sync reset
    enable: in std_logic;      --initiate trasaction
    -- (Master out Slave in) Signals
    out_data: out std_logic_vector(7 downto 0); --8 bit data from light sensor
    
    -- SPI interface
    out_sclk: out std_logic;        --pulses alternating with frequency of the chip
    in_MISO:in std_logic;           --single bit of data recieve from the sensor for 1 sclk cycle
    out_chip_select:out std_logic  --active low for ambient light sensor
);
end component;
signal    in_clk:  std_logic:='0';      --FPGA clock
--signal    reset:   std_logic;      --out sync reset
signal    enable:  std_logic;      --initiate trasaction
    -- (Master out Slave in) Signals
signal    out_data:  std_logic_vector(7 downto 0); --8 bit data from light sensor
    
    -- SPI interface
signal    out_sclk:  std_logic;        --pulses alternating with frequency of the chip
signal    in_MISO: std_logic;           --single bit of data recieve from the sensor for 1 sclk cycle
signal    out_chip_select: std_logic;  --active low for ambient light sensor

begin

uut: entity work.SPI_MASTER port map(
in_clk=>in_clk,
enable=>enable,
out_data=>out_data,
out_sclk=>out_sclk,
in_miso=>in_miso,
out_chip_select=>out_chip_select
);

in_clk<= not in_clk after 2 ns;










end Behavioral;
