module Project(
	// To Avalon
	input [18:0] Avalon_address,
	input Avalon_read,
	output [31:0] Avalon_readdata,
	input Avalon_write,
	input [31:0] Avalon_writedata,

	// To ADV7513
	output ADV_DE,
	output ADV_Hsync,
	output ADV_Vsync,
	output ADV_CLK,
	input ADV_HPD,
	output [32:0] ADV_Data,
	output ADV_I2C_SDA,
	output ADV_I2C_SCL
);
endmodule
