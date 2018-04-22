module lcd_component(
  input CLOCK_50,	//	50 MHz clock
//	LCD Module 16X2
  output LCD_ON,	// LCD Power ON/OFF
  output LCD_BLON,	// LCD Back Light ON/OFF
  output LCD_RW,	// LCD Read/Write Select, 0 = Write, 1 = Read
  output LCD_EN,	// LCD Enable
  output LCD_RS,	// LCD Command/Data Select, 0 = Command, 1 = Data
  inout [7:0] LCD_DATA,	// LCD Data bus 8 bits
  input [1:0] mess // MESSAGE STATUS (see lcd_test)
);

//	All inout port turn to tri-state
assign	GPIO_0		=	36'hzzzzzzzzz;
assign	GPIO_1		=	36'hzzzzzzzzz;


// reset delay gives some time for peripherals to initialize
wire DLY_RST;
reset_delay r0(	.iCLK(CLOCK_50),.oRESET(DLY_RST) );


// turn LCD ON
assign	LCD_ON		=	1'b1;
assign	LCD_BLON	=	1'b1;


lcd_messages u1(
// Host Side
   .iCLK(CLOCK_50),
   .iRST_N(DLY_RST),
// LCD Side
   .LCD_DATA(LCD_DATA),
   .LCD_RW(LCD_RW),
   .LCD_EN(LCD_EN),
   .LCD_RS(LCD_RS),
	.mess(mess)
);


// blank unused 7-segment digits
assign HEX0 = 7'b111_1111;
assign HEX1 = 7'b111_1111;
assign HEX2 = 7'b111_1111;
assign HEX3 = 7'b111_1111;
assign HEX4 = 7'b111_1111;
assign HEX5 = 7'b111_1111;
assign HEX6 = 7'b111_1111;
assign HEX7 = 7'b111_1111;

endmodule