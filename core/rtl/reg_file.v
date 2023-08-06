module  reg_file(
    input   clk,
    input   rstn,
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

always  @(*)    begin
    r_data1 <=  mem[r_reg1];
    r_data2 <=  mem[r_reg2];
end

endmodule