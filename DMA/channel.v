`timescale 1ns/1ps

//4个fifo,每个fifo有独立的读写控制信号,空满信号

module channel(
    input clk,
    input rstn,

    input clr_0,
    input wr_0,
    input rd_0,
    input [31:0] wdata_0,
    output[31:0]rdata_0 ,
    output full_0,
    output empty_0,

    input clr_1,
    input wr_1,
    input rd_1,
    input [31:0] wdata_1,
    output[31:0]rdata_1 ,
    output full_1,
    output empty_1,

    input clr_2,
    input wr_2,
    input rd_2,
    input [31:0] wdata_2,
    output[31:0]rdata_2 ,
    output full_2,
    output empty_2,

    input clr_3,
    input wr_3,
    input rd_3,
    input [31:0] wdata_3,
    output[31:0]rdata_3 ,
    output full_3,
    output empty_3
);

fifo u0_fifo (
    .clk    (clk),
    .rstn   (rstn),
    .clear  (clr_0),
    .wr     (wr_0),
    .rd     (rd_0),
    .wdata  (wdata_0),
    .rdata  (rdata_0),
    .full   (full_0),
    .empty  (empty_0)
);

fifo u1_fifo (
    .clk    (clk),
    .rstn   (rstn),
    .clear  (clr_1),
    .wr     (wr_1),
    .rd     (rd_1),
    .wdata  (wdata_1),
    .rdata  (rdata_1),
    .full   (full_1),
    .empty  (empty_1)
);

fifo u2_fifo (
    .clk    (clk),
    .rstn   (rstn),
    .clear  (clr_2),
    .wr     (wr_2),
    .rd     (rd_2),
    .wdata  (wdata_2),
    .rdata  (rdata_2),
    .full   (full_2),
    .empty  (empty_2)
);

fifo u3_fifo (
    .clk    (clk),
    .rstn   (rstn),
    .clear  (clr_3),
    .wr     (wr_3),
    .rd     (rd_3),
    .wdata  (wdata_3),
    .rdata  (rdata_3),
    .full   (full_3),
    .empty  (empty_3)
);

endmodule