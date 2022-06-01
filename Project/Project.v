module Project(
	// Buttons
	input BTN0,

	// Clocks
	input FPGA_CLK1_50,					// 50MHz FPGA Clock

//// From Avalon (HSP-FPGA Bridge, formerly Avalon)
//input 	[18:0] 	Avalon_Address, 	// Memory Address
//input			Avalon_Read, 		// Read Enable
//input			Avalon_Write, 		// Write Enable
//input	[31:0]  Avalon_WriteData, 	// Avalon Data HPS -> FPGA
//
//// To Avalon (HSP-FPGA Bridge, formerly Avalon)
//output			Avalon_CLK, 		// Avalon Clock
//output 	[31:0] 	Avalon_ReadData, 	// Avalon Data FPGA -> HPS



	// From ADV7513
	// To ADV7513
	output			ADV_DE,				// ADV Data Enable
	output			ADV_CLK,			// ADV Video Clock
	output	[23:0] 	ADV_D,				// ADV Video Data
	output			ADV_Hsync,			// ADV Horizontal Sync
	output			ADV_Vsync,			// ADV Vertical Sync
	inout			ADV_SDA,			// ADV Serial Port Data
	output			ADV_SCL,			// ADV Serial Port Data Clock

	// GPIO for debugging
	output [19:0] GPIO_1,

	input RST_N
);

wire pix_clk;
//PLLPixelClock pll_pixel_clock (.refclk(FPGA_CLK1_50), .rst(~RST_N), .outclk_0(ADV_CLK), .outclk_1(pix_clk));
ClockDividerPow2 #(1) div_pix_clk (.clk_in(FPGA_CLK1_50), .reset_n(RST_N), .clk_out(pix_clk));
ClockDividerPow2 #(1) div_adv_clk (.clk_in(~FPGA_CLK1_50), .reset_n(RST_N), .clk_out(ADV_CLK));
// ADC_CLK leads pix_clk by 90 degrees

wire i2c_clk;
ClockDividerPow2 #(12) i2c_clkdiv (.clk_in(FPGA_CLK1_50), .reset_n(RST_N), .clk_out(i2c_clk));

wire hsync;
wire vsync;
assign ADV_Hsync = ~hsync;
assign ADV_Vsync = ~vsync;

wire [9:0] pix_x;
wire [9:0] pix_y;

PixelCursor pixel_cursor (
	pix_clk,
	RST_N,
	pix_x,
	pix_y,
	ADV_DE,
	hsync,
	vsync
);

reg [23:0] color = 24'h0;
assign ADV_D = ADV_DE ? color : 24'h0;
//assign ADV_D = ADV_DE ? 24'hff0000 : 24'h0;

always @(pix_y) begin
	if (pix_y[1] == 1'b1)
		color <= 24'hff0000;
	else
		color <= 24'h00ff00;
end

reg i2c_start = 0;
always @(posedge(i2c_clk))
	i2c_start <= ~BTN0;

I2CSubsystem i2c (
	.Start(i2c_start),
	.Clock(i2c_clk),
	.Reset_n(RST_N),
	.SDA(ADV_SDA),
	.SCL(ADV_SCL)
);

wire DIO0;
wire DIO1;
wire DIO2;
wire DIO3;
wire DIO4;
wire DIO5;
wire DIO6;
wire DIO7;
wire DIO8;
wire DIO9;
wire DIO10;
wire DIO11;
wire DIO12;
wire DIO13;
wire DIO14;
wire DIO15;

assign DIO0 = ADV_CLK;
assign DIO1 = ADV_DE;
assign DIO2 = ADV_Hsync;
assign DIO3 = ADV_Vsync;
assign DIO4 = ADV_SCL;
assign DIO5 = ADV_SDA;
assign DIO6 = i2c_clk;
assign DIO7 = pix_clk;
assign DIO8 = RST_N;
assign DIO9 = FPGA_CLK1_50;
assign DIO10 = 0;
assign DIO11 = 0;
assign DIO12 = 0;
assign DIO13 = 0;
assign DIO14 = 0;
assign DIO15 = 0;

assign GPIO_1 = {2'b0, DIO15, DIO14, DIO13, DIO12, DIO11, DIO10, DIO9, DIO8,  DIO7, DIO6, DIO5, DIO4, DIO3, DIO2, DIO1, DIO0, 2'b0};

endmodule
