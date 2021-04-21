----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2019 10:53:05 PM
-- Design Name: 
-- Module Name: SPI_MASTER - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SPI_MASTER is
Port ( 
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
    --the sclk idle high
    --data sent from sensor on rising edge of sclk
);
end entity SPI_MASTER;

architecture Behavioral of SPI_MASTER is
    -- state machine to control the master when to read the data
    --type state is (Ready,Transfer,Rest);--rest at at least 4 sclk cycles
    -- spi signals runs on spi clock
    signal sclk_count:integer range 0 to 17:=17;--sensor sends 16 bit data
    signal sclk_sig:std_logic:='1';              --pulses input to sensor

    -- count to generate spi clk

    signal count: std_logic_vector(4 downto 0):="00000"; --count to 20
    -- register to store data bit
    signal reg: std_logic_vector(14 downto 0):=(others=>'0');
    signal index:integer range 0 to 14:=1;
    signal out_chip_select_sig: std_logic:='1';
    signal ready:std_logic:='0';
    signal ready_count:integer range 0 to 400:=0;--count for delaying next reading

begin

ready_proc: process(in_clk)
begin
    if rising_edge(in_clk) then
        if ready_count=200 or (ready_count=0 and sclk_count=0) then
            ready<='1';
            ready_count<=0;
        
        elsif sclk_count=17  then
            ready_count<=ready_count +1 ;


        else 
            ready<='0';

        end if;
    end if;
end process;



slow_clock_proc:process(in_clk)
begin
    if rising_edge(in_clk) then
        if out_chip_select_sig ='0' then
                if count=20 then               --use 20 in real board, 1 in simulation
                    count<=(others=>'0');
                    sclk_sig<= not sclk_sig;
    
                else
                    count<=count+1;
                end if;
        else
            sclk_sig<='1';
        end if;
    end if;
end process slow_clock_proc;


count_proc: process(sclk_sig)--20 high,20 low
begin
    if falling_edge(sclk_sig) then
        if enable='1' or sclk_count >=0 then
        
            if sclk_count=17 and out_chip_select_sig='0' then           -- 16 clock cycle to read data
                sclk_count<=0;
            else
                sclk_count<=sclk_count+1;

            end if;
            
        end if;
        
     end if;
end process count_proc;
out_chip_select_sig<='0' when enable='1' and ready='1' else 
                 '1' when sclk_count=17 ;    


load_proc: process(sclk_sig)
begin
if rising_edge(sclk_sig) then
    if sclk_count<=14 and sclk_count>0 then
    index<=index+1;   
    reg(14-index)<=in_miso;
    elsif sclk_count=17 then
    index<=0;
    
    end if;
end if;    
end process;

--loading data to a register
out_sclk<=sclk_sig;
out_data<=reg(11 downto 4);                 --register have the light data
out_chip_select<=out_chip_select_sig;


end Behavioral;
