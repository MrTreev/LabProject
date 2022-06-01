module ClockDividerPow2 #(
	parameter POWER
)
(
	input clk_in,
	input reset_n,
	output clk_out
);

reg [POWER-1:0] counter_value = 0;

always @(posedge(clk_in), negedge(reset_n))
begin
	if (~reset_n)
		counter_value <= 0;
	else
		counter_value <= counter_value + 1'b1;
end

assign clk_out = counter_value[POWER-1];

endmodule
