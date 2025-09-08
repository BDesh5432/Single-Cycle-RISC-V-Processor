//PC + 4
module PCplus4(fromPC, NextPC);
input [31:0] fromPC;
output [31:0] NextPC;

assign NextPC = fromPC + 32'd4;

endmodule
