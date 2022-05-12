module Counter
	#(MAX_COUNT)
	(clk,reset_n,value);
	parameter MAX_COUNT;

	input clk;
	input reset_n;
	output reg [$clog2(MAX_COUNT)-1:0] value = 0;


always @(posedge(clk), negedge(reset_n))
begin
	if (~reset_n)
		value <= 0;
	else if (value >= MAX_COUNT - 1)
		value <= 0;
	else
		value <= value + 1'b1;
end

endmodule
