`timescale 1ns/1ps

module tb_top;

  reg clk;
  reg reset;

  // Instantiate DUT
  top DUT (
    .clk(clk),
    .reset(reset)
  );

  // Clock generator
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    reset = 1;
    #20 reset = 0;   // release reset

    #200; // run enough cycles

    // Check register contents
    $display("Register x1 = %d", DUT.R_File.Register[1]);
    $display("Register x2 = %d", DUT.R_File.Register[2]);
    $display("Register x3 = %d", DUT.R_File.Register[3]);
    $display("DataMem[0]   = %d", DUT.DMem.D_Mem[0]);

    $finish;
  end

  initial begin
    $dumpfile("cpu_wave.vcd");
    $dumpvars(0, tb_top);

    $display("Time\tPC\tInstr\tALUCtrl\tA\tB\tALURes\tRegWrite");
    $monitor("%0t\t%h\t%h\t%b\t%d\t%d\t%d\t%b",
             $time,
             DUT.PC_top,
             DUT.instruction_top,
             DUT.Control_top,
             DUT.rd1_top,
             DUT.mux1_top,
             DUT.address_top,
             DUT.RegWrite_top);
  end

endmodule
