module Project(
	// Clocks
	input FPGA_CLK1_50,					// 50MHz FPGA Clock

	// From Avalon (HSP-FPGA Bridge, formerly Avalon)
	input 	[18:0] 	Avalon_Address, 	// Memory Address
	input			Avalon_Read, 		// Read Enable
	input			Avalon_Write, 		// Write Enable
	input	[31:0]  Avalon_WriteData, 	// Avalon Data HPS -> FPGA

	// To Avalon (HSP-FPGA Bridge, formerly Avalon)
	output			Avalon_CLK, 		// Avalon Clock
	output 	[31:0] 	Avalon_ReadData, 	// Avalon Data FPGA -> HPS



	// From ADV7513
	input 		ADV_HPD,				// ADV HDMI Hot Plug Detect

	// To ADV7513
	output			ADV_DE,				// ADV Data Enable
	output			ADV_CLK,			// ADV Video Clock
	output	[23:0] 	ADV_D,				// ADV Video Data
	output			ADV_Hsync,			// ADV Horizontal Sync
	output			ADV_Vsync,			// ADV Vertical Sync
	output			ADV_SDA,			// ADV Serial Port Data
	output			ADV_SCL,			// ADV Serial Port Data Clock

	input RST_N
);

wire pix_clk;
PLLPixelClock pll_pixel_clock (.refclk(FPGA_CLK1_50), .rst(RST_N), .outclk_0(ADV_CLK), .outclk_1(pix_clk));
// ADC_CLK leads pix_clk by 90 degrees

wire hsync;
wire vsync;
assign ADV_Hsync = ~hsync;
assign ADV_Vsync = ~vsync;

PixelCursor pixel_cursor (
	.pix_clk(pix_clk),
	.reset_n(RST_N),
	.hcount(),
	.vcount(),
	.active(ADV_DE),
	.hsync(hsync),
	.vsync(vsync)
);

assign ADV_D = ADV_DE ? 24'h00ff00 : 0;

endmodule
