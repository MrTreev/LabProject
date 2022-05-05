// Lectorial 5
// Software defined UART
// N-Bit Register
module NBitRegister{clk,clear_n,d,ld,q};
	parameter WIDTH = 32;
	parameter PRELOAD = 0;

	input clk; 			// Clock
	input clear_n; 			// Active low clear (async)
	input [WIDTH-1:0] d; 		// Data input
	input ld 			// Active High Enable

	output reg [WIDTH-1:0] q; 	// Data output


always@(posedge(clk), negedge(clr_n))
begin
	if(!clr_n)
		q <= PRELOAD;
	else
	begin
		if(ld)
			q <= d;
	end
end


endmodule
