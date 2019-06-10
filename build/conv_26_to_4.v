module conv_26_to_4(
	input [31:0] in,
	output [0:6] hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7 
);

seven_seg_hex hex_0 (in[3:0], hex0[0:6]);
seven_seg_hex hex_1 (in[7:4], hex1[0:6]);
seven_seg_hex hex_2 (in[11:8], hex2[0:6]);
seven_seg_hex hex_3 (in[15:12], hex3[0:6]);
seven_seg_hex hex_4 (in[19:16], hex4[0:6]);
seven_seg_hex hex_5 (in[23:20], hex5[0:6]);
seven_seg_hex hex_6 (in[27:24], hex6[0:6]);
seven_seg_hex hex_7 (in[31:28], hex7[0:6]);

endmodule
