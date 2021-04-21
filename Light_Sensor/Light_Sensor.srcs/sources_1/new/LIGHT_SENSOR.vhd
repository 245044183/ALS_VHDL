----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2019 10:52:43 PM
-- Design Name: 
-- Module Name: LIGHT_SENSOR - Behavioral
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LIGHT_SENSOR is
Port ( 
    --control signal
    enable: in std_logic:='0';
    reset_btn   : in std_logic;
    in_clk: in std_logic:='0';
    out_sclk: out std_logic:='1';
    in_miso: in std_logic;
    out_chip_select:out std_logic:='1';
    y:out std_logic_vector(3 downto 0):=(others=>'0');
    TMDS,TMDSB:out std_logic_vector(3 downto 0)
);
end entity LIGHT_SENSOR;

architecture Behavioral of LIGHT_SENSOR is
component SPI_MASTER is
port(
    -- Data Signal from master
    in_clk: in std_logic;      --FPGA clock
    --   reset:  in std_logic;      --out sync reset
    enable: in std_logic;      --initiate trasaction
    -- (Master out Slave in) Signals
    out_data: out std_logic_vector(7 downto 0):=(others=>'0'); --8 bit data from light sensor
    
    -- SPI interface
    out_sclk: out std_logic;        --pulses alternating with frequency of the chip
    in_MISO:in std_logic;           --single bit of data recieve from the sensor for 1 sclk cycle


    out_chip_select:out std_logic  --active low for ambient light sensor
    );
end component SPI_MASTER;

component Lab5 is
    Port ( sys_clk : in std_logic;
          reset_btn   : in std_logic;
          light_index: in std_logic_vector(7 downto 0):=(others=>'0');
          TMDS, TMDSB : out std_logic_vector(3 downto 0));

end component Lab5;
    

--storing information from SPI
signal out_data:std_logic_vector(7 downto 0);
--counting signal

signal sclk_sig: std_logic:='1';
signal count:integer range 0 to 16;
signal out_chip_select_sig: std_logic:='1';

signal led:std_logic_vector(3 downto 0):=(others=>'0');
signal led_count:integer range 0 to 125000000:=0;

begin
Lab5_portmap:Lab5
port map(
    sys_clk=>in_clk,
    reset_btn=>reset_btn,
    TMDS=>TMDS,
    TMDSB=>TMDSB,
    light_index=>out_data
);
SPI_MASTER_portmap:SPI_MASTER
port map(
    in_clk=>in_clk,
    out_sclk=>sclk_sig,
    enable=>enable,
    out_data=>out_data,
    in_miso=>in_miso,
    out_chip_select=>out_chip_select_sig
    );
    out_sclk<=sclk_sig;
    out_chip_select<=out_chip_select_sig;
    

LED_flag_proc:process(in_clk)
begin
if rising_edge(in_clk) then
    if out_chip_select_sig='1' then
        if out_data>0 and out_data<50 then
                led<="0001";
            elsif out_data>=50 and out_data<100 then
                led<="0011";
            elsif out_data>=100 and out_data<150 then
                led<="0111";
            elsif out_data>=150 and out_data<=255 then
                led<="1111";
            else
                led<="0000";
            end if;
    else
        led<=led;

    end if;
end if;
end process;
        y<=led;   
     
 
end Behavioral;















