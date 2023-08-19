`timescale 1ns / 1ps

module core(
    input   clk,
    input   rstn
);

reg     [9:0]   pc;
wire    [9:0]   pc_next;
wire    [9:0]   pc_inc;
wire            pc_sel;
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
wire    [63:0]  r_data_mem;

wire            branch;
wire            mem_read;
wire            mem_to_reg;
wire    [1:0]   aluop;
wire            mem_write;
wire            alu_src;
wire            reg_write;

reg     [3:0]   phase   =   4'd0;
reg             PC_load;
reg             IR_load;

assign  pc_inc  =   pc + 1;                                 //+4 bit
assign  pc_sel  =   branch  &   zero;
assign  pc_target   =   pc  +   {inst64[8:0],1'b0};
assign  pc_next =   pc_sel  ?   pc_target   :   pc_inc;

always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        pc  <= 'd0;
    end 
    else begin
    if(PC_load) begin
        pc  <= pc_next;
    end
    end
end

assign  op1 =   r_data1_rf;
assign  op2 =   alu_src ?   inst64  :   r_data2_rf;
assign  inst_alu    =   {inst_reg[30],inst_reg[14:12]};     //
assign  w_data_rf  =   mem_to_reg ? r_data_mem : result;

always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        phase   <= 'd0;
    end 
    else begin
        phase   <= phase + 1;
    end
end

always @(posedge clk) begin
    if(phase==1) begin
        PC_load <= 1'b1;
    end 
    else begin
        PC_load <= 1'b0;
    end
end

always @(posedge clk) begin
    if(phase==2) begin
        IR_load <= 1'b1;
    end 
    else begin
        IR_load <= 1'b0;
    end
end

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

inst_mem    u_inst_mem(
    .clk(clk),
    .pc(pc),
    .inst(inst)
);

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
    .w_data(w_data_rf),
    .w_en(reg_write),
    .r_data1(r_data1_rf),
    .r_data2(r_data2_rf)
);

imm_gen u_imm_gen(
    .inst32(inst_reg),
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
    .w_data(r_data2_rf),
    .r_data(r_data_mem)
);

endmodule