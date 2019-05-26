module data_memory(
  output [31:0] data_out,
  input[31:0] address,
  input[31:0] data_in,
  input mem_read,
  input mem_write,
  input clk,
  input reset
);
  reg [31:0] data_memory [0:255]; // Initialize 256 words of 32-bit memory location
  
  assign data_out = (mem_read == 1'b1)? data_memory[address] : 32'bx;

  integer x;
  initial begin
	for(x = 0; x < 256; x = x + 1) begin
		data_memory[x] <= 32'd0;
	end
  end

  always@(posedge clk, posedge reset) begin
	if(reset == 1'b1) begin
		for(x = 0; x < 256; x = x + 1)
			data_memory[x] <= 32'd0;
	end
	else if(mem_write == 1'b1) data_memory[address] <= data_in;
  end

endmodule
