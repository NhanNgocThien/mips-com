module control_unit(
  output [10:0] control_signal,
  input [5:0] opcode
);
  /*
	Jump : 10
	Branch: 9
	MemRead: 8
	MemWrite: 7
	Mem2Reg: 6
	ALUOp[5:4]
	Exception 3
	ALUsrc 2
	RegWrite 1
	RegDST 0
  */
  reg [10:0] master_control;
  assign control_signal = master_control;
  
  initial begin
	master_control = 11'b0;
  end
  
  always@(*) begin
	case(opcode)
		// R-Format
		6'b000000: begin
			master_control[10:7] = 4'b0;
			master_control[6] = 1'b1;
			master_control[5:4] = 2'b10;
			master_control[3:2] = 2'b0;
			master_control[1:0] = 2'b11;
		end
		// ADDI
		6'b001000: begin
			master_control[10:7] = 4'b0;
			master_control[6] = 1'b1;
			master_control[5:4] = 2'b00;
			master_control[3] = 1'b0;
			master_control[2:1] = 2'b11;
			master_control[0] = 1'b0;
		end
		// SLTI
		6'b001010: begin
			master_control[10:7] = 4'b0;
			master_control[6] = 1'b1;
			master_control[5:4] = 2'b11;
			master_control[3] = 1'b0;
			master_control[2:1] = 2'b11;
			master_control[0] = 1'b0;
		end
		// LW
		6'b100011: begin
			master_control[10:9] = 2'b0;
			master_control[8] = 1'b1;
			master_control[7:4] = 4'b0;
			master_control[3] = 1'b0;
			master_control[2:1] = 2'b11;
			master_control[0] = 1'b0;
		end
		// SW
		6'b101011: begin
			master_control[10:8] = 3'b0;
			master_control[7] = 1'b1;
			master_control[6] = 1'b0;
			master_control[5:4] = 2'b0;
			master_control[3] = 1'b0;
			master_control[2] = 1'b1;
			master_control[1:0] = 2'b0;
	
		end
		// BEQ
		6'b000100: begin
			master_control[10] = 1'b0;
			master_control[9] = 1'b1;
			master_control[8:7] = 2'b0;
			master_control[6] = 1'bx;
			master_control[5:4] = 2'b01;
			master_control[3:1] = 3'b0;
			master_control[0] = 1'bx;
		end
		// JUMP
		6'b000010: begin
			master_control[10] = 1'b1;
			master_control[9:7] = 3'b0;
			master_control[6] = 1'bx;
			master_control[5:4] = 2'bx;
			master_control[3:0] = 4'b0;
		end
		default: begin
			master_control[10] = 1'bx;
		 	master_control[3] = 1'b1;
		end
	endcase
  end

 

endmodule
