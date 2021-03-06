module adder(
  output [31:0] pc_new,
  input [31:0] pc,
  input [31:0] address
);
  reg [31:0] pc_reg;
  reg [31:0] shift_result;
  assign pc_new = pc_reg;
  always@(*) begin
	shift_result = address <<2;
	pc_reg = pc + shift_result;
  end

endmodule
