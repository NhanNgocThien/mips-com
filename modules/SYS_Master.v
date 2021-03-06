module SYS_Master(
  output [26:0] SYS_leds,
  input SYS_clk,
  input SYS_reset,
  input SYS_load, // Debug purpose
  input [31:0] SYS_pc_load,
  input [7:0] SYS_output_sel
);
  wire [10:0] control_unit_out;
  wire [4:0] Rd; // R format 
  wire [31:0] data_temp_1, data_temp_2;
  wire [31:0] data_sign_extend;
  wire [31:0] alu_in_2;
  wire [3:0] control_alu;
  wire [31:0] alu_temp_result;
  wire [7:0] alu_temp_status;
  wire [31:0] data_memory_result;
  wire [31:0] final_result;
  wire [31:0] pc_addr;
  wire [31:0] instruction;
  wire [1:0] exception_sig;

  wire [31:0] pc_counter;
  reg [26:0] output_sel;

  assign SYS_leds = output_sel;
  always@(*) begin
	case(SYS_output_sel)
		8'd0: output_sel = instruction[26:0];
		8'd1: output_sel = data_temp_1[26:0];
		8'd2: output_sel = alu_temp_result[26:0];
		8'd3: output_sel = alu_temp_status;
		8'd4: output_sel = data_memory_result[26:0];
		8'd5: output_sel = control_unit_out;
		8'd6: output_sel = control_alu;
		8'd7: output_sel = pc_addr[26:0];
	endcase
  end

  pc pc (pc_addr, SYS_clk, SYS_reset, SYS_load, pc_counter, SYS_pc_load);

  branch branch (pc_counter, pc_addr, data_sign_extend,
	instruction[25:0], control_unit_out[10], control_unit_out[9], alu_temp_status[7]); 

  inst_mem i_mem (instruction, SYS_clk, pc_addr);

  control_unit control_unit (control_unit_out, instruction[31:26]);

  alu_control alu_control (control_alu, control_unit_out[5:4], 
	instruction[5:0]);

  mux_5 M1 (Rd, instruction[20:16], instruction[15:11],
	control_unit_out[0]);

  register_files reg_file(data_temp_1, data_temp_2, instruction[25:21], 
	instruction[20:16], Rd[4:0], control_unit_out[1], final_result[31:0], SYS_clk, SYS_reset);
  
  mux_32 M2 (alu_in_2, data_temp_2[31:0], data_sign_extend[31:0], 
	control_unit_out[2]);

  sign_extend sign_extend (data_sign_extend[31:0], instruction[15:0]);

  alu alu (alu_temp_result, alu_temp_status, data_temp_1, alu_in_2,
	control_alu[3:0]);

  error_handle exception(exception_sig, control_unit_out[3], control_unit_out[7],
	control_unit_out[6], alu_temp_status);

  data_memory data_mem (data_memory_result, alu_temp_result[31:0], 
	data_temp_2[31:0], control_unit_out[8], exception_sig[1], SYS_clk, SYS_reset);

  mux_32 M3 (final_result, data_memory_result[31:0],
	alu_temp_result[31:0], exception_sig[0]);

endmodule
