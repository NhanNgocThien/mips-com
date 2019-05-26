`timescale 1ns/1ns
module SYS_Master_t;
  wire [26:0] out;
  reg clk;
  reg reset;
  reg load; // Debug purpose
  reg [31:0] pc_load;
  reg [7:0] output_sel;

  SYS_Master S1(out, clk, reset, load, pc_load, output_sel);
  initial begin
  	clk <= 1'b0;
	forever #1 clk = ~clk;
  end

  initial begin
	output_sel = 8'd1;
	reset = 1'b0;
	load = 1'b0;
	#10 reset = 1'b1;
	#5 reset = 1'b0;
	#10 load = 1'b1;
	    pc_load = 32'd140;
	#5 load = 1'b0;
  end

endmodule
