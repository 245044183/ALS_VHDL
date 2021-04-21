vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../ipstatic" \
"D:/schoolsoftware/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"D:/schoolsoftware/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" \
"../../../../Light_Sensor.srcs/sources_1/ip/pxl_clk_gen/pxl_clk_gen_clk_wiz.v" \
"../../../../Light_Sensor.srcs/sources_1/ip/pxl_clk_gen/pxl_clk_gen.v" \

vlog -work xil_defaultlib \
"glbl.v"

