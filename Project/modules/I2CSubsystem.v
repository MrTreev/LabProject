module I2CSubsystem (
	// Per Hardware User Guide:
	// > The user should wait 200ms for the address to be decided
	// Therefore I2CSubsystem does not start running upon reset, but instead
	// waits for a Start signal, which may come from software or button.
	input Start,
	input Clock, // Slow clock for I2C
	input Reset_n,

	inout SDA,
	output SCL
);

wire controller_completed;
wire update_data = Start | controller_completed;

wire [7:0] data;
wire [1:0] op;

I2CController controller (
	.Data(data),
	.Op(op),
	.Clock(Clock),
	.Reset_n(Reset_n),
	.Completed(controller_completed),
	.SDA(SDA),
	.SCL(SCL)
);

I2CDataFeed data_feed (
	.Update(update_data),
	.Reset_n(Reset_n),
	.Op(op),
	.Data(data)
);

endmodule