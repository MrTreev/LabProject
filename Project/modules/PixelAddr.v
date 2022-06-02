module PixelAddr(

	input	[9:0]	offset,
	input	[9:0]	xpos,
	input	[9:0]	ypos,
	output	[15:0]	address

);

	reg		[15:0]	addr;

	always @(*)
	begin
		if (xpos < 640 && ypos < 480) begin
			addr <= (ypos/10'd4) * 10'd160 + (xpos/10'd4) + offset;
		end
		else
		begin
			addr <= 16'b1;
		end
	end

	assign address = addr;

endmodule
