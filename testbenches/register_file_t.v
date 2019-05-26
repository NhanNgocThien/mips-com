`timescale 1ns/1ns
module register_file_t;
  reg [4:0]  read_register_1;
  reg [4:0]  read_register_2; 
  reg [4:0]  write_register; 
  reg        write_switch;
  reg [31:0] write_data;
  wire [31:0] data_1;
  wire [31:0] data_2;

  initial begin
	read_register_1 = 0;
	read_register_2 = 1;
	write_register = 2;
	write_switch = 0;
	#10 write_switch = 1;
	    write_data = 10;
	#10 write_switch = 0;
	    read_register_1 = 2;
	    read_register_2 = 2;
	    write_register = 0;
	    write_data = 20;
	#10 read_register_1 = 0;
	    write_switch = 1;
  end	

  register_files R1(read_register_1, read_register_2, write_register, write_switch, write_data, data_1, data_2);
  
endmodule
