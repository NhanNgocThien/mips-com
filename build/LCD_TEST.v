module LCD_TEST (	//	Host Side
					//	Host Side
input			 clock,submit,temp_reset, load, SW,
input [31:0] data, pc,
input [7:0]  select,
//	LCD Side
output	[7:0]	LCD_DATA,
output			LCD_RW,LCD_EN,LCD_RS);
//	Internal Wires/Registers
reg	[5:0]	LUT_INDEX;
reg	[8:0]	LUT_DATA;
reg	[5:0]	mLCD_ST;
reg	[17:0]	mDLY;
reg			mLCD_Start;
reg	[7:0]	mLCD_DATA;
reg			mLCD_RS;
wire		mLCD_Done;
wire reset = !submit || !temp_reset || !load || !SW; 

wire [7:0] out0, out1, out2, out3, out4, out5, out6, out7;
	LCD_decoder L0 (data[3:0], out0);
	LCD_decoder L1 (data[7:4], out1);
	LCD_decoder L2 (data[11:8], out2);
	LCD_decoder L3 (data[15:12], out3);
	LCD_decoder L4 (data[19:16], out4);
	LCD_decoder L5 (data[23:20], out5);
	LCD_decoder L6 (data[27:24], out6);
	LCD_decoder L7 (data[31:28], out7);

wire [7:0] pc0, pc1, pc2, pc3, pc4, pc5, pc6, pc7;
	LCD_decoder P0 (pc[3:0], pc0);
	LCD_decoder P1 (pc[7:4], pc1);
	LCD_decoder P2 (pc[11:8], pc2);
	LCD_decoder P3 (pc[15:12], pc3);
	LCD_decoder P4 (pc[19:16], pc4);
	LCD_decoder P5 (pc[23:20], pc5);
	LCD_decoder P6 (pc[27:24], pc6);
	LCD_decoder P7 (pc[31:28], pc7);
	
wire [7:0] sel0, sel1;
	LCD_decoder S0(select[3:0], sel0);
	LCD_decoder S1(select[7:4], sel1);

parameter	LCD_INTIAL	=	0;
parameter	LCD_LINE1	=	5;
parameter	LCD_CH_LINE	=	LCD_LINE1+16;
parameter	LCD_LINE2	=	LCD_LINE1+16+1;
parameter	LUT_SIZE	=	LCD_LINE1+32+1;

always@(posedge clock)
begin
	if( reset ) begin
		LUT_INDEX	<=	0;
		mLCD_ST		<=	0;
		mDLY		<=	0;
		mLCD_Start	<=	0;
		mLCD_DATA	<=	0;
		mLCD_RS		<=	0;
	end
	else
	begin
		if(LUT_INDEX<LUT_SIZE)
		begin
			case(mLCD_ST)
			0:	begin
					mLCD_DATA	<=	LUT_DATA[7:0];
					mLCD_RS		<=	LUT_DATA[8];
					mLCD_Start	<=	1;
					mLCD_ST		<=	1;
				end
			1:	begin
					if(mLCD_Done)
					begin
						mLCD_Start	<=	0;
						mLCD_ST		<=	2;					
					end
				end
			2:	begin
					if(mDLY<18'h3FFFE)
					mDLY	<=	mDLY+1;
					else
					begin
						mDLY	<=	0;
						mLCD_ST	<=	3;
					end
				end
			3:	begin
					LUT_INDEX	<=	LUT_INDEX+1;
					mLCD_ST	<=	0;
				end
			endcase
		end
	end
end

always@(*)
	case(LUT_INDEX)
	//	Initial
	LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
	LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
	LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
	LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
	LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
	//	Line 1
	LCD_LINE1+0:	LUT_DATA	<=	9'h14F; // O	
	LCD_LINE1+1:	LUT_DATA	<=	9'h155; // U  
	LCD_LINE1+2:	LUT_DATA	<=	9'h154; // T
	LCD_LINE1+3:	LUT_DATA	<=	9'h150; // P
	LCD_LINE1+4:	LUT_DATA	<=	9'h155; // U 
	LCD_LINE1+5:	LUT_DATA	<=	9'h154; // T 
	LCD_LINE1+6:	LUT_DATA	<=	9'h13A; // :
	LCD_LINE1+7:	LUT_DATA	<=	9'h120; // Space
	LCD_LINE1+8:	LUT_DATA	<=	{1'b1,out7}; 
	LCD_LINE1+9:	LUT_DATA	<=	{1'b1,out6}; 
	LCD_LINE1+10:	LUT_DATA	<=	{1'b1,out5}; 
	LCD_LINE1+11:	LUT_DATA	<=	{1'b1,out4}; 
	LCD_LINE1+12:	LUT_DATA	<=	{1'b1,out3}; 
	LCD_LINE1+13:	LUT_DATA	<=	{1'b1,out2};
	LCD_LINE1+14:	LUT_DATA	<=	{1'b1,out1};
	LCD_LINE1+15:	LUT_DATA	<=	{1'b1,out0};
	//	Change Line
	LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
	//	Line 2
	LCD_LINE2+0:	LUT_DATA	<=	9'h150; // P	
	LCD_LINE2+1:	LUT_DATA	<=	9'h143; // C	
	LCD_LINE2+2:	LUT_DATA	<=	9'h13A; // :
	LCD_LINE2+3:	LUT_DATA	<=	9'h120;  
	LCD_LINE2+4:	LUT_DATA	<=	{1'b1,pc1}; // pc1 
	LCD_LINE2+5:	LUT_DATA	<=	{1'b1,pc0}; // pc0
	LCD_LINE2+6:	LUT_DATA	<=	9'h120; 
	LCD_LINE2+7:	LUT_DATA	<=	9'h120;  
	LCD_LINE2+8:	LUT_DATA	<=	9'h153; // S
	LCD_LINE2+9:	LUT_DATA	<=	9'h145; // E
	LCD_LINE2+10:	LUT_DATA	<=	9'h14C; // L
	LCD_LINE2+11:	LUT_DATA	<=	9'h13A; // :
	LCD_LINE2+12:	LUT_DATA	<= {1'b1,sel1}; // sel1
	LCD_LINE2+13:	LUT_DATA	<=	{1'b1,sel0}; // sel0
	LCD_LINE2+14:	LUT_DATA	<=	9'h120; 
	LCD_LINE2+15:	LUT_DATA	<=	9'h120;  
	default:		LUT_DATA	<=	9'h120;
	endcase

LCD_Controller 		u0	(	//	Host Side
							.iDATA(mLCD_DATA),
							.iRS(mLCD_RS),
							.iStart(mLCD_Start),
							.oDone(mLCD_Done),
							.iCLK(clock),
							.iRST_N(!reset),
							//	LCD Interface
							.LCD_DATA(LCD_DATA),
							.LCD_RW(LCD_RW),
							.LCD_EN(LCD_EN),
							.LCD_RS(LCD_RS)	);

endmodule
