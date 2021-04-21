-makelib xcelium_lib/xil_defaultlib -sv \
  "D:/schoolsoftware/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/schoolsoftware/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../Light_Sensor.srcs/sources_1/ip/pxl_clk_gen/pxl_clk_gen_clk_wiz.v" \
  "../../../../Light_Sensor.srcs/sources_1/ip/pxl_clk_gen/pxl_clk_gen.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

