`timescale 1ns / 1ps

module textlcd(
    input               RESET,           // nRESET input
    input               CLK,             // CLOCK input
    input [15:0]        LAST_CLEAR_TIME, // 입력: 마지막 클리어된 시간 (BCD)
    output wire         LCD_RS,          // register selector
    output wire         LCD_RW,          // READ or nWRITE
    output reg          LCD_EN,          // LCD TEXT Enable
    output wire [7:0]   LCD_DATA
);

reg	[31:0] 	cnt;		//prescaler1
reg	[1:0]		status;	//counter1
reg	[10:0]	delay_lcdclk;	//prescaler2
reg	[5:0]		count_lcd;		//counter2

reg	[127:0] 	line_1;
reg	[127:0] 	line_2;
reg 	[8:0] 	set_data;

// ** 초기화 **
initial begin
    line_1	<= {"Whack a Mole    "};
    line_2	<= {"Time Taken:   s "}; // 기본값
end
// ** 소요 시간 데이터 업데이트 (BCD -> ASCII 변환) **
always @(*) begin
    // `LAST_CLEAR_TIME`의 십의 자리와 일의 자리를 추출하여 ASCII로 변환
    line_2[32:24] <= (LAST_CLEAR_TIME[7:4] + 8'd48); // 십의 자리
    line_2[23:16] <= (LAST_CLEAR_TIME[3:0] + 8'd48); // 일의 자리
end

always @ (posedge CLK or posedge RESET) begin
    if (RESET)
        cnt <= 25'd0;
    else begin
        if (cnt < 25'd23999999)		
            cnt <= cnt + 25'd1;
        else
            cnt <= 25'd0;
    end
end

always @(posedge RESET or posedge CLK) begin
    if (RESET) begin
        delay_lcdclk	<=	11'd0;
        count_lcd		<=	6'd0; 
        LCD_EN		<=	1'b0;
    end else begin
        if (delay_lcdclk < 11'd1800)
            delay_lcdclk <=  delay_lcdclk + 11'd1;
        else
            delay_lcdclk <= 11'd0;

        if (delay_lcdclk == 11'd0) begin
            if (count_lcd < 6'd39)
                count_lcd <= count_lcd + 6'd1;
            else
                count_lcd <= 6'd6;
        end

        if (delay_lcdclk == 11'd200)
            LCD_EN <= 1'b1;
        else if (delay_lcdclk == 11'd1800)
            LCD_EN <= 1'b0;
    end
end

// ** LCD Data Control (Based on Count_LCD) **
always @(posedge RESET or posedge CLK) begin
    if (RESET)
        set_data <= 9'd0;
    else begin
        case (count_lcd)
            16'd0		:	set_data	<=	{1'b0, 8'h38};	//mode_pwron
            16'd1		:	set_data	<=	{1'b0, 8'h38};	//mode_fnset
            16'd2		:	set_data	<=	{1'b0, 8'h0e}; //mode_onoff;
            16'd3		:	set_data	<=	{1'b0, 8'h06}; //mode_entr1;
            16'd4		:	set_data	<=	{1'b0, 8'h02};	//mode_entr2;
            16'd5		:	set_data	<=	{1'b0, 8'h01};	//mode_entr3;
            16'd6		:	set_data	<=	{1'b0, 8'h80};	//mode_seta1;
            16'd7		:	set_data	<=	{1'b1, line_1[127:120]}; // mode_wr1st
            16'd8		:	set_data	<=	{1'b1, line_1[119:112]};
            16'd9		:	set_data	<=	{1'b1, line_1[111:104]};
            16'd10	:	set_data	<=	{1'b1, line_1[103:96]};
            16'd11	:	set_data	<=	{1'b1, line_1[95:88]};
            16'd12	:	set_data	<=	{1'b1, line_1[87:80]};
            16'd13	:	set_data	<=	{1'b1, line_1[79:72]};
            16'd14	:	set_data	<=	{1'b1, line_1[71:64]};
            16'd15	:	set_data	<=	{1'b1, line_1[63:56]};
            16'd16	:	set_data	<=	{1'b1, line_1[55:48]};
            16'd17	:	set_data	<=	{1'b1, line_1[47:40]};
            16'd18	:	set_data	<=	{1'b1, line_1[39:32]};
            16'd19	:	set_data	<=	{1'b1, line_1[31:24]};
            16'd20	:	set_data	<=	{1'b1, line_1[23:16]};
            16'd21	:	set_data	<=	{1'b1, line_1[15:8]};
            16'd22	:	set_data	<=	{1'b1, line_1[7:0]};
            16'd23	:	set_data	<=	{1'b0, 8'hc0};		//mode_seta2;
            16'd24	:	set_data	<=	{1'b1, line_2[127:120]}; // mode_wr2nd	
            16'd25	:	set_data	<=	{1'b1, line_2[119:112]};
            16'd26	:	set_data	<=	{1'b1, line_2[111:104]};
            16'd27	:	set_data	<=	{1'b1, line_2[103:96]};
            16'd28	:	set_data	<=	{1'b1, line_2[95:88]};	
            16'd29	:	set_data	<=	{1'b1, line_2[87:80]};
            16'd30	:	set_data	<=	{1'b1, line_2[79:72]};
            16'd31	:	set_data	<=	{1'b1, line_2[71:64]};
            16'd32	:	set_data	<=	{1'b1, line_2[63:56]};	
            16'd33	:	set_data	<=	{1'b1, line_2[55:48]};
            16'd34	:	set_data	<=	{1'b1, line_2[47:40]};
            16'd35	:	set_data	<=	{1'b1, line_2[39:32]};
            16'd36	:	set_data	<=	{1'b1, line_2[31:24]};	
            16'd37	:	set_data	<=	{1'b1, line_2[23:16]};
            16'd38	:	set_data	<=	{1'b1, line_2[15:8]};
            16'd39	:	set_data	<=	{1'b1, line_2[7:0]};
            16'd40	:	set_data	<=	{1'b0, 8'h02};	//mode_delay;
            16'd41	:	set_data	<=	{1'b0, 8'h02};	//mode_actcm;
            default	:	begin end
        endcase
    end
end

assign LCD_RS = set_data[8];
assign LCD_RW = 1'b0;
assign LCD_DATA = set_data[7:0];

endmodule
