module conv_26_to_4(
	input [31:0] in,
	input reset, load, SW,
	output [0:6] hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7 
);

reg [31:0] data;

always@(negedge reset, negedge load, negedge SW) begin
	data <= in;
end


seven_seg_hex hex_0 (data[3:0], hex0[0:6]);
seven_seg_hex hex_1 (data[7:4], hex1[0:6]);
seven_seg_hex hex_2 (data[11:8], hex2[0:6]);
seven_seg_hex hex_3 (data[15:12], hex3[0:6]);
seven_seg_hex hex_4 (data[19:16], hex4[0:6]);
seven_seg_hex hex_5 (data[23:20], hex5[0:6]);
seven_seg_hex hex_6 (data[27:24], hex6[0:6]);
seven_seg_hex hex_7 (data[31:28], hex7[0:6]);

endmodule
