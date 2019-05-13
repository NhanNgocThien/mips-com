module mux_32_t(out);
reg [31:0] in1, in2;
reg select;
output [31:0] out;
initial begin
	in1 = -4;
	in2 = 5;
end
initial begin
	#10 select = 2'b01;
	#10 select = 2'b00;
	#10 select = 2'b01;
	#10 select = 2'b00;

#10 $stop;
end
mux_32 test(in1, in2, out, select); 
endmodule 
