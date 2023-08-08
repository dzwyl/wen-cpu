`timescale 1ns/1ps

module core(
    input   clk,
    input   rstn
);

reg     [9:0]   pc;
wire    [9:0]   pc_next;
wire            pc_inc;
wire    [9:0]   pc_sel;
wire    [9:0]   pc_target;
wire    [31:0]  inst;
wire    [63:0]  inst64;
reg     [31:0]  inst_reg;

wire    [63:0]  w_data_rf;
wire    [63:0]  r_data1_rf;
wire    [63:0]  r_data2_rf;

wire    [63:0]  op1;
wire    [63:0]  op2;
wire    [3:0]   alu_sel;
wire            zero;
wire    [63:0]  result;

wire    [3:0]   inst_alu;
wire    [63:0]  


assign  pc_sel  =   branch  &   zero;


inst_mem    u_inst_mem(
    .clk(clk),
    .pc(pc),
    .inst(inst)
);


always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        inst_reg   <=  'd0;
    end 
    else begin
        if(IR_load) begin
            inst_reg   <=  inst;
        end
    end
end

//-----------------------------------------------------//

ctrl    u_ctrl(
    .rstn(rstn),
    .opcode(inst_reg[6:0]),
    .branch(branch),
    .mem_read(mem_read),
    .mem_to_reg(mem_to_reg),
    .aluop(aluop),
    .mem_write(mem_write),
    .alu_src(alu_src),
    .reg_write(reg_write)
);

reg_file    u_reg_file(
    .clk(clk),
    .rstn(rstn),
    .r_reg1(inst_reg[19:15]),
    .r_reg2(inst_reg[24:20]),
    .w_reg(inst_reg[11:7]),
    .w_data(w_data),
    .w_en(reg_write),
    .r_data1(r_data1),
    .r_data2(r_data2)
);

imm_gen u_imm_gen(
    .inst(inst_reg),
    .inst64(inst64)
);

alu u_alu(
    .op1(op1),
    .op2(op2),
    .alu_sel(alu_sel),
    .zero(zero),
    .result(result)
);

alu_ctrl    u_alu_ctrl(
    .aluop(aluop),
    .inst_alu(inst_alu),
    .alu_sel(alu_sel)
);

data_mem    u_data_mem(
    .clk(clk),
    .addr(result[11:0]),
    .w_en(mem_write),
    .r_en(mem_read),
    .w_data(r_data2),
    .r_data(mem_dout)
);

endmodule