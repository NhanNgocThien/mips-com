module alu_control_t;
wire[3:0] control;
reg [1:0] op;
reg [5:0] fu;
initial begin
	#0 	op = 2'b00;
		fu = 6'b100000;
	#10	op = 2'b01;
	#10   	op = 2'b10;
 	#10 	fu = 6'b100010;
	#10 	fu = 6'b100100;
	#10	fu = 6'b100101;
	#10 	fu = 6'b101010;
end
alu_control a_c(op, fu, control);
endmodule 