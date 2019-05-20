module inst_mem_t(
	output [31:0] out
);
	reg clk;
	reg [31:0] addr;
 	inst_mem uut(clk, addr, out);
	initial begin
		clk <= 0;
		addr <= 0;
		forever #5 clk = !clk;
	end
	always @(posedge clk) addr <= addr + 1;
endmodule 