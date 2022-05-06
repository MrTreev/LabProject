module DivideByPowersOfFive(Enable, Reset, Clock, Power, Output);

	input wire Enable;
	input wire Reset;
	input wire Clock;
	input wire [2:0] Power;
	output wire Output;

	reg TempOut;
	reg [7:0] OutArray;
	reg [7:0] PowCalc;
	reg [4:0] Counter1;
	reg [4:0] Counter2;
	reg [4:0] Counter3;
	reg [4:0] Counter4;
	reg [4:0] Counter5;
	reg [4:0] Counter6;
	reg [4:0] Counter7;
	reg [4:0] Counter8;

initial begin
	TempOut = 0;
	Counter1 = 0;
	Counter2 = 0;
	Counter3 = 0;
	Counter4 = 0;
	Counter5 = 0;
	Counter6 = 0;
	Counter7 = 0;
	Counter8 = 0;
	OutArray = 8'b00000000;
	PowCalc = 8'b00000000;
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
		OutArray = 8'b00000000;
		TempOut = 0;
		Counter1 = 1;
		Counter2 = 1;
		Counter3 = 1;
		Counter4 = 1;
		Counter5 = 1;
		Counter6 = 1;
		Counter7 = 1;
		Counter8 = 1;
	end
	else if (Enable)
	begin
		Counter1 = Counter1 << 1;
		Counter1 = Counter1 + 5'b00001;
		if(&(Counter1))
		begin
			Counter1 = 0;
			Counter2 = Counter2 << 1;
			Counter2 = Counter2 + 5'b00001;
			if(&(Counter2))
			begin
				Counter2 = 0;
				Counter3 = Counter3 << 1;
				Counter3 = Counter3 + 5'b00001;
				if(&(Counter3))
				begin
					Counter3 = 0;
                                        Counter4 = Counter4 << 1;
                                        Counter4 = Counter4 + 5'b00001;
                                        if(&(Counter4))
                                        begin
                                        	Counter4 = 0;
                                        	Counter5 = Counter5 << 1;
                                        	Counter5 = Counter5 + 5'b00001;
                                        	if(&(Counter5))
                                        	begin
							Counter5 = 0;
                                                        Counter6 = Counter6 << 1;
                                                        Counter6 = Counter6 + 5'b00001;
                                                        if(&(Counter6))
                                                        begin
								Counter6 = 0;
								Counter7 = Counter7 << 1;
								Counter7 = Counter7 + 5'b00001;
								if(&(Counter7))
								begin
									Counter7 = 0;
									Counter8 = Counter8 << 1;
									Counter8 = Counter8 + 5'b00001;
									if(&(Counter8)) Counter8 = 0;
                                        				OutArray[7] = Counter8[0];
								end
                                        			OutArray[6] = Counter7[0];
                                                        end
                                        		OutArray[5] = Counter6[0];
                                        	end
                                        	OutArray[4] = Counter5[0];
                                        end
                                        OutArray[3] = Counter4[0];
				end
                                OutArray[2] = Counter3[0];
			end
			OutArray[1] = Counter2[0];
		end
		OutArray[0] = Counter1[0];
	end
	TempOut =  |(OutArray & PowCalc);
end

assign Output = !TempOut;

endmodule
