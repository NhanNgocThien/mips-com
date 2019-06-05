module adder_t;

  reg [31:0] add_1;
  reg [31:0] add_2;
  wire [31:0] out;
  adder Add1(out, add_1, add_2);
  initial begin
	add_1 = 32'd4;
	add_2 = 32'd1;
  end
 
endmodule
