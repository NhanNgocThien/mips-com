module sign_extend(
	input  [15:0] i_16bit,
	output [31:0] i_32bit
);
assign i_32bit = {{16{i_16bit[15]}}, i_16bit[15:0]};
endmodule
