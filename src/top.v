//Top module
module top(clk, reset);
input clk, reset;

wire [31:0] PC_top, instruction_top, rd1_top, rd2_top, ImmExp_top;
wire [31:0] mux1_top, Sum_outTop, NextPC_top, PCin_top;
wire [31:0] address_top, MemData_top, Writeback_top;
wire RegWrite_top, ALUSrc_top, zero_top, branch_top, sel2_top;
wire MemtoReg_top, MemWrite_top, MemRead_top;
wire [1:0] ALUOp_top;
wire [3:0] Control_top;

//Program Counter
Program_Cntr PC(.clk(clk), .reset(reset), .PC_in(PCin_top), .PC_out(PC_top));

//PC Adder
PCplus4 PC_Adder(.fromPC(PC_top), .NextPC(NextPC_top));

//Instruction Memory
Instruct_mem I_Mem(.Address(PC_top[7:2]), .Instruct(instruction_top));

//Register File
regfile R_File(.clk(clk), .reset(reset), .RegWrite(RegWrite_top), 
               .rdReg1(instruction_top[19:15]), 
               .rdReg2(instruction_top[24:20]), 
               .wrReg(instruction_top[11:7]), 
               .wrData(Writeback_top), 
               .rdData1(rd1_top), .rdData2(rd2_top));

//Immediate Generator
ImmGen Immediate(.Opcode(instruction_top[6:0]), .instruction(instruction_top), .ImmExt(ImmExp_top));

//Control Unit
Control_Unit CU(.instruction(instruction_top[6:0]), 
                .Branch(branch_top), .MemRead(MemRead_top), 
                .MemtoReg(MemtoReg_top), .ALUOp(ALUOp_top), 
                .MemWrite(MemWrite_top), .ALUSrc(ALUSrc_top), 
                .RegWrite(RegWrite_top));

//ALU Control
ALU_Control AC(.ALUOp(ALUOp_top), 
               .func7(instruction_top[30]), 
               .func3(instruction_top[14:12]), 
               .Control_out(Control_top));

//ALU
ALU_unit ALU(.A(rd1_top), .B(mux1_top), 
             .Control_in(Control_top), 
             .ALU_result(address_top), .zero(zero_top));

//ALU Mux
Mux ALU_Mux(.sel(ALUSrc_top), .A(rd2_top), .B(ImmExp_top), .out(mux1_top));

//Adder (PC + Imm)
Adder ADD(.in1(PC_top), .in2(ImmExp_top), .out(Sum_outTop));

//AND Logic
AND_Logic ANDb(.branch(branch_top), .zero(zero_top), .out(sel2_top));

//Mux for PC input
Mux Mux2(.sel(sel2_top), .A(NextPC_top), .B(Sum_outTop), .out(PCin_top));

//Data Memory
Data_mem DMem(.clk(clk), .reset(reset), 
              .MemWrite(MemWrite_top), .MemRead(MemRead_top), 
              .rd_address(address_top[7:2]), 
              .wr_data(rd2_top), .MemData_out(MemData_top));

//Writeback Mux
Mux Mux3(.sel(MemtoReg_top), .A(address_top), .B(MemData_top), .out(Writeback_top));

endmodule
