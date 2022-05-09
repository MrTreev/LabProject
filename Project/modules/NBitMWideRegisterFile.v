// Lab Project
// N-Bit M-Wide Register File
module NBitMWideRegisterFile(In_Address,In_WriteData,In_Write,In_Read,In_Reset_n,In_Clock_50MHz,Out_ReadData);
	input [$clog2(P_RegWidth)-1:0] In_Address;
	input [P_BitWidth-1:0] In_WriteData;
	input In_Write;
	input In_Read;
	input In_Reset_n;
	input In_Clock_50MHz;

	output [P_BitWidth-1:0] Out_ReadData;

	parameter P_RegWidth=8;
	parameter P_BitWidth=32;

	reg [P_RegWidth-1:0] R_Select;


	AddressDecoder #(P_BitWidth) Decoder(In_Address,In_Write,R_Select);


	genvar m;
	generate
		for (m=0; m<=P_RegWidth; m=m+1) begin: GenBlock
			NBitRegister #(P_BitWidth,0) UCR_m(
				In_Clock_50MHz, 	// Clock
				In_Reset_n, 		// Active low clear (async)
				In_WriteData,           // Data input
				R_Select[m],            // Active High Enable
				Out_ReadData            // Data output
			);
		end
	endgenerate


endmodule
