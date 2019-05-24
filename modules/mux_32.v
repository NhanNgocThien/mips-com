module mux_32(
  output [31:0] out,
  input [31:0] in_1, in_2,
  input select
);
 assign out = (select == 1'b1)? in_2 : in_1;

endmodule 