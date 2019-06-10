module error_handle(
  output [1:0] exception_sig, 
  output enable,
  input pc_exception, mem_write, mem_2_reg, reg_error,
  input [1:0] mem_sig,
  input [7:0] alu_status
);

  assign exception_sig[1] = (reg_error || pc_exception || alu_status[6] || (alu_status[3] && (mem_sig[1] || mem_sig[0])) || alu_status[2])? 1'b0 : mem_write;
  assign exception_sig[0] = (reg_error || pc_exception || alu_status[6] || (alu_status[3] && (mem_sig[1] || mem_sig[0])) || alu_status[2])? 1'bx : mem_2_reg;
  assign enable = (reg_error || pc_exception || alu_status[6] || (alu_status[3] && (mem_sig[1] || mem_sig[0])) || alu_status[2])? 1'b0: 1'b1;
  
endmodule