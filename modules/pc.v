module pc(
  output [31:0]	imem_pc,
  input clk, reset, load,
  input [31:0] new_pc, pc_load
);
  reg [31:0] imem_instruction;
  assign imem_pc = imem_instruction;
  initial begin
	imem_instruction <= 32'b0;
  end
  always @(posedge clk, posedge reset) begin
	if(reset == 1'b1) imem_instruction <= 32'b0;
	else if(load == 1'b1) imem_instruction <= pc_load;
	else imem_instruction <= new_pc;
  end

endmodule 