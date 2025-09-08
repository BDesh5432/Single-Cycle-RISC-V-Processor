//Multiplexer
module Mux(sel, A, B, out);
input sel; 
input [31:0] A, B;
output [31:0] out;

assign out = (sel == 1'b0)? A : B;

endmodule
