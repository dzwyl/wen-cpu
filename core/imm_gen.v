module  imm_gen(
    input       [31:0]  inst,
    output  reg [63:0]  inst64
);

always  @(inst) begin
    case(inst[6:5])
        2'b00:inst64    <=  {{52{inst[31]}},inst[31:20]};
        2'b01:inst64    <=  {{52{inst[31]}},inst[31:25],inst[11:7]};
        2'b10:inst64    <=  {{52{inst[31]}},inst[31],inst[7],inst[30:25],inst[11:8]};
        default:inst64  <=  64'd0;
endcase
end

endmodule