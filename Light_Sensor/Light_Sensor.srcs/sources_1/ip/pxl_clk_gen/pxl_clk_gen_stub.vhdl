-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sun Dec  1 17:32:27 2019
-- Host        : DESKTOP-BLRKV0P running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               i:/Light_Sensor/Light_Sensor.srcs/sources_1/ip/pxl_clk_gen/pxl_clk_gen_stub.vhdl
-- Design      : pxl_clk_gen
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pxl_clk_gen is
  Port ( 
    clk_out1 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end pxl_clk_gen;

architecture stub of pxl_clk_gen is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out1,reset,locked,clk_in1";
begin
end;
