module data_memory(
  output [31:0] data_out,
  input[31:0] address,
  input[31:0] data_in,
  input mem_read, mem_write, clk, reset
);
  reg [31:0] data_memory [19:0]; // Initialize 256 words of 32-bit memory location
  
  assign data_out = (mem_read == 1'b1)? data_memory[address] : 32'bx;

  always@(negedge clk, negedge reset) begin
	if(!reset) begin
		data_memory[0] <= 32'd0;
		data_memory[1] <= 32'd0;
		data_memory[2] <= 32'd0;
		data_memory[3] <= 32'd0;
		data_memory[4] <= 32'd0;
		data_memory[5] <= 32'd0;
		data_memory[6] <= 32'd0;
		data_memory[7] <= 32'd0;
		data_memory[8] <= 32'd0;
		data_memory[9] <= 32'd0;
	end
		else if(mem_write) data_memory[address] <= data_in;
  end

endmodule
