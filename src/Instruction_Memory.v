//Instruction Memory (64 x 32bit)
module Instruct_mem(Address, Instruct);
input [5:0] Address;
output [31:0] Instruct;

reg [31:0] I_mem[0:63];

// initialize memory from hex file
initial begin
  $readmemh("program.hex", I_mem);
end

assign Instruct = I_mem[Address];

endmodule
