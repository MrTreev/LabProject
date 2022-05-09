// Lab Project
// Address Decoder
module AddressDecoder(In_Address,In_Enable,Out_DecodedAddress);
	input [$clog2(P_BitWidth)-1:0] In_Address;
	input In_Enable;

	output reg [P_BitWidth-1:0] Out_DecodedAddress;

	parameter P_BitWidth=32;


always @(In_Address, In_Enable)
begin
	if(In_Enable)
	begin
		Out_DecodedAddress <= 0;
		Out_DecodedAddress[In_Address]<=1;
	end
	else
	begin
		Out_DecodedAddress <= 0;
	end
end

endmodule
