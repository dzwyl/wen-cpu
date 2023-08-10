`timescale 1ns/1ps

module  alu(
    input   [63:0]      op1,
    input   [63:0]      op2,
    input   [3::0]      alu_sel,
    output              zero,
    output  reg [63:0]  result
);

always  @(*)    begin
    case(alu_sel)
        4'b0000:result  <=  op1 & op2;
        4'b0001:result  <=  op1 | op2;
        4'b0010:result  <=  op1 + op2;
        4'b0110:result  <=  op1 - op2;
        default:result  <=  op1;
    endcase
end

assign zero=~(|result);

endmodule