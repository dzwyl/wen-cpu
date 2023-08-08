`timescale 1ns/1ps

module alu_ctrl(
    input       [1:0]   aluop,
    input       [3:0]   inst_alu,
    output  reg [3:0]   alu_sel
);

always  @(aluop)    begin
    casez(aluop)
        2'b00:begin
            alu_sel <=  4'b0010;
        end
        2'b?1:begin
            alu_sel <=  4'b0110;
        end
        2'b1?:begin
            case(inst_alu)
                4'b0000:alu_sel <=  4'b0010;
                4'b1000:alu_sel <=  4'b0110;
                4'b0111:alu_sel <=  4'b0000;
                4'b0110:alu_sel <=  4'b0001;
                default:alu_sel <=  4'b1111;
            endcase
        end
        default:alu_sel <=  4'b1111;
    endcase
end

endmodule