module I2CDataFeed (
	input Update,
	input Reset_n,
	output reg [1:0] Op = 0,
	output reg [7:0] Data = 0
);

localparam OP_STOP = 0;		// Stop indefinately
localparam OP_START = 1;	// Send start or repeat start signal
localparam OP_CONTINUE = 2;	// Continue sending data
localparam OP_RESTART = 3;	// Stop the transaction and start a new one

localparam SLAVE_ADDR = 'h72; // or 'h7A ?

reg [4:0] state = 0;

always @(posedge(Update), negedge(Reset_n))
begin
	if (~Reset_n)
		state <= 0;
	else begin
		case (state)
			31: // The last state
				state <= 0;
			default:
				state <= state + 1;
		endcase
	end
end

always @(state)
begin
	case (state)
		0: begin
			Op <= OP_STOP;
			Data <= 0;
		end
		// Power-up the Tx (HPD must be high)
		// 	 0x41[6] = 0b0 for power-up – power-down
		1: begin
			Op <= OP_START;
			Data <= SLAVE_ADDR;
		end
		2: begin
			Op <= OP_CONTINUE;
			Data <= 'h41;
		end
		3: begin
			Op <= OP_CONTINUE;
			Data <= 'h40;
		end
		// Fixed registers that must be set on power up
		// 	 0x98 = 0x03
		4: begin
			Op <= OP_RESTART;
			Data <= SLAVE_ADDR;
		end
		5: begin
			Op <= OP_CONTINUE;
			Data <= 'h98;
		end
		6: begin
			Op <= OP_CONTINUE;
			Data <= 'h03;
		end
		// 	 0x9A[7:5] = 0b111
		7: begin
			Op <= OP_RESTART;
			Data <= SLAVE_ADDR;
		end
		8: begin
			Op <= OP_CONTINUE;
			Data <= 'h9A;
		end
		9: begin
			Op <= OP_CONTINUE;
			Data <= 'hE0;
		end
		// 	 0x9C = 0x30
		10: begin
			Op <= OP_RESTART;
			Data <= SLAVE_ADDR;
		end
		11: begin
			Op <= OP_CONTINUE;
			Data <= 'h9C;
		end
		12: begin
			Op <= OP_CONTINUE;
			Data <= 'h30;
		end
		// 	 0x9D[1:0] = 0b01
		13: begin
			Op <= OP_CONTINUE;
			Data <= 'h01;
		end
		// 	 0xA2 = 0xA4
		14: begin
			Op <= OP_RESTART;
			Data <= SLAVE_ADDR;
		end
		15: begin
			Op <= OP_CONTINUE;
			Data <= 'hA2;
		end
		16: begin
			Op <= OP_CONTINUE;
			Data <= 'hA4;
		end
		// 	 0xA3 = 0xA4
		17: begin
			Op <= OP_CONTINUE;
			Data <= 'hA4;
		end
		// 	 0xE0[7:0] = 0xD0
		18: begin
			Op <= OP_RESTART;
			Data <= SLAVE_ADDR;
		end
		19: begin
			Op <= OP_CONTINUE;
			Data <= 'hE0;
		end
		20: begin
			Op <= OP_CONTINUE;
			Data <= 'hD0;
		end
		// 	 0xF9[7:0] = 0x00
		21: begin
			Op <= OP_RESTART;
			Data <= SLAVE_ADDR;
		end
		22: begin
			Op <= OP_CONTINUE;
			Data <= 'hF9;
		end
		23: begin
			Op <= OP_CONTINUE;
			Data <= 'h00;
		end
		// Set up the video input mode
		// Set up the video output mode
		// 	 0x15[3:0] – Video Format ID (default = 4:4:4)
		24: begin
			Op <= OP_RESTART;
			Data <= SLAVE_ADDR;
		end
		25: begin
			Op <= OP_CONTINUE;
			Data <= 'h15;
		end
		26: begin
			Op <= OP_CONTINUE;
			Data <= 'h00;
		end
		// 	 0x16[7:6] = 0b0 for 4:4:4 – Output Format (4:4:4 vs 4:2:2)
		// 	 0x16[5:4] – Input Color Depth for 4:2:2 (default = 12 bit)
		// 	 0x16[3:2] – Video Input Style (default style = 2)
		27: begin
			Op <= OP_CONTINUE;
			Data <= 'h34;
		end
		// 	 0x17[1] – Aspect ratio of input video (4x3 = 0b0, 16x9 = 0b1)
		28: begin
			Op <= OP_CONTINUE;
			Data <= 'h00;
		end
		// 	 0xAF[1] = 0b1 for HDMI – Manual HDMI or DVI mode select
		29: begin
			Op <= OP_RESTART;
			Data <= SLAVE_ADDR;
		end
		30: begin
			Op <= OP_CONTINUE;
			Data <= 'hAF;
		end
		31: begin
			Op <= OP_CONTINUE;
			Data <= 'h02;
		end
	endcase
end

endmodule