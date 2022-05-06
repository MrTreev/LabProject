module Project(
	// Clocks
	input FPGA_CLK1_50, 		// 50MHz FPGA Clock

	// From AXI (HSP-FPGA Bridge, formerly Avalon)
	input 	[18:0] 	AXI_Address, 	//
	input 		AXI_Read, 	//
	input  		AXI_Rrite, 	//
	input 	[31:0]  AXI_WriteData, 	//

	// To AXI (HSP-FPGA Bridge, formerly Avalon)
	output 	[31:0] 	AXI_ReadData, 	//



	// From ADV7513
	input 		ADV_HPD, 	// ADV HDMI Hot Plug Detect

	// To ADV7513
	output 		ADV_DE, 	// ADV Data Enable
	output 		ADV_CLK, 	// ADV Video Clock
	output 	[23:0] 	ADV_D, 		// ADV Video Data
	output 		ADV_Hsync, 	// ADV Horizontal Sync
	output 		ADV_Vsync, 	// ADV Vertical Sync
	output 		ADV_SDA, 	// ADV Serial Port Data
	output 		ADV_SCL 	// ADV Serial Port Data Clock
);


endmodule
