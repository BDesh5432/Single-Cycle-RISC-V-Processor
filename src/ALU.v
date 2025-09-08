//ALU
module ALU_unit(A, B, Control_in, ALU_result, zero);
input [31:0] A, B;
input [3:0] Control_in;
output reg [31:0] ALU_result;
output zero;

always @(*) begin
  case(Control_in)
    4'b0000: ALU_result = A & B; // AND
    4'b0001: ALU_result = A | B; // OR
    4'b0010: ALU_result = A + B; // ADD
    4'b0110: ALU_result = A - B; // SUB
    default: ALU_result = 32'b0;
  endcase
end

assign zero = (ALU_result == 32'b0);

endmodule
