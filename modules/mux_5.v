module mux_5(
  output [4:0] out,
  input [4:0] in_1,
  input [4:0] in_2,
  input select
);
  assign out = (select == 1'b1)? in_2 : in_1;

endmodule
