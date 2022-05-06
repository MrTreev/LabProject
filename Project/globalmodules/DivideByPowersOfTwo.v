module DivideByPowersOfTwo(Enable, Reset, Clock, Power, Output);

	input wire Enable;
	input wire Reset;
	input wire Clock;
	input wire [2:0] Power;
	output wire Output;

	reg TempOut;
	reg [7:0] Counter;
	reg [7:0] PowCalc;

initial begin
	TempOut = 0;
	Counter = 0;
end

always @(posedge Clock)
begin
	case(Power)
		0: PowCalc = 8'b00000001;
		1: PowCalc = 8'b00000010;
		2: PowCalc = 8'b00000100;
		3: PowCalc = 8'b00001000;
		4: PowCalc = 8'b00010000;
		5: PowCalc = 8'b00100000;
		6: PowCalc = 8'b01000000;
		7: PowCalc = 8'b10000000;
		default: PowCalc = 8'b00000000;
	endcase
	if (Reset)
	begin
		TempOut = 1;
		Counter = 0;
	end
	else if (Enable)
	begin
		TempOut = !(Counter >= PowCalc);
		if(!TempOut) Counter = 0;
		else Counter = Counter + 1'b1;
	end
	else TempOut=1;
end


assign Output = !TempOut;

endmodule
