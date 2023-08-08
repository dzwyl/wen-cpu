`timescale 1ns/1ps

module  data_mem(
    input           clk,
    input   [11:0]  addr,
    input   [63:0]  w_data,
    input           w_en,
    input           r_en,

    output  [63:0]  r_data
);

data_path   #(
    .WIDTH(64),
    .DEPTH(4096)
)   data_mem(
    .clk(clk),
    .wen(w_en),
    .addra(addr),
    .dina(w_data),
    .ren(rd_en),
    .addr(addr),
    .dout(r_data)
);

endmodule