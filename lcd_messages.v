module lcd_messages(
// Host Side
  input iCLK,iRST_N,
// Server Message input,
  input [1:0] mess,
// LCD Side 
  output [7:0] 	LCD_DATA,
  output LCD_RW,LCD_EN,LCD_RS	
);
//	Internal Wires/Registers
reg	[5:0]	LUT_INDEX;
reg	[8:0]	LUT_DATA;
reg	[5:0]	mLCD_ST;
reg	[17:0]	mDLY;
reg		mLCD_Start;
reg	[7:0]	mLCD_DATA;
reg		mLCD_RS;
wire		mLCD_Done;


parameter	LCD_INTIAL	=	0;
parameter	LCD_LINE1	=	5;
parameter	LCD_CH_LINE	=	LCD_LINE1+16;
parameter	LCD_LINE2	=	LCD_LINE1+16+1;
parameter	LUT_SIZE	=	LCD_LINE1+32+1;

initial begin 
	refresh = 1; 
end 

always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	begin
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
					mDLY	<=	mDLY + 1'b1;
					else
					begin
						mDLY	<=	0;
						mLCD_ST	<=	3;
					end
				end
			3:	begin
					LUT_INDEX	<=	LUT_INDEX + 1'b1;
					mLCD_ST	<=	0;
				end
			endcase
		end else if(refresh == 1) begin
			LUT_INDEX <= 0;
			
			// line 2 message value is set here
			case (mess)
				0: begin 
					line2_mess[0] <= message0[0];
					line2_mess[1] <= message0[1];
					line2_mess[2] <= message0[2];
					line2_mess[3] <= message0[3];
					line2_mess[4] <= message0[4];
					line2_mess[5] <= message0[5];
					line2_mess[6] <= message0[6];
					line2_mess[7] <= message0[7];
					line2_mess[8] <= message0[8];
					line2_mess[9] <= message0[9];
					line2_mess[10] <= message0[10];
					line2_mess[11] <= message0[11];
					line2_mess[12] <= message0[12];
					line2_mess[13] <= message0[13];
					line2_mess[14] <= message0[14];
					line2_mess[15] <= message0[15];
				end
				1: begin 
					line2_mess[0] <= message1[0];
					line2_mess[1] <= message1[1];
					line2_mess[2] <= message1[2];
					line2_mess[3] <= message1[3];
					line2_mess[4] <= message1[4];
					line2_mess[5] <= message1[5];
					line2_mess[6] <= message1[6];
					line2_mess[7] <= message1[7];
					line2_mess[8] <= message1[8];
					line2_mess[9] <= message1[9];
					line2_mess[10] <= message1[10];
					line2_mess[11] <= message1[11];
					line2_mess[12] <= message1[12];
					line2_mess[13] <= message1[13];
					line2_mess[14] <= message1[14];
					line2_mess[15] <= message1[15];
				end
				2: begin
					line2_mess[0] <= message2[0];
					line2_mess[1] <= message2[1];
					line2_mess[2] <= message2[2];
					line2_mess[3] <= message2[3];
					line2_mess[4] <= message2[4];
					line2_mess[5] <= message2[5];
					line2_mess[6] <= message2[6];
					line2_mess[7] <= message2[7];
					line2_mess[8] <= message2[8];
					line2_mess[9] <= message2[9];
					line2_mess[10] <= message2[10];
					line2_mess[11] <= message2[11];
					line2_mess[12] <= message2[12];
					line2_mess[13] <= message2[13];
					line2_mess[14] <= message2[14];
					line2_mess[15] <= message2[15];
				end
				3: begin
					line2_mess[0] <= 9'h120;
					line2_mess[1] <= 9'h120;
					line2_mess[2] <= 9'h120;
					line2_mess[3] <= 9'h120;
					line2_mess[4] <= 9'h120;
					line2_mess[5] <= 9'h120;
					line2_mess[6] <= 9'h120;
					line2_mess[7] <= 9'h120;
					line2_mess[8] <= 9'h120;
					line2_mess[9] <= 9'h120;
					line2_mess[10] <= 9'h120;
					line2_mess[11] <= 9'h120;
					line2_mess[12] <= 9'h120;
					line2_mess[13] <= 9'h120;
					line2_mess[14] <= 9'h120;
					line2_mess[15] <= 9'h120;
				end
			endcase
		end
	end
end

