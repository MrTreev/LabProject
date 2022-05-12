module I2CController (Data, Enable, Clock, Reset_n, SDA, SCL);

input [7:0] Data;
input Enable;
input Clock;
input Reset_n;

output reg SDA = 1;
output reg SCL = 1;

parameter STATE_IDLE = 0;
parameter STATE_START_0 = 1;
parameter STATE_START_1 = 2;
parameter STATE_BIT7_0 = 3;
parameter STATE_BIT7_1 = 4;
parameter STATE_BIT6_0 = 5;
parameter STATE_BIT6_1 = 6;
parameter STATE_BIT5_0 = 7;
parameter STATE_BIT5_1 = 8;
parameter STATE_BIT4_0 = 9;
parameter STATE_BIT4_1 = 10;
parameter STATE_BIT3_0 = 11;
parameter STATE_BIT3_1 = 12;
parameter STATE_BIT2_0 = 13;
parameter STATE_BIT2_1 = 14;
parameter STATE_BIT1_0 = 15;
parameter STATE_BIT1_1 = 16;
parameter STATE_BIT0_0 = 17;
parameter STATE_BIT0_1 = 18;
parameter STATE_ACK_0 = 19;
parameter STATE_ACK_1 = 20;

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
