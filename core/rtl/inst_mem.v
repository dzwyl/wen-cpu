module inst_mem(
    input             clk,
    input   [63:0]    pc,
    output  [31:0]    inst
);

datapath #(
    .WIDTH(32),
    .DEPTH(256)
)   inst_mem(
    .clk(clk),
)
endmodule