`timescale 1ns/1ps

module  reg_file(
    input           clk,
    input           rstn,
    input   [4:0]   r_reg1,
    input   [4:0]   r_reg2,
    input   [4:0]   w_reg,
    input   [63:0]  w_data,
    input           w_en,

    output  reg [63:0]  r_data1,
    output  reg [63:0]  r_data2
);

reg [63:0]  mem [31:0];

always @(posedge clk) begin
    if(w_en)   
    begin
        mem[w_reg]  <=  w_data;
    end
end

always  @(posedge clk)    begin
    if(!rstn)   begin
        r_data1 <=  'd0;
        r_data2 <=  'd0;
    end
    else    begin
        r_data1 <=  mem[r_reg1];
        r_data2 <=  mem[r_reg2];
    end
end

integer i;

initial begin
    for(i=0;i<32;i=i+1) begin
        mem[i]  <=  'd0;
    end
end

wire [63:0] x0  =mem[0];
wire [63:0] x1  =mem[1];
wire [63:0] x2  =mem[2];
wire [63:0] x3  =mem[3];
wire [63:0] x4  =mem[4];
wire [63:0] x5  =mem[5];
wire [63:0] x6  =mem[6];
wire [63:0] x7  =mem[7];
wire [63:0] x8  =mem[8];
wire [63:0] x9  =mem[9];
wire [63:0] x10  =mem[10];
wire [63:0] x11  =mem[11];
wire [63:0] x12  =mem[12];
wire [63:0] x13  =mem[13];
wire [63:0] x14  =mem[14];
wire [63:0] x15  =mem[15];
wire [63:0] x16  =mem[16];
wire [63:0] x17  =mem[17];
wire [63:0] x18  =mem[18];
wire [63:0] x19  =mem[19];
wire [63:0] x20  =mem[20];
wire [63:0] x21  =mem[21];
wire [63:0] x22  =mem[22];
wire [63:0] x23  =mem[23];
wire [63:0] x24  =mem[24];
wire [63:0] x25  =mem[25];
wire [63:0] x26  =mem[26];
wire [63:0] x27  =mem[27];
wire [63:0] x28  =mem[28];
wire [63:0] x29  =mem[29];
wire [63:0] x30  =mem[30];
wire [63:0] x31  =mem[31];

endmodule