module  alu(
    input   [63:0]      op1,
    input   [63:0]      op2,
    input               aluop,
    output              zero,
    output  reg [63:0]  result
);

always  @(op1,op2,aluop)    begin
    case(aluop)
        4'b0000:result  <=  op1 & op2;
        4'b0001:result  <=  op1 | op2;
        4'b0010:result  <=  op1 + op2;
        4'b0110:result  <=  op1 - op2;
        default:result  <=  0;
    endcase
end

endmodule