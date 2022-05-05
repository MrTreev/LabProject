// Lectorial 5
// Software defined UART
// Address Decoder
module AddressDecoder{
	input [2:0] addressIn,
	input enable,

	output reg [7:0] decodedAddress
};

always @(addressIn, enable)
begin
	if(enable)
	begin
		case(addressIn)
			3'b000: decodedAddress = 8'b00000001;
			3'b001: decodedAddress = 8'b00000010;
			3'b010: decodedAddress = 8'b00000100;
			3'b011: decodedAddress = 8'b00001000;
			3'b100: decodedAddress = 8'b00010000;
			3'b101: decodedAddress = 8'b00100000;
			3'b110: decodedAddress = 8'b01000000;
			3'b111: decodedAddress = 8'b10000000;
			default: decodedAddress = 8'b00000000;
		endcase
	end
	else
	begin
		decodedAddress = 8'b00000000;
	end
end

endmodule
