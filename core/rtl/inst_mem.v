`timescale 1ns/1ps

module inst_mem(
    input             clk,
    input   [9:0]     pc,
    output  [31:0]    inst
);

dpram #(
    .WIDTH(32),
    .DEPTH(256)
)   u_inst_dpram(
    .clk(clk),
    .wen(1'b0),
    .addra(8'b0),
    .dina(32'b0),
    .ren(1'b1),
    .addrb(pc),
    .doutb(inst)
);

endmodule