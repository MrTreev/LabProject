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
	output [35:0] GPIO_0,
	output [35:0] GPIO_1,

	input RST_N
);

wire pix_clk;
//PLLPixelClock pll_pixel_clock (.refclk(FPGA_CLK1_50), .rst(~RST_N), .outclk_0(ADV_CLK), .outclk_1(pix_clk));
ClockDivider #(2) div_pix_clk (.clk_in(FPGA_CLK1_50), .reset_n(RST_N), .clk_out(pix_clk));
ClockDivider #(2) div_adv_clk (.clk_in(~FPGA_CLK1_50), .reset_n(RST_N), .clk_out(ADV_CLK));
// ADC_CLK leads pix_clk by 90 degrees

wire i2c_clk;
ClockDivider #(500) i2c_clkdiv (.clk_in(FPGA_CLK1_50), .reset_n(RST_N), .clk_out(i2c_clk));

wire hsync;
wire vsync;
assign ADV_Hsync = ~hsync;
assign ADV_Vsync = ~vsync;

PixelCursor pixel_cursor (
	pix_clk,
	RST_N,
	,
	,
	ADV_DE,
	hsync,
	vsync
);

assign ADV_D = ADV_DE ? 24'h00ff00 : 0;

I2CSubsystem i2c (
	.Start(~BTN0),
	.Clock(i2c_clk),
	.Reset_n(RST_N),
	.SDA(ADV_SDA),
	.SCL(ADV_SCL)
);

assign GPIO_1 = {27'b0, pix_clk, ADV_SDA, ADV_SCL, ADV_Vsync, ADV_Hsync, ADV_DE, ADV_CLK, 2'b0};
assign GPIO_0 = 36'b0;

endmodule