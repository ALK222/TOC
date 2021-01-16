// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Fri Nov 29 12:25:58 2019
// Host        : DESKTOP-7F6NS6D running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/hlocal/TOC/PR6/MIPSMulticiclo_R3yModoDepuracion/MIPSMulticiclo_R3yModoDepuracion.srcs/sources_1/ip/DCM_100MHz_10MHz/DCM_100MHz_10MHz_stub.v
// Design      : DCM_100MHz_10MHz
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module DCM_100MHz_10MHz(clk_out1, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,clk_in1" */;
  output clk_out1;
  input clk_in1;
endmodule
