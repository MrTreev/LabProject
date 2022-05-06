module ClockDivider(Enable, Reset, SysClock, Clock_100Hz, Clock_2x5Hz, Clock_1Hz);

	input wire Enable;
	input wire Reset;
	input wire SysClock;

	output wire Clock_100Hz;
	output wire Clock_2x5Hz;
	output wire Clock_1Hz;

	wire W_Clock_640Hz;
	wire W_Clock_128Hz;
	wire W_Clock_5Hz;

	DivideByPowersOfFive Clock640Hz(
		.Enable(Enable),
		.Reset(Reset),
		.Clock(SysClock),
		.Power(3'o5),
		.Output(W_Clock_640Hz)
	);

	DivideByFive Clock128Hz(
		.Enable(Enable),
		.Reset(Reset),
		.Clock(W_Clock_640Hz),
		.Output(W_Clock_128Hz)
	);

	DivideByPowersOfTwo Clock100Hz(
		.Enable(Enable),
		.Reset(Reset),
		.Power(3'o5),
		.Clock(W_Clock_640Hz),
		.Output(Clock_100Hz)
	);

	DivideByPowersOfTwo Clock5Hz(
		.Enable(Enable),
		.Reset(Reset),
		.Power(3'o7),
		.Clock(W_Clock_128Hz),
		.Output(W_Clock_5Hz)
	);

	DivideByPowersOfTwo Clock2x5Hz(
		.Enable(Enable),
		.Reset(Reset),
		.Power(3'o0),
		.Clock(W_Clock_5Hz),
		.Output(Clock_2x5Hz)
	);

	DivideByFive Clock1Hz(
		.Enable(Enable),
		.Reset(Reset),
		.Clock(W_Clock_5Hz),
		.Output(Clock_1Hz)
	);

endmodule
