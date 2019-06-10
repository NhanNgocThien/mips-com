module data_memory(
  output [31:0] data_out,
  input[31:0] address,
  input[31:0] data_in,
  input mem_read, mem_write, clk, reset
);
  reg [7:0] data_memory [9:0]; // Initialize 256 words of 32-bit memory location
  
  assign data_out = (mem_read == 1'b1)? data_memory[address] : 32'bx;

  always@(negedge clk, negedge reset) begin
	if(!reset) begin
		data_memory[0] <= 8'd0;
		data_memory[1] <= 8'd0;
		data_memory[2] <= 8'd0;
		data_memory[3] <= 8'd0;
		data_memory[4] <= 8'd0;
		data_memory[5] <= 8'd0;
		data_memory[6] <= 8'd0;
		data_memory[7] <= 8'd0;
		data_memory[8] <= 8'd0;
		data_memory[9] <= 8'd0;
	end
		else if(mem_write) data_memory[address] <= data_in;
  end

endmodule
