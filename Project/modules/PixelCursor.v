// Display Resolution: 640 x 480 @ 60Hz
// Pixel Clock (MHz): 25.175
//
// Horizontal Timings:
//   Front Porch: 16
//   Sync Width: 96
//   Back Porch: 48
//   Active Pixels: 640
//   Total Pixels: 800
//
// Vertical Timings:
//   Front Porch: 10
//   Sync Width: 2
//   Back Porch: 33
//   Active Pixels: 480
//   Total Pixels: 525

module PixelCursor (
	input pix_clk, // 25 MHz
	input reset_n,
	output reg [9:0] hcount = 0,
	output reg [9:0] vcount = 0,
	output active,
	output hsync,
	output vsync
);

always @(posedge(pix_clk), negedge(reset_n)) begin
	if (~reset_n) begin
		hcount <= 0;
		vcount <= 0;
	end else begin
		if (hcount == 799) begin
			hcount <= 0;
			if (vcount == 524)
				vcount <= 0;
			else
				vcount <= vcount + 1'b1;
		end else
			hcount <= hcount + 1'b1;
	end
end

assign active = hcount < 640 && vcount < 480;
assign hsync = hcount >= 688 && hcount < 784;
assign vsync = vcount >= 513 && vcount < 515;

endmodule
