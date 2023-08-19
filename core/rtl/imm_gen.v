`timescale 1ns / 1ps

module  imm_gen(
    input       [31:0]  inst32,
    output  reg [63:0]  inst64
);

always  @(inst32) begin
    case(inst32[6:5])
        2'b00:inst64    <=  {{52{inst32[31]}},inst32[31:20]};                                   //ld
        2'b01:inst64    <=  {{52{inst32[31]}},inst32[31:25],inst32[11:7]};                        //sd
        2'b10:inst64    <=  {{52{inst32[31]}},inst32[31],inst32[7],inst32[30:25],inst32[11:8]};       //branch
        default:inst64  <=  64'd0;
endcase
end

endmodule