reg [31:0] counter; 
reg refresh; 
always@(posedge iCLK) begin: increment_counter
	if(counter == 27'h5F5E100) begin
		refresh <= 1;
		counter <= 0;
	end else begin 
		counter <= counter + 1;
		refresh <= 0; 
	end 
end 

/** Message Arrays **/
reg [9:0] line1_mess [15:0];
reg [9:0] line2_mess [15:0];
// Page Recieved
wire [9:0] message0 [15:0];
assign message0[0] = 9'h150;
assign message0[1] = 9'h161;
assign message0[2] = 9'h167;
assign message0[3] = 9'h165;
assign message0[4] = 9'h120;
assign message0[5] = 9'h152;
assign message0[6] = 9'h165;
assign message0[7] = 9'h163;
assign message0[8] = 9'h165;
assign message0[9] = 9'h169;
assign message0[10] = 9'h176;
assign message0[11] = 9'h165;
assign message0[12] = 9'h164;
assign message0[13] = 9'h120;
assign message0[14] = 9'h120;
assign message0[15] = 9'h120;

// Page Loaded
wire [9:0] message1 [15:0];
assign message1[0] = 9'h150; // P
assign message1[1] = 9'h161; // a
assign message1[2] = 9'h167; // g
assign message1[3] = 9'h165; // e
assign message1[4] = 9'h120;
assign message1[5] = 9'h14c; // L
assign message1[6] = 9'h16f;
assign message1[7] = 9'h161;
assign message1[8] = 9'h164;
assign message1[9] = 9'h165;
assign message1[10] = 9'h164;
assign message1[11] = 9'h120;
assign message1[12] = 9'h120;
assign message1[13] = 9'h120;
assign message1[14] = 9'h120;
assign message1[15] = 9'h120;

// Page Sent
wire [9:0] message2 [15:0];
assign message2[0] = 9'h150; // P
assign message2[1] = 9'h161; // a
assign message2[2] = 9'h167; // g
assign message2[3] = 9'h165; // e
assign message2[4] = 9'h120;
assign message2[5] = 9'h153; // S
assign message2[6] = 9'h165;
assign message2[7] = 9'h16e;
assign message2[8] = 9'h174;
assign message2[9] = 9'h120;
assign message2[10] = 9'h120;
assign message2[11] = 9'h120;
assign message2[12] = 9'h120;
assign message2[13] = 9'h120;
assign message2[14] = 9'h120;
assign message2[15] = 9'h120;

always@(posedge iCLK)
begin
	
	case(LUT_INDEX)
	//	Initial
	LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
	LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
	LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
	LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
	LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
	//	Line 1
	LCD_LINE1+0:	LUT_DATA	<=	9'h157;	//	WEBSERVER STATUS
	LCD_LINE1+1:	LUT_DATA	<=	9'h145;
	LCD_LINE1+2:	LUT_DATA	<=	9'h142;
	LCD_LINE1+3:	LUT_DATA	<=	9'h153;
	LCD_LINE1+4:	LUT_DATA	<=	9'h145;
	LCD_LINE1+5:	LUT_DATA	<=	9'h152;
	LCD_LINE1+6:	LUT_DATA	<=	9'h156;
	LCD_LINE1+7:	LUT_DATA	<=	9'h145;
	LCD_LINE1+8:	LUT_DATA	<=	9'h152;
	LCD_LINE1+9:	LUT_DATA	<=	9'h120;
	LCD_LINE1+10:	LUT_DATA	<=	9'h153;
	LCD_LINE1+11:	LUT_DATA	<=	9'h154;
	LCD_LINE1+12:	LUT_DATA	<=	9'h141;
	LCD_LINE1+13:	LUT_DATA	<=	9'h154;
	LCD_LINE1+14:	LUT_DATA	<=	9'h155;
	LCD_LINE1+15:	LUT_DATA	<=	9'h153;
	//	Change Line
	LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
	//	Line 2
	LCD_LINE2+0:	LUT_DATA	<=	line2_mess[0];	//	0: Page Recieved
	LCD_LINE2+1:	LUT_DATA	<=	line2_mess[1]; // 1: Page Loaded
	LCD_LINE2+2:	LUT_DATA	<=	line2_mess[2]; // 2: Page Sent
	LCD_LINE2+3:	LUT_DATA	<=	line2_mess[3];
	LCD_LINE2+4:	LUT_DATA	<=	line2_mess[4];
	LCD_LINE2+5:	LUT_DATA	<=	line2_mess[5];
	LCD_LINE2+6:	LUT_DATA	<=	line2_mess[6];
	LCD_LINE2+7:	LUT_DATA	<=	line2_mess[7];
	LCD_LINE2+8:	LUT_DATA	<=	line2_mess[8];
	LCD_LINE2+9:	LUT_DATA	<=	line2_mess[9];
	LCD_LINE2+10:	LUT_DATA	<=	line2_mess[10];
	LCD_LINE2+11:	LUT_DATA	<=	line2_mess[11];
	LCD_LINE2+12:	LUT_DATA	<=	line2_mess[12];
	LCD_LINE2+13:	LUT_DATA	<=	line2_mess[13];
	LCD_LINE2+14:	LUT_DATA	<=	line2_mess[14];
	LCD_LINE2+15:	LUT_DATA	<=	line2_mess[15];
	default:		LUT_DATA	<=	9'dx ;
	endcase
end




lcd_controller u0(
//    Host Side
.iDATA(mLCD_DATA),
.iRS(mLCD_RS),
.iStart(mLCD_Start),
.oDone(mLCD_Done),
.iCLK(iCLK),
.iRST_N(iRST_N),
//    LCD Interface
.LCD_DATA(LCD_DATA),
.LCD_RW(LCD_RW),
.LCD_EN(LCD_EN),
.LCD_RS(LCD_RS)    );

endmodule