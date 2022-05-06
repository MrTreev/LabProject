// Lectorial 5
// Software defined UART
// Register File
module RegisterFile(
	input [2:0] address,
	input [31:0] writeData,
	input write,
	input read,
	input clock_50MHz,
	input reset_n,

	output [31:0] readData
);
	reg [7:0] regSelect;


	wire UCSRA_Id = regSelect[0];
	wire UCSRB_Id = regSelect[1];
	wire UCSRC_Id = regSelect[2];
	wire UCSRD_Id = regSelect[3];
	wire UCSRE_Id = regSelect[4];
	wire UCSRF_Id = regSelect[5];
	wire UCSRG_Id = regSelect[6];
	wire UCSRH_Id = regSelect[7];

	AddressDecoder ADecoder(
		.addressIn(address),
		.enable(write),
		.decodedAddress(regSelect)
	);

	NBitRegister #(32,0) UCSRA(
	.clk(clock_50MHz), 		// Clock
	.clear_n(reset_n), 		// Active low clear (async)
	.d(writeData), 		 	// Data input
	.ld(UCSRA_Id), 			// Active High Enable
	.q(readData) 			// Data output
	);

	NBitRegister #(32,0) UCSRB(
	.clk(clock_50MHz), 		// Clock
	.clear_n(reset_n), 		// Active low clear (async)
	.d(writeData), 		 	// Data input
	.ld(UCSRB_Id), 			// Active High Enable
	.q(readData) 			// Data output
	);

	NBitRegister #(32,0) UCSRC(
	.clk(clock_50MHz), 		// Clock
	.clear_n(reset_n), 		// Active low clear (async)
	.d(writeData), 		 	// Data input
	.ld(UCSRC_Id), 			// Active High Enable
	.q(readData) 			// Data output
	);

	NBitRegister #(32,0) UCSRD(
	.clk(clock_50MHz), 		// Clock
	.clear_n(reset_n), 		// Active low clear (async)
	.d(writeData), 		 	// Data input
	.ld(UCSRD_Id), 			// Active High Enable
	.q(readData) 			// Data output
	);

	NBitRegister #(32,0) UCSRE(
	.clk(clock_50MHz), 		// Clock
	.clear_n(reset_n), 		// Active low clear (async)
	.d(writeData), 		 	// Data input
	.ld(UCSRE_Id), 			// Active High Enable
	.q(readData) 			// Data output
	);

	NBitRegister #(32,0) UCSRF(
	.clk(clock_50MHz), 		// Clock
	.clear_n(reset_n), 		// Active low clear (async)
	.d(writeData), 		 	// Data input
	.ld(UCSRF_Id), 			// Active High Enable
	.q(readData) 			// Data output
	);

	NBitRegister #(32,0) UCSRG(
	.clk(clock_50MHz), 		// Clock
	.clear_n(reset_n), 		// Active low clear (async)
	.d(writeData), 		 	// Data input
	.ld(UCSRG_Id), 			// Active High Enable
	.q(readData) 			// Data output
	);

	NBitRegister #(32,0) UCSRH(
	.clk(clock_50MHz), 		// Clock
	.clear_n(reset_n), 		// Active low clear (async)
	.d(writeData), 		 	// Data input
	.ld(UCSRH_Id), 			// Active High Enable
	.q(readData) 			// Data output
	);


endmodule
