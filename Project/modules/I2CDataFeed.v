module I2CDataFeed (
	input Update,
	input Reset_n,
	output reg [1:0] Op = 0,
	output reg [7:0] Data = 0
);

localparam OP_STOP			= 2'd0;	// Stop indefinately
localparam OP_START			= 2'd1;	// Send start or repeat start signal
localparam OP_CONTINUE		= 2'd2;	// Continue sending data
localparam OP_RESTART		= 2'd3;	// Stop the transaction and start a new one

localparam SLAVE_ADDR		= 8'h72; // or 'h7A ?

reg [6:0] state = 0;

always @(posedge(Update), negedge(Reset_n))
begin
	if (~Reset_n)
		state <= 0;
	else begin
		case (state)
			93: // The last state
				state <= 0;
			default:
				state <= state + 1'b1;
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
		1: begin
        	Op <= OP_START;
        	Data <= SLAVE_ADDR;
        end
        2: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h98;
        end
        3: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h03;
        end
        4: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        5: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h01;
        end
        6: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h00;
        end
        7: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        8: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h02;
        end
        9: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h18;
        end
        10: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        11: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h03;
        end
        12: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h00;
        end
        13: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        14: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h14;
        end
        15: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h70;
        end
        16: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        17: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h15;
        end
        18: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h20;
        end
        19: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        20: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h16;
        end
        21: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h30;
        end
        22: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        23: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h18;
        end
        24: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h46;
        end
        25: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        26: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h40;
        end
        27: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h80;
        end
        28: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        29: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h41;
        end
        30: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h10;
        end
        31: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        32: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h49;
        end
        33: begin
        	Op <= OP_CONTINUE;
        	Data <= 'hA8;
        end
        34: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        35: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h55;
        end
        36: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h10;
        end
        37: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        38: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h56;
        end
        39: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h08;
        end
        40: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        41: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h96;
        end
        42: begin
        	Op <= OP_CONTINUE;
        	Data <= 'hF6;
        end
        43: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        44: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h73;
        end
        45: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h07;
        end
        46: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        47: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h76;
        end
        48: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h1f;
        end
        49: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        50: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h98;
        end
        51: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h03;
        end
        52: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        53: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h99;
        end
        54: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h02;
        end
        55: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        56: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h9a;
        end
        57: begin
        	Op <= OP_CONTINUE;
        	Data <= 'he0;
        end
        58: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        59: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h9c;
        end
        60: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h30;
        end
        61: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        62: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h9d;
        end
        63: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h61;
        end
        64: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        65: begin
        	Op <= OP_CONTINUE;
        	Data <= 'ha2;
        end
        66: begin
        	Op <= OP_CONTINUE;
        	Data <= 'ha4;
        end
        67: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        68: begin
        	Op <= OP_CONTINUE;
        	Data <= 'ha3;
        end
        69: begin
        	Op <= OP_CONTINUE;
        	Data <= 'ha4;
        end
        70: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        71: begin
        	Op <= OP_CONTINUE;
        	Data <= 'ha5;
        end
        72: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h04;
        end
        73: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        74: begin
        	Op <= OP_CONTINUE;
        	Data <= 'hab;
        end
        75: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h40;
        end
        76: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        77: begin
        	Op <= OP_CONTINUE;
        	Data <= 'haf;
        end
        78: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h14;
        end
        79: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        80: begin
        	Op <= OP_CONTINUE;
        	Data <= 'hba;
        end
        81: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h60;
        end
        82: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        83: begin
        	Op <= OP_CONTINUE;
        	Data <= 'hd1;
        end
        84: begin
        	Op <= OP_CONTINUE;
        	Data <= 'hff;
        end
        85: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        86: begin
        	Op <= OP_CONTINUE;
        	Data <= 'hde;
        end
        87: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h10;
        end
        88: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        89: begin
        	Op <= OP_CONTINUE;
        	Data <= 'he4;
        end
        90: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h60;
        end
        91: begin
        	Op <= OP_RESTART;
        	Data <= SLAVE_ADDR;
        end
        92: begin
        	Op <= OP_CONTINUE;
        	Data <= 'hfa;
        end
        93: begin
        	Op <= OP_CONTINUE;
        	Data <= 'h7d;
        end
		default: begin
			Op <= OP_STOP;
			Data <= 0;
		end
	endcase
end

endmodule
