module mux_32(
  output [31:0] out,
  input [31:0] in_1, in_2,
  input select
);
  reg [31:0] out_select;
  assign out = out_select;
  always@(*) begin
	case(select) 
		1'b0: out_select = in_1;
		1'b1: out_select = in_2;
	endcase
  end	
 
endmodule 