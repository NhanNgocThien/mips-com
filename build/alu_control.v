module alu_control(
  output [3:0] control,
  input [1:0] opcode,
  input [5:0] func
);
  reg [3:0] con;
  assign control = con;
  always@(*) begin
		case(opcode)
			2'b00: con = 4'b0010; //lw & sw & addi
			2'b01: con = 4'b0110; //beq
			2'b11: con = 4'b0111; // slti
			2'b10:
			begin
				case(func)
				6'b100000: con = 4'b0010; //add 
				6'b100010: con = 4'b0110; //sub
				6'b100100: con = 4'b0000; //AND
				6'b100101: con = 4'b0001; //OR
				6'b101010: con = 4'b0111; //slt
				//6'b011010: con = 4'b0100; //div
				//6'b011000: con = 4'b0011; //mult
				default: con = 4'bxxxx;
				endcase
			end
			default: con = 4'bxxxx;
		endcase 
  end

endmodule
