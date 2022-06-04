module Project(

	// Buttons
	input BTN0,							// Button I2C Trigger
	input RST_N,						// Button Reset

	// Clocks
	input FPGA_CLK1_50,					// Clock 50MHz FPGA

//// From Avalon (HSP-FPGA Bridge)
//	input [18:0] 	Avalon_Address,		// Memory Address
//	input			Avalon_Read,		// Read Enable
//	input			Avalon_Write,		// Write Enable
//	input	[31:0]  Avalon_WriteData,	// Avalon Data HPS -> FPGA
//
//// To Avalon (HSP-FPGA Bridge)
//	output		Avalon_CLK,				// Avalon Clock
//	output[31:0] 	Avalon_ReadData,	// Avalon Data FPGA -> HPS



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
	output [19:0] GPIO_1

);

	// Define Wires
	wire			pix_clk;
	wire			frame;
    wire			i2c_clk;
    wire			hsync;
    wire			vsync;
    wire	[9:0]	pix_x;
    wire	[9:0]	pix_y;
	wire	[15:0]	pix_addr;

	// Define Registers
    reg		i2c_start = 0;

	// Direct Assignments
    assign ADV_Hsync = ~hsync;
    assign ADV_Vsync = ~vsync;

	// Configure Clocks, ADV leads pix_clk by 90 degrees
    ClockDividerPow2 #(1) div_pix_clk(FPGA_CLK1_50,RST_N,pix_clk);
    ClockDividerPow2 #(1) div_adv_clk(~FPGA_CLK1_50,RST_N,ADV_CLK);
    ClockDividerPow2 #(12) i2c_clkdiv(FPGA_CLK1_50,RST_N,i2c_clk);

	// Configure Hsync, Vsync, ADV_DE, And Pixel x and y values
    PixelCursor pixel_cursor(
    	pix_clk,
    	RST_N,
    	pix_x,
    	pix_y,
    	ADV_DE,
    	hsync,
    	vsync
    );

	// Get Pixel Address from x and y values
	PixelAddr PixAddr(
		pix_x,
		pix_y,
		pix_addr,
		frame
	);

	// Get Pixel Value from Pixel Address
	PixelStream PixStream(pix_addr,ADV_D);

	// Synchronous button press trigger for I2C
    always @(posedge(i2c_clk))
    	i2c_start <= ~BTN0;

	// I2C Configuration
    I2CSubsystem i2c(
    	.Start(i2c_start),
    	.Clock(i2c_clk),
    	.Reset_n(RST_N),
    	.SDA(ADV_SDA),
    	.SCL(ADV_SCL)
    );

	// GPOI Congiguration for testing using Analog Discovery 2 Ni Edition.
	// Wires correlated to the Analog Discovery pin names in Waveforms
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
	// Assigning GPIO Outputs for analysis
    assign DIO0		= ADV_CLK;
    assign DIO1		= ADV_DE;
    assign DIO2		= ADV_Hsync;
    assign DIO3		= ADV_Vsync;
    assign DIO4		= ADV_SCL;
    assign DIO5		= ADV_SDA;
    assign DIO6		= i2c_clk;
    assign DIO7		= pix_clk;
    assign DIO8		= RST_N;
    assign DIO9		= frame;
    assign DIO10	= 0;
    assign DIO11	= 0;
    assign DIO12	= 0;
    assign DIO13	= 0;
    assign DIO14	= 0;
    assign DIO15	= 0;
	// Assign wires to GPIO Pins
    assign GPIO_1	= {2'b0, DIO15, DIO14, DIO13, DIO12, DIO11, DIO10, DIO9, DIO8,  DIO7, DIO6, DIO5, DIO4, DIO3, DIO2, DIO1, DIO0, 2'b0};

endmodule
