// Lectorial 5
// Software defined UART
// Register File
module RegisterFile{
	input [2:0] address,
	input [31:0] writeData,
	input write,
	input read,
	input clock_50MHz,
	input reset_n,

	output [31:0] readData
};

	wire UCSRA_Id = regSelect[0];
	wire UCSRB_Id = regSelect[1];

	AddressDecoder ADecoder(
		.addressIn(address),
		.enable(wite),
		.decodedAddress(regSelect)
	);

	NBitRegister #(32,0) UCSRA(
	.clk(clock_50MHz), 		// Clock
	.clear_n(reset_n), 		// Active low clear (async)
	.d(writeData), 		 	// Data input
	.ld(UCSRA_Id), 			// Active High Enable
	.q() 				// Data output
	);

endmodule
