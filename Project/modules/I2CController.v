module I2CController (
	input [7:0] Data,
	input [1:0] Op,
	input Clock,
	input Reset_n,

	// Indicate one byte transfer has completed, upstream should update Data and Op
	// Op and Data are only expected to update when state is IDLE or when Completed rises
	output Completed,

	inout SDA,
	output SCL
);

localparam OP_STOP = 0;		// Stop indefinately
localparam OP_START = 1;	// Send start or repeat start signal
localparam OP_CONTINUE = 2;	// Continue sending data
localparam OP_RESTART = 3;	// Stop the transaction and start a new one

localparam STATE_IDLE 		= 0;
localparam STATE_START_0 	= 1;
localparam STATE_START_1 	= 2;
localparam STATE_START_2 	= 3;
localparam STATE_BIT7_0 	= 4;
localparam STATE_BIT7_1 	= 5;
localparam STATE_BIT7_2 	= 6;
localparam STATE_BIT6_0 	= 7;
localparam STATE_BIT6_1 	= 8;
localparam STATE_BIT6_2 	= 9;
localparam STATE_BIT5_0 	= 10;
localparam STATE_BIT5_1 	= 11;
localparam STATE_BIT5_2 	= 12;
localparam STATE_BIT4_0 	= 13;
localparam STATE_BIT4_1 	= 14;
localparam STATE_BIT4_2 	= 15;
localparam STATE_BIT3_0 	= 16;
localparam STATE_BIT3_1 	= 17;
localparam STATE_BIT3_2 	= 18;
localparam STATE_BIT2_0 	= 19;
localparam STATE_BIT2_1 	= 20;
localparam STATE_BIT2_2 	= 21;
localparam STATE_BIT1_0 	= 22;
localparam STATE_BIT1_1 	= 23;
localparam STATE_BIT1_2 	= 24;
localparam STATE_BIT0_0 	= 25;
localparam STATE_BIT0_1 	= 26;
localparam STATE_BIT0_2 	= 27;
localparam STATE_ACK_0 		= 28;
localparam STATE_ACK_1 		= 29;
localparam STATE_ACK_2 		= 30;
localparam STATE_REPEAT_0 	= 31;
localparam STATE_STOP_0 	= 32;
localparam STATE_STOP_1 	= 33;
localparam STATE_STOP_2 	= 34;

reg [5:0] state = STATE_IDLE;

always @(posedge(Clock), negedge(Reset_n))
begin
	if (~Reset_n)
		state <= STATE_IDLE;
	else begin
		case (state)
			STATE_IDLE:
				state <= Op == OP_START ? STATE_START_0 : STATE_IDLE;
			STATE_ACK_2:
				case (Op)
					OP_START:
						state <= STATE_REPEAT_0;
					OP_CONTINUE:
						state <= STATE_BIT7_0;
					default:
						state <= STATE_STOP_0;
				endcase
			STATE_REPEAT_0:
				state <= STATE_START_0;
			STATE_STOP_2:
				state <= Op == OP_RESTART ? STATE_START_0 : STATE_IDLE;
			default:
				state <= state + 1;
		endcase
	end
end

reg sdar = 1; // register for SDA output
reg sda_en = 0; // if SDA should output or be high-Z
reg sclr = 1; // rergister for SCL
assign SDA = sda_en ? sdar : 1'bz; // tristate SDA
assign SCL = sclr;
assign Completed = state == STATE_ACK_1;

always @(state)
begin
	case (state)
		STATE_IDLE: begin
			sdar <= 1;
			sda_en <= 1;
			sclr <= 1;
		end
		STATE_START_0: begin
			sdar <= 1;
			sda_en <= 1;
			sclr <= 1;
		end
		STATE_START_1: begin
			sdar <= 0;
			sda_en <= 1;
			sclr <= 1;
		end
		STATE_START_2: begin
			sdar <= 0;
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT7_0: begin
			sdar <= Data[7];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT7_1: begin
			sdar <= Data[7];
			sda_en <= 1;
			sclr <= 1;
		end
		STATE_BIT7_2: begin
			sdar <= Data[7];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT6_0: begin
			sdar <= Data[6];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT6_1: begin
			sdar <= Data[6];
			sda_en <= 1;
			sclr <= 1;
		end
		STATE_BIT6_2: begin
			sdar <= Data[6];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT5_0: begin
			sdar <= Data[5];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT5_1: begin
			sdar <= Data[5];
			sda_en <= 1;
			sclr <= 1;
		end
		STATE_BIT5_2: begin
			sdar <= Data[5];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT4_0: begin
			sdar <= Data[4];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT4_1: begin
			sdar <= Data[4];
			sda_en <= 1;
			sclr <= 1;
		end
		STATE_BIT4_2: begin
			sdar <= Data[4];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT3_0: begin
			sdar <= Data[3];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT3_1: begin
			sdar <= Data[3];
			sda_en <= 1;
			sclr <= 1;
		end
		STATE_BIT3_2: begin
			sdar <= Data[3];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT2_0: begin
			sdar <= Data[2];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT2_1: begin
			sdar <= Data[2];
			sda_en <= 1;
			sclr <= 1;
		end
		STATE_BIT2_2: begin
			sdar <= Data[2];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT1_0: begin
			sdar <= Data[1];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT1_1: begin
			sdar <= Data[1];
			sda_en <= 1;
			sclr <= 1;
		end
		STATE_BIT1_2: begin
			sdar <= Data[1];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT0_0: begin
			sdar <= Data[0];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_BIT0_1: begin
			sdar <= Data[0];
			sda_en <= 1;
			sclr <= 1;
		end
		STATE_BIT0_2: begin
			sdar <= Data[0];
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_ACK_0: begin
			sdar <= 0;
			sda_en <= 0;
			sclr <= 0;
		end
		STATE_ACK_1: begin
			sdar <= 0;
			sda_en <= 0;
			sclr <= 1;
		end
		STATE_ACK_2: begin
			sdar <= 0;
			sda_en <= 0;
			sclr <= 0;
		end
		STATE_REPEAT_0: begin
			sdar <= 1;
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_STOP_0: begin
			sdar <= 0;
			sda_en <= 1;
			sclr <= 0;
		end
		STATE_STOP_1: begin
			sdar <= 0;
			sda_en <= 1;
			sclr <= 1;
		end
		STATE_STOP_2: begin
			sdar <= 1;
			sda_en <= 1;
			sclr <= 1;
		end
		default: begin
			sdar <= 1;
			sda_en <= 1;
			sclr <= 1;
		end
	endcase
end

endmodule