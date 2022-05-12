module I2CController (Data, Enable, Clock, Reset_n, SDA, SCL);

input [7:0] Data;
input Enable;
input Clock;
input Reset_n;

output reg SDA = 1;
output reg SCL = 1;

localparam STATE_IDLE 		= 0;
localparam STATE_START_0 	= 1;
localparam STATE_START_1 	= 2;
localparam STATE_BIT7_0 	= 3;
localparam STATE_BIT7_1 	= 4;
localparam STATE_BIT7_2 	= 5;
localparam STATE_BIT6_0 	= 6;
localparam STATE_BIT6_1 	= 7;
localparam STATE_BIT6_2 	= 8;
localparam STATE_BIT5_0 	= 9;
localparam STATE_BIT5_1 	= 10;
localparam STATE_BIT5_2 	= 11;
localparam STATE_BIT4_0 	= 12;
localparam STATE_BIT4_1 	= 13;
localparam STATE_BIT4_2 	= 14;
localparam STATE_BIT3_0 	= 15;
localparam STATE_BIT3_1 	= 16;
localparam STATE_BIT3_2 	= 17;
localparam STATE_BIT2_0 	= 18;
localparam STATE_BIT2_1 	= 19;
localparam STATE_BIT1_0 	= 20;
localparam STATE_BIT1_1 	= 21;
localparam STATE_BIT1_2 	= 22;
localparam STATE_BIT0_0 	= 23;
localparam STATE_BIT0_1 	= 24;
localparam STATE_BIT0_2 	= 25;
localparam STATE_ACK_0 		= 26;
localparam STATE_ACK_1 		= 27;

reg [3:0] state = STATE_IDLE;

always @(posedge(Clock), negedge(Reset_n))
begin
	if (~Reset_n)
		state <= STATE_IDLE;
	else begin
		case (state)
			default:
				state <= state + 1;
		endcase
	end
end

always @(state)
begin
	case (state)
		STATE_IDLE: begin
			SDA <= 1;
			SCL <= 1;
		end
		STATE_START_0: begin
			SDA <= 0;
			SCL <= 1;
		end
		STATE_START_1: begin
			SDA <= 0;
			SCL <= 0;
		end
		STATE_BIT7_0: begin
			SDA <= Data[7];
			SCL <= 0;
		end
		STATE_BIT7_1: begin
			SDA <= Data[7];
			SCL <= 1;
		end
		STATE_BIT7_2: begin
			SDA <= Data[7];
			SCL <= 0;
		end
		STATE_BIT6_0: begin
			SDA <= Data[6];
			SCL <= 0;
		end
	endcase
end
