// Lab Project
// N-Bit M-Wide Register File
module NBitMWideRegisterFile();
	input [$clog2(P_RegWidth)-1:0] In_Address,
	input [P_BitWidth-1:0] In_WriteData,
	input In_Write,
	input In_Read,
	input In_Clock_50MHz,
	input In_Reset_n,

	output [P_BitWidth-1:0] Out_ReadData

	parameter P_RegWidth;
	parameter P_BitWidth;

	reg [P_RegWidth-1:0] R_Select;



	AddressDecoder ADecoder(
		.addressIn(address),
		.enable(write),
		.decodedAddress(regSelect)
	);

	NBitRegister #(P_BitWidth,0) UCSR_i(
	.clk(clock_50MHz), 		// Clock
	.clear_n(reset_n), 		// Active low clear (async)
	.d(writeData), 		 	// Data input
	.ld(UCSRi_Id), 			// Active High Enable
	.q(readData) 			// Data output
	);


endmodule
