module error_handle(
  output [1:0] exception_sig, 
	// exception_sig[1]: MemWrite, 
	// exception_sig[0]: Mem2Reg
  input pc_exception, mem_write, mem_2_reg,
  input [7:0] alu_status
);
  assign exception_sig[1] = (pc_exception == 1'b1 || alu_status[6] == 1'b1 || alu_status[3] == 1'b1 || alu_status[2] == 1'b1)? 1'b0 : mem_write;
  assign exception_sig[0] = (pc_exception == 1'b1 || alu_status[6] == 1'b1 || alu_status[3] == 1'b1 || alu_status[2] == 1'b1)? 1'bx : mem_2_reg; 

endmodule
