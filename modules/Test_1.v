module Test_1(
  output [31:0] alu_result,
  output [31:0] data_1, data_2,
  output [7:0] alu_status,
  input [31:0] instruction
);
  wire [10:0] control_unit_out;
  wire [4:0] Rd; // R format 
  wire [31:0] data_temp_1, data_temp_2;
  wire [31:0] data_sign_extend;
  wire [31:0] alu_in_2;
  wire [5:0] control_alu;
  wire [31:0] alu_temp_result;
  wire [7:0] alu_temp_status;
  wire [31:0] data_memory_result;
  wire [31:0] final_result;

  assign data_1 = data_temp_1;
  assign data_2 = data_temp_2;
  assign alu_result = final_result;
  assign alu_status = alu_temp_status;

  reg [31:0] instruction_temp;

  always@(instruction) begin
	instruction_temp[31:26] = instruction[31:26];
  	instruction_temp[25:21] <= instruction[25:21];
	instruction_temp[20:16] <= instruction[20:16];
	instruction_temp[15:11] <= instruction[15:11];
	instruction_temp[10:0] <= instruction[10:0];
  end

  control_unit control_unit (control_unit_out, instruction[31:26]);
  alu_control A1(control_alu, control_unit_out[5:4], instruction_temp[5:0]);
  mux_5 M1 (Rd, instruction_temp[20:16], instruction_temp[15:11], control_unit_out[0]);
  register_files R1 (data_temp_1, data_temp_2, instruction_temp[25:21], instruction_temp[20:16], Rd[4:0], control_unit_out[1], final_result[31:0]);
  mux_32 M2 (alu_in_2, data_temp_2[31:0], data_sign_extend[31:0],  control_unit_out[2]);
  sign_extend S1(data_sign_extend[31:0], instruction_temp[15:0]);
  alu A2 (alu_temp_result, alu_temp_status, data_temp_1, alu_in_2, control_alu[5:0]);
  data_memory D1(data_memory_result, alu_temp_result[31:0], data_temp_2[31:0], control_unit_out[8], control_unit_out[7]);
  mux_32 M3 (final_result, data_memory_result[31:0], alu_temp_result[31:0], control_unit_out[6]);
  
endmodule
