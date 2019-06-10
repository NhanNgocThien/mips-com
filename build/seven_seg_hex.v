module seven_seg_hex(
	input [3:0] in,
	output [0:6] seg
);
	reg [0:6] seg_reg;
	always@(*) begin
		case(in)
			4'b0000: seg_reg = 7'b0000001; // 0
			4'b0001: seg_reg = 7'b1001111; // 1
			4'b0010: seg_reg = 7'b0010010; // 2
			4'b0011: seg_reg = 7'b0000110; // 3
			4'b0100: seg_reg = 7'b1001100; // 4
			4'b0101: seg_reg = 7'b0100100; // 5
			4'b0110: seg_reg = 7'b0100000; // 6
			4'b0111: seg_reg = 7'b0001111; // 7
			4'b1000: seg_reg = 7'b0000000; // 8
			4'b1001: seg_reg = 7'b0000100; // 9
			4'b1010: seg_reg = 7'b0001000; // A
			4'b1011: seg_reg = 7'b1100000; // B
			4'b1100: seg_reg = 7'b0110001; // C
			4'b1101: seg_reg = 7'b1000010; // D
			4'b1110: seg_reg = 7'b0110000; // E
			4'b1111: seg_reg = 7'b0111000; // F
			default: seg_reg = 7'b0000001;
		endcase
	end
	assign seg = seg_reg;
endmodule

