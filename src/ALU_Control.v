//ALU Control Unit
module ALU_Control(ALUOp, func7, func3, Control_out);
input [1:0] ALUOp;
input func7;
input [2:0] func3;
output reg [3:0] Control_out;

always @(*) begin
  case(ALUOp)
    2'b00: Control_out = 4'b0010; // ADD for load/store
    2'b01: Control_out = 4'b0110; // SUB for branch
    2'b10: begin
      case({func7, func3})
        4'b0_000: Control_out = 4'b0010; // ADD
        4'b1_000: Control_out = 4'b0110; // SUB
        4'b0_111: Control_out = 4'b0000; // AND
        4'b0_110: Control_out = 4'b0001; // OR
        default : Control_out = 4'b0010; // default ADD
      endcase
    end
    default: Control_out = 4'b0010; // safe default
  endcase
end

endmodule
