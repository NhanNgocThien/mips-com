module error_handle_t;
  wire [1:0] exception_sig; 
	// exception_sig[1]: MemWrite, 
	// exception_sig[0]: Mem2Reg
  reg pc_exception, mem_write, mem_2_reg;
  reg [7:0] alu_status;
  error_handle E1(exception_sig, pc_exception, mem_write, mem_2_reg,
	alu_status);
  initial begin
	pc_exception = 1'b0;
	alu_status = 8'b0;
	mem_write = 1'b0;
	mem_2_reg = 1'b1;
 	#10 pc_exception = 1'b1;
  end
endmodule
