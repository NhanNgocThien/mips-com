module branch(
  output [31:0] next_inst,
  input [31:0] address,	
  input [31:0] sign_extend, 
  input [25:0] instruction,
  input jump_sig, branch_sig, alu_status
);
  wire after_and;
  wire [31:0] adder_4, adder_imme, adder_sign, mux;
  and (after_and, alu_status, branch_sig);
  adder Add1 (adder_4, {{24{address[7]}},address}, 32'd1);
  adder Add2 (adder_imme, adder_4, {{6{instruction[25]}},instruction});
  adder Add3 (adder_sign, adder_4, sign_extend);
  mux_32 M1 (mux, adder_4, adder_sign, after_and);
  mux_32 M2(next_inst, mux, adder_imme, jump_sig);

endmodule