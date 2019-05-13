module sign_extend_t(
	output [31:0] i_32bits
);
reg[15:0] in;
initial begin 
	#0	in = 8;
	#30	in = -8;
#10 $stop;
end
sign_extend s_e(in, i_32bits);
endmodule 