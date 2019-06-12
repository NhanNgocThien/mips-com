module register_files(
  output [31:0] read_data_1,
  output [31:0] read_data_2,
  output error_toggle,
  input [4:0]   read_register_1, 
  input [4:0]   read_register_2, 
  input [4:0]   write_register, 
  input         write_switch,
  input [31:0] write_data,
  input clk, reset, enable
);
  reg [31:0] reg_memory[31:0];
 
  assign error_toggle = (write_register == 5'd0) ? 1'b1 : 1'b0;
  assign read_data_1 = (read_register_1 == 5'd0) ? 32'd0 : reg_memory[read_register_1];
  assign read_data_2 = (read_register_2 == 5'd0) ? 32'd0: reg_memory[read_register_2];

  always@(negedge clk, negedge reset, negedge enable) begin
	if(!reset) begin
		reg_memory[0] <= 32'd0;
		reg_memory[1] <= 32'd0;
		reg_memory[2] <= 32'd0;
		reg_memory[3] <= 32'd0;
		reg_memory[4] <= 32'd0;
		reg_memory[5] <= 32'd0;
		reg_memory[6] <= 32'd0;
		reg_memory[7] <= 32'd0;
		reg_memory[8] <= 32'd0;
		reg_memory[9] <= 32'd0;
		reg_memory[10] <= 32'd0;
		reg_memory[11] <= 32'd0;
		reg_memory[12] <= 32'd0;
		reg_memory[13] <= 32'd0;
		reg_memory[14] <= 32'd0;
		reg_memory[15] <= 32'd0;
		reg_memory[16] <= 32'd0;
		reg_memory[17] <= 32'd0;
		reg_memory[18] <= 32'd0;
		reg_memory[19] <= 32'd0;
		reg_memory[20] <= 32'd0;
		reg_memory[21] <= 32'd0;
		reg_memory[22] <= 32'd0;
		reg_memory[23] <= 32'd0;
		reg_memory[24] <= 32'd0;
		reg_memory[25] <= 32'd0;
		reg_memory[26] <= 32'd0;
		reg_memory[27] <= 32'd0;
		reg_memory[28] <= 32'd0;
		reg_memory[29] <= 32'd0;
		reg_memory[30] <= 32'd0;
		reg_memory[31] <= 32'd0;
	end
	else if(!enable) reg_memory[write_register] <= 32'bx;
	else begin
				if(write_switch)
					reg_memory[write_register] <= write_data;
		end
  end


endmodule
