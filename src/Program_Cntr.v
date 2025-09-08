//Program Counter
module Program_Cntr(clk, reset, PC_in, PC_out);
parameter Width = 32;
input clk, reset;
input [Width-1:0] PC_in;
output reg [Width-1:0] PC_out;

always @(posedge clk)
 begin
   if(reset)
      PC_out <= {Width{1'b0}};
   else
      PC_out <= PC_in; 
 end

endmodule
