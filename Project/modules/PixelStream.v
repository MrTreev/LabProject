module PixelStream(

	input	[15:0]	address,
	output	[23:0]	pixel

);
	// Define Registers
	reg [23:0] memory [19199:0];
	reg [23:0] value;

	// Initialise all registers
	initial
	begin
		value = 24'b0;
		$readmemh("PixStream.mem",memory);
	end

	always @(*)
	begin
		value <= memory[address];
	end
	assign pixel = value;
endmodule
