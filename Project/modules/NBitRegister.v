// Lab Project
// N-Bit Register
module NBitRegister(In_Clock,In_Reset_n,In_Data,In_Enable,Out_Data);
	parameter WIDTH = 32;
	parameter PRELOAD = 0;

	input In_Clock; 			// Clock
	input In_Reset_n; 			// Active low clear (async)
	input [WIDTH-1:0] In_Data; 		// Data input
	input In_Enable; 			// Active High Enable

	output reg [WIDTH-1:0] Out_Data; 	// Data output


always@(posedge(In_Clock), negedge(In_Reset_n))
begin
	if(!In_Reset_n)
		Out_Data <= PRELOAD;
	else
	begin
		if(In_Enable)
			Out_Data <= In_Data;
	end
end


endmodule
