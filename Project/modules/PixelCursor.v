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
	input pix_clk, // 25.2 MHz
	input reset_n,
	output [9:0] hcount,
	output [9:0] vcount,
	output active,
	output hsync,
	output vsync
);


Counter #(800) hcounter (.clk(pix_clk), .reset_n(reset_n), .value(hcount));
Counter #(525) vcounter (.clk(hcount < 400), .reset_n(reset_n), .value(vcount));

assign active = hcount < 640 && vcount < 480;
assign hsync = hcount >= 688 && hcount < 784;
assign vsync = vcount >= 513 && vcount < 515;

endmodule
