module mux_5(
  output [4:0] out,
  input [4:0] in_1,
  input [4:0] in_2,
  input select
);
  reg [4:0] out_select;
  assign out = out_select;
  always@(*) begin
	casex(select)
		1'b0: out_select = in_1;
		1'b1: out_select = in_2;
		1'bx: out_select = 5'bx;
	endcase
  end

endmodule
