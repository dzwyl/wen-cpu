`timescale 1ns/1ps

module inst_memory(
    input             clk,
    input   [63:0]    pc,
    output  [31:0]    inst
);

dpram #(
    .WIDTH(32),
    .DEPTH(256)
)   inst_memory(
    .clk(clk),
    .w_en(1'b0),
    .addra(8'b0),
    .dina(32'b0),
    .renb(1'b1),
    .addrb(pc[9:2]),
    .doutb(inst)
);

endmodule