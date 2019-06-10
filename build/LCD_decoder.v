module LCD_decoder(
	input [3:0] in,
	output [7:0] out
);

reg [7:0] seg_reg;
assign out = seg_reg;
 
always@(*) begin
		case(in)
			4'b0000: seg_reg = 8'b00110000; // 0
			4'b0001: seg_reg = 8'b00110001; // 1
			4'b0010: seg_reg = 8'b00110010; // 2
			4'b0011: seg_reg = 8'b00110011; // 3
			4'b0100: seg_reg = 8'b00110100; // 4
			4'b0101: seg_reg = 8'b00110101; // 5
			4'b0110: seg_reg = 8'b00110110; // 6
			4'b0111: seg_reg = 8'b00110111; // 7
			4'b1000: seg_reg = 8'b00111000; // 8
			4'b1001: seg_reg = 8'b00111001; // 9
			4'b1010: seg_reg = 8'b01000001; // A
			4'b1011: seg_reg = 8'b01000010; // B
			4'b1100: seg_reg = 8'b01000011; // C
			4'b1101: seg_reg = 8'b01000100; // D
			4'b1110: seg_reg = 8'b01000101; // E
			4'b1111: seg_reg = 8'b01000110; // F
			default: seg_reg = 8'b00110000;
		endcase
	end
endmodule
