module inst_mem(
	input  			clk,
	input  		[31:0] 	addr,
	output reg 	[31:0]	out
);
	reg [31:0] cmd [256:0];
	reg [8:0] i;
	initial for (i = 255 ; i > 0 ; i = i - 1) cmd[i] <= 255 - i;
	always @(posedge clk) begin
		out <= cmd[addr];
	end
endmodule 
