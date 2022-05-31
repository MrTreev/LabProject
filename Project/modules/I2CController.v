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

localparam OP_STOP			= 2'd0;	// Stop indefinately
localparam OP_START			= 2'd1;	// Send start or repeat start signal
localparam OP_CONTINUE		= 2'd2;	// Continue sending data
localparam OP_RESTART		= 2'd3;	// Stop the transaction and start a new one

localparam STATE_IDLE 		= 6'd00;
localparam STATE_START_0 	= 6'd01;
localparam STATE_START_1 	= 6'd02;
localparam STATE_START_2 	= 6'd03;
localparam STATE_BIT7_0 	= 6'd04;
localparam STATE_BIT7_1 	= 6'd05;
localparam STATE_BIT7_2 	= 6'd06;
localparam STATE_BIT6_0 	= 6'd07;
localparam STATE_BIT6_1 	= 6'd08;
localparam STATE_BIT6_2 	= 6'd09;
localparam STATE_BIT5_0 	= 6'd10;
localparam STATE_BIT5_1 	= 6'd11;
localparam STATE_BIT5_2 	= 6'd12;
localparam STATE_BIT4_0 	= 6'd13;
localparam STATE_BIT4_1 	= 6'd14;
localparam STATE_BIT4_2 	= 6'd15;
localparam STATE_BIT3_0 	= 6'd16;
localparam STATE_BIT3_1 	= 6'd17;
localparam STATE_BIT3_2 	= 6'd18;
localparam STATE_BIT2_0 	= 6'd19;
localparam STATE_BIT2_1 	= 6'd20;
localparam STATE_BIT2_2 	= 6'd21;
localparam STATE_BIT1_0 	= 6'd22;
localparam STATE_BIT1_1 	= 6'd23;
localparam STATE_BIT1_2 	= 6'd24;
localparam STATE_BIT0_0 	= 6'd25;
localparam STATE_BIT0_1 	= 6'd26;
localparam STATE_BIT0_2 	= 6'd27;
localparam STATE_ACK_0 		= 6'd28;
localparam STATE_ACK_1 		= 6'd29;
localparam STATE_ACK_2 		= 6'd30;
localparam STATE_REPEAT_0 	= 6'd31;
localparam STATE_STOP_0 	= 6'd32;
localparam STATE_STOP_1 	= 6'd33;
localparam STATE_STOP_2 	= 6'd34;

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
				state <= state + 6'b000001;
		endcase
	end
end

reg sdar = 1; // register for SDA output
reg sda_en = 0; // if SDA should output or be high-Z
reg sclr = 1; // rergister for SCL
assign SDA = sda_en ? sdar : 1'bz; // tristate SDA
assign SCL = sclr;
assign Completed = state == STATE_ACK_1;

always @(state, Data)
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
