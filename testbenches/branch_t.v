`timescale 1ns/1ns
module branch_t;
  wire [31:0] next_inst;
  reg [31:0] address, sign_extend, instruction;
  reg jump_sig, branch_sig, alu_status;

  branch branch(next_inst, address, sign_extend, instruction,
	jump_sig, branch_sig, alu_status);

  initial begin
	#10 address = 32'd0;
	    sign_extend = 32'd2;
	    alu_status = 1'b1;
	    branch_sig = 1'b1;
	    jump_sig = 1'b0;
	#10 address = 32'd0;
	    instruction =  32'd0;
   	    branch_sig = 1'b0;
	    jump_sig = 1'b1;
	#10 address = 32'd20;
	    instruction = 32'd30;
	    branch_sig = 1'b0;
  	    jump_sig = 1'b1;
	#10 address = 32'd10;
	    instruction = 32'd0;
	    sign_extend = -2'd2;
 	    jump_sig = 1'b0;
	    branch_sig = 1'b1;
  end

endmodule
