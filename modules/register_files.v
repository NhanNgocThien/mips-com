module register_files(
  output [31:0] read_data_1,
  output [31:0] read_data_2,
  input [4:0]   read_register_1, 
  input [4:0]   read_register_2, 
  input [4:0]   write_register, 
  input         write_switch,
  input  [31:0] write_data
);
  reg [31:0] reg_memory[31:0];
  reg [31:0] data_1, data_2;

  assign read_data_1 = data_1; 
  assign read_data_2 = data_2;

  integer x;
  initial begin
  	for(x = 0; x < 32; x = x + 1) 
		reg_memory[x] = 32'd0;  
  end
  always@(read_register_1, read_register_2) begin
  	data_1 <= (read_register_1 == 5'd0) ? 32'd0 : reg_memory[read_register_1];
	data_2 <= (read_register_2 == 5'd0) ? 32'd0: reg_memory[read_register_2];
  end

  always@(write_register, write_data) begin
     	if(write_switch == 1) reg_memory[write_register] <= write_data;
  end

endmodule
