module Project(
	// From AXI (HSP-FPGA Bridge, formerly Avalon)
	input [18:0] AXI_Address,
	input AXI_Read,
	input AXI_Rrite,
	input [31:0] AXI_WriteData,

	// To AXI (HSP-FPGA Bridge, formerly Avalon)
	output [31:0] AXI_ReadData,



	// From ADV7513
	input ADV_HPD,

	// To ADV7513
	output ADV_DE,
	output ADV_Hsync,
	output ADV_Vsync,
	output ADV_CLK,
	output [32:0] ADV_Data,
	output ADV_I2C_SDA,
	output ADV_I2C_SCL
);


endmodule
