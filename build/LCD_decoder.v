module LCD_decoder(
	input [3:0] in,
	output [7:0] out
);

	reg [7:0] seg_reg;
	assign out = seg_reg;
 
	always@(*) begin
		case(in)
			 0: seg_reg = "0";
			 1: seg_reg = "1";
			 2: seg_reg = "2";
			 3: seg_reg = "3";
			 4: seg_reg = "4";
			 5: seg_reg = "5";
			 6: seg_reg = "6";
			 7: seg_reg = "7";
			 8: seg_reg = "8";
			 9: seg_reg = "9";
			10: seg_reg = "A";
			11: seg_reg = "B";
			12: seg_reg = "C";
			13: seg_reg = "D";
			14: seg_reg = "E";
			15: seg_reg = "F";
			default: seg_reg = "_";
		endcase
	end
endmodule
