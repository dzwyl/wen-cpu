`timescale 1ns/1ps

//同步fifio 1K*32bits
module fifo(
    input clk,
    input rstn,
    input clear,
    input wr,
    input rd,
    input [31:0]wdata,

    output reg [31:0]rdata ,
    output full,
    output empty
);

parameter n=7;

reg [31:0]mem [0:n];

reg [9:0]wr_ptr;
reg [9:0]rd_ptr;

reg full_in;
reg empty_in;

always @(posedge clk or negedge rstn)        //读写指针
    if (!rstn)
        wr_ptr<=0;
    else if (clear)
        wr_ptr<=0;
    else if (wr)
        wr_ptr<=wr_ptr+1;
always @(posedge clk or negedge rstn)
    if (!rstn)
        rd_ptr<=0;
    else if (clear)
        rd_ptr<=0;
    else if (rd)
        rd_ptr<=rd_ptr+1;

always @(posedge clk)               //读写数据
    if (wr)
        mem[wr_ptr]<=wdata;

always @(posedge clk or negedge rstn)
    if (!rstn)
        rdata<=0;
    else if (rd)
        rdata<=mem[rd_ptr];

always @(posedge clk or negedge rstn)
    if (!rstn)
        full_in<=0;
    else if (wr && (wr_ptr+1==rd_ptr) && (~rd) || wr_ptr==n && rd_ptr==0 )          //fifo满
        full_in<=1;
    else if (rd && (~wr))//if rd is valid which means one data is out and fifo is not full 
        full_in<=0;

assign full=full_in || (wr && (wr_ptr+1==rd_ptr) && (~rd));

always @(posedge clk or negedge rstn)
    if (!rstn)
        empty_in<=1;
    else if (rd && (rd_ptr+1==wr_ptr) && (~wr))
        empty_in<=1;
    else if (wr && (~rd)) 
        empty_in<=0;

assign empty=empty_in || (rd && (rd_ptr+1==wr_ptr) && (~wr));

endmodule