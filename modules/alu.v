module alu(
	input  [31:0] alu_operand_1,
	input  [31:0] alu_operand_2,
	input  [3:0]  alu_control,
	output [31:0] alu_result,
	output [7:0]  alu_status
);
	reg [31:0] out;
	always @(*) begin 
		case(alu_control)
			4'b0010: out = alu_operand_1 + alu_operand_2;
			4'b0110: out = alu_operand_1 - alu_operand_2;
			4'b0011: out = alu_operand_1 * alu_operand_2;
			4'b0100: out = alu_operand_1 / alu_operand_2;
			4'b0000: out = alu_operand_1 & alu_operand_2;
			4'b0001: out = alu_operand_1 | alu_operand_2;
			4'b0111: out = alu_operand_1 < alu_operand_2; 
			default: out = alu_operand_1 + alu_operand_2;
		endcase
	end
	assign alu_result = out;
endmodule 
