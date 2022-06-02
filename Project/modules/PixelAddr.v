module PixelAddr(

	input	[9:0]	offset,
	input	[9:0]	xpos,
	input	[9:0]	ypos,
	output	[15:0]	address

);

	reg		[15:0]	addr;

	always @(*)
	begin
		addr <= ypos*9'd160 + xpos + offset;
	end

	assign address = addr;

endmodule
