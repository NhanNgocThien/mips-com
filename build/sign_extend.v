module sign_extend(
  output [31:0] const_add_out,
  input [15:0] const_add
);
  reg [31:0] extended_out;
  assign const_add_out = extended_out;
  always@(*) begin
  	extended_out = {{16{const_add[15]}}, const_add};
  end

endmodule