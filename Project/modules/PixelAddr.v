module PixelAddr(

	input	[9:0]	xpos,
	input	[9:0]	ypos,
	output	[15:0]	address,
	output	[7:0]	frameOut

);

	reg		[15:0]	addr	= 16'b0;
	reg		[15:0]	offset	= 16'b0;
	reg		[5:0]	frame	= 05'b0;

	always @(*)
	begin
		if (xpos < 10'd640 && ypos < 10'd480)
		begin
			addr <= (ypos/10'd4) * 10'd160 + (xpos/10'd4) + offset;
		end
		else if (ypos==10'd524)
		begin
			if (frame < 5'h10)
			begin
				offset <=  16'h4b00;
				frame <= frame + 5'h01;
			end
			else
			begin
				offset <= 16'b0;
				frame <= frame + 5'h1;
			end
		end
		else
		begin
			addr <= 16'b1;
		end
	end

	assign frameOut = (frame < 5'h10);
	assign address = addr;

endmodule
