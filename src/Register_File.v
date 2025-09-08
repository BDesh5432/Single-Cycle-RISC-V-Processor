//Register File
module regfile(clk, reset, RegWrite, rdReg1, rdReg2, wrReg, wrData, rdData1, rdData2);
input clk, reset, RegWrite;
input [4:0] rdReg1, rdReg2, wrReg;
input [31:0] wrData;
output [31:0] rdData1, rdData2;

integer i;
reg [31:0] Register[0:31];

always @(posedge clk or posedge reset) begin
  if(reset) begin
    for(i=0; i<32; i=i+1)
      Register[i] <= 32'b0;
  end 
  else if(RegWrite && wrReg != 5'd0) begin
    Register[wrReg] <= wrData;
  end
end

assign rdData1 = (rdReg1 == 5'd0) ? 32'b0 : Register[rdReg1];
assign rdData2 = (rdReg2 == 5'd0) ? 32'b0 : Register[rdReg2];

endmodule
