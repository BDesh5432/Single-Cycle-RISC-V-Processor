//Data Memory
module Data_mem(clk, reset, MemWrite, MemRead, rd_address, wr_data, MemData_out);
input clk, reset, MemWrite, MemRead;
input [5:0] rd_address;
input [31:0] wr_data;
output [31:0] MemData_out;

reg [31:0] D_Mem[63:0];
integer i;

always @(posedge clk or posedge reset)
 begin
   if(reset)
     begin
        for(i=0; i<64; i=i+1)
          D_Mem[i] <= 32'b0;
     end
   else if(MemWrite)
     D_Mem[rd_address] <= wr_data; 
 end

assign MemData_out = (MemRead) ? D_Mem[rd_address] : 32'b0;

endmodule
