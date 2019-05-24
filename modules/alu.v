module alu(
  output [31:0] alu_result,
  output [7:0] alu_status,
  input signed [31:0] alu_operand_1, alu_operand_2,
  input [5:0] alu_control
);

reg [3:0] control;
reg [1:0] type;

reg signed [31:0] in_1, in_2; 
reg signed [32:0] out_signed, out_unsigned;
reg signed [63:0] mul_out;
reg [7:0] status;

assign alu_status = status;
assign alu_result = out_signed[31:0];

initial begin
	status[7:0] <= 8'b0;
end

always @(*) begin 
	in_1 <= alu_operand_1;
	in_2 <= alu_operand_2;
	control = alu_control[3:0];
	type = alu_control[5:4];
	case(control)
	4'b0010: begin // Add both R and I 
		out_signed[32:0] <= {in_1[31] , in_1[31:0]} + {in_2[31], in_2[31:0]};
		out_unsigned[32:0] <= {1'b0, in_1[31:0]} + {1'b0, in_2[31:0]};
		if((out_signed[32] ^ out_signed[31]) == 1'b1) status[6] <= 1'b1; // overflow
		else begin    
			//if(out_signed[31:0] % 4 != 0 && type == 2'b00) status[3] = 1'b1;
			if (out_unsigned[32] == 1'b1) status[5] <= 1'b1; // carry_bit
			else status[5] <= 1'b0;
		end
	end
	4'b0110: begin // Sub R
		out_signed[32:0] <= {in_1[31] , in_1[31:0]} + (~{in_2[31], in_2[31:0]} + 1'b1);
		out_unsigned[32:0] <= {1'b0, in_1[31:0]} + {1'b0, (~(in_2[31:0]) + 1'b1)};
		if((out_signed[32] ^ out_signed[31]) == 1'b1) status[6] <= 1'b1; // overflow
		else begin
			//if((out_signed[3:0] % 4)!= 4'd0 && type == 2'b00) status[3] = 1'b1;
			if(out_unsigned[32] == 1'b1) status[5] <= 1'b1; // carry_bit
			else status[5] <= 1'b0;
		end
	end
	4'b0011: begin // Mul R 
		mul_out <= in_1 * in_2;
		if(mul_out > 2147483647 || mul_out < -214783648) status[6] <= 1'b1; // overflow
		else begin
		 	out_signed[31:0] <= mul_out[31:0]; 
		end
	end
	4'b0100: begin // Divide R
		if(in_2 == 32'd0) 
			status[2] <= 1'b1;
		else out_signed[31:0] <= in_1 / in_2;
	end
	4'b0000: out_signed[31:0] <= in_1 & in_2; // Bitsise AND both R and I
	4'b0001: out_signed[31:0] <= in_1 | in_2; // Bitwise OR both R and I
	4'b0111: out_signed[31:0] <= (in_1 < in_2) ? 32'd1 : 32'd0; 
	default: out_signed[31:0] <= 32'bx;
	endcase
end
// Differentiate between I and R format to consider word aligned case
always@(*) begin
	if(status[6] == 1'b1 || status[3] == 1'b1 || status[2] == 1'b1)
		out_signed[31:0] <= 32'bx;
	else begin
		if(out_signed[31] == 1'b1) status[4] <= 1'b1;
		else if(out_signed[31:0] == 32'd0) status[7] <= 1'b1;
	end
end

endmodule 
