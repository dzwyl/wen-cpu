// Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus II License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// *****************************************************************************
// This file contains a Verilog test bench template that is freely editable to  
// suit user's needs .Comments are provided in each section to help the user    
// fill out necessary details.                                                  
// *****************************************************************************
// Generated on "12/15/2020 15:29:27"
                                                                                
// Verilog Test Bench template for design : TOP
// 
// Simulation tool : ModelSim (Verilog)
// 

`timescale 1 ns/ 1 ns
module TOP_tb();
// constants                                           
// general purpose registers
reg eachvec;
// test vector input registers
reg HCLK;
reg Rst;
reg [31:0] Taddr;
reg Tstart;
reg [31:0] Twdata;
reg Twrite;
// wires                                               
wire [31:0]  Trdata;

parameter time_period = 100;
parameter time_count  = 20;
// assign statements (if any)                          
TOP i1 (
// port map - connection between master ports and signals/registers   
	.HCLK(HCLK),
	.Rst(Rst),
	.Taddr(Taddr),
	.Trdata(Trdata),
	.Tstart(Tstart),
	.Twdata(Twdata),
	.Twrite(Twrite)
);
initial                                                
begin                                                  
// code that executes only once                        
// insert code here --> begin                          
Rst = 1;
#100
Rst = 0;
#100

Rst = 1;
Taddr = 32'h0000_0114;
Tstart = 1'b1;
Twdata = 32'h0000_1111;
Twrite = 1'b1;
#500

Twrite = 1'b0;
#300

Twdata = 32'h0000_2222;
#800                                 
// --> end                                             
$display("Running testbench");                            
end    

initial                                                
begin                                                  
HCLK = 1;
repeat(2*time_count)   
#(time_period/2)  HCLK = ~HCLK;                  
end 
                                                
always                                                 
// optional sensitivity list                           
// @(event1 or event2 or .... eventn)                  
begin                                                  
// code executes for every event on sensitivity list   
// insert code here --> begin                          
                                                       
@eachvec;                                              
// --> end                                             
end                                                    
endmodule

