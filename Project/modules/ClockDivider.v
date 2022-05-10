module ClockDivider #(
	parameter DIVISION
) (
	input clk_in,
	input reset_n,
	output clk_out
);

wire [$clog2(DIVISION)-1:0] counter_value;

Counter #(DIVISION) counter (.clk(clk_in), .reset_n(reset_n), .value(counter_value));

assign clk_out = counter_value >= (DIVISION / 2);

endmodule
