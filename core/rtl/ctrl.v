`timescale 1ns/1ps

module ctrl(
    input               rstn,
    input       [6:0]   opcode,
    output  reg         branch,
    output  reg         mem_read,
    output  reg         mem_to_reg,
    output  reg [1:0]   aluop,
    output  reg         mem_write,
    output  reg         alu_src,
    output  reg         reg_write
);

always  @(negedge rstn or opcode)   begin
    if(!rstn)    begin
        branch      <=  1'b0;
        mem_read    <=  1'b0;
        mem_to_reg  <=  1'b0;
        aluop       <=  2'b00;
        mem_write   <=  1'b0;
        alu_src     <=  1'b0;
        reg_write   <=  1'b0;
    end
    else    begin
        case(opcode)
            7'b0110011:begin
                branch      <=  1'b0;
                mem_read    <=  1'b0;
                mem_to_reg  <=  1'b0;
                aluop       <=  2'b10;
                mem_write   <=  1'b0;
                alu_src     <=  1'b0;
                reg_write   <=  1'b1;
            end
            7'b0000011:begin
                branch      <=  1'b0;
                mem_read    <=  1'b1;
                mem_to_reg  <=  1'b1;
                aluop       <=  2'b00;
                mem_write   <=  1'b0;
                alu_src     <=  1'b1;
                reg_write   <=  1'b1;
            end
            7'b0100011:begin
                branch      <=  1'b0;
                mem_read    <=  1'b0;
                mem_to_reg  <=  1'b0;
                aluop       <=  2'b00;
                mem_write   <=  1'b1;
                alu_src     <=  1'b1;
                reg_write   <=  1'b0;
            end
            7'b0010011:begin
                branch      <=  1'b0;
                mem_read    <=  1'b0;
                mem_to_reg  <=  1'b0;
                aluop       <=  2'b00;
                mem_write   <=  1'b0;
                alu_src     <=  1'b1;
                reg_write   <=  1'b1;
            end
            7'b1100011:begin
                branch      <=  1'b1;
                mem_read    <=  1'b0;
                mem_to_reg  <=  1'b0;
                aluop       <=  2'b01;
                mem_write   <=  1'b0;
                alu_src     <=  1'b0;
                reg_write   <=  1'b0;
            end
            default:begin
                branch      <=  1'b0;
                mem_read    <=  1'b0;
                mem_to_reg  <=  1'b0;
                aluop       <=  2'b00;
                mem_write   <=  1'b0;
                alu_src     <=  1'b0;
                reg_write   <=  1'b0;
            end
    endcase
    end
end

endmodule