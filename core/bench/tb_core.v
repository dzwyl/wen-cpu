`timescale 1ns/1ps

module  tb_core(

);

localparam CLK_PERIOD = 10;
reg clk;
reg rstn;

initial begin
    clk     =   1'b0;
    rstn    =   1'b0;
    repeat(4)   @(posedge clk);
    rstn    =   1'b1;
end

always  begin
    #(CLK_PERIOD/2) clk <=  ~clk;
end

initial begin
    $fsdbDumpfile("wave.fsdb");
    $fsdbDumpvars(0);
end

initial begin
    $readmemb("../bench/inst.txt",u_core.u_inst_mem.u_dpram.BRAM);
end

core    u_core(
    .clk(clk),
    .rstn(rstn)
);

endmodule