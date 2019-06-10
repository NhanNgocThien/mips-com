module inst_mem(
  output [31:0]	imem_instruction,
  input  reset,
  input  [31:0] imem_pc
);
  reg [31:0] new_instruction;
  assign imem_instruction = new_instruction;
  
  always @(imem_pc) begin
			case(imem_pc)
////ADD + ADDI////
					// addi $t0, $t0, 10
					32'd0: new_instruction <= 32'b00100001000010000000000000001010;
					// addi $t1, $0, 5
					32'd4: new_instruction <= 32'b00100000000010010000000000000101;
					// add $t2, $t1, $t0
					32'd8: new_instruction <= 32'b00000001001010000101000000100000;
					// add $t2, $t2, $t2
					32'd12: new_instruction <= 32'b00000001010010100101000000100000;
// SUB //		
					// sub $t3, $t1, $t2
					32'd16: new_instruction <= 32'b00000001001010100101100000100010;
// SLT + OR + AND //
					// slt $t4, $t3, $t2
					32'd20: new_instruction <= 32'b00000001011010100110000000101010;
					// and $t4, $t1, $t3
					32'd24: new_instruction <= 32'b00000001001010110110000000100100;
					// or $t5, $t2, $t4
					32'd28: new_instruction <= 32'b00000001010011000110100000100101;
// SUB //
					// sub $t5, $t5, $t4
					32'd32: new_instruction <= 32'b00000001101011000110100000100010;
					// j -10
					32'd36: new_instruction <= 32'b00001011111111111111111111110110;
// Exception //
					32'd44: new_instruction <= 32'b0;
					32'd48: new_instruction <= 32'b111111xxxxxxxxxxxxxxxxxxxxxxxxxx;
					// lw $t1, 2($0)
					32'd52: new_instruction <= 32'b10001100000010010000000000000010;
					// sw $t1, 2($0)
					32'd56: new_instruction <= 32'b10101100000010010000000000000010;
					
// LW + SW + BEQ //				
					// addi $t0, $0, 4
					32'd40: new_instruction <= 32'b00100000000010000000000000000100;
					// addi $t1, $0, 4
					32'd44: new_instruction <= 32'b00100000000010010000000000000100;
					// sw $t0, 0($t0)
					32'd48: new_instruction <= 32'b10101101000010000000000000000000;
					// lw $t3, 0($t0)
					32'd52: new_instruction <= 32'b10001101000010110000000000000000;
					// add $t3, $t3, $t3
					32'd56: new_instruction <= 32'b00000001011010110101100000100000;
					// beq $t0, $t1, 0x-6 // Reset to the first signal
					32'd60: new_instruction <= 32'b00010001000010011111111111111010;
					
					default: new_instruction <= 32'bx;
			endcase
  end

endmodule 