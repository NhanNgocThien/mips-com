module pc(
  output [31:0]	imem_pc,
  input clk, reset, load, enable,
  input [31:0] new_pc, 
  input [7:0]	pc_load
);
  reg [31:0] imem_instruction;
  assign imem_pc = imem_instruction;
  
  always @(negedge clk, negedge reset, negedge load, negedge enable) begin
	if(!reset) imem_instruction <= 32'd0;
	else if(!enable) imem_instruction <= imem_instruction; 
	else begin
			if(!load) imem_instruction <= pc_load;
				else imem_instruction <= new_pc;
	end
  end
	
endmodule 