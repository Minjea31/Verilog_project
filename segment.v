module segment(
    input               CLK,
    input               RESET,
	 input					GAME_START,
    input               GAME_ACTIVE,        // 게임 활성화 신호 (1이면 게임 진행 중)
    input               GAME_CLEAR,         // 게임 클리어 신호 (점수 9에서 0으로 전환 시 1)
    input               BUTTON_PRESSED,     // 버튼 입력 신호
    output  reg [3:0]   FND_COM,
    output  reg [7:0]   FND_DATA,
    output  reg [15:0]  LAST_CLEAR_TIME     // 클리어 시간 출력 (LCD용)
);

// Internal signals
reg [31:0] cnt_time0;
reg        sec;
reg [15:0] cnt64k;
reg [1:0]  cnt4;
reg [15:0] regseg;             // 4자리 7-Segment 값 (BCD 형식)
reg        reset_flag;         // 버튼 리셋 플래그
reg        prev_game_active;   // 이전 GAME_ACTIVE 값 저장

// 7-Segment data
wire [7:0] seg0;
wire [7:0] seg1;
wire [7:0] seg2;
wire [7:0] seg3;

// 타이머 작동 조건
wire timer_enable = GAME_ACTIVE && !RESET && !GAME_CLEAR;

// ** GAME_ACTIVE 상승 에지 감지 ** (게임 시작 시점 감지)
wire game_start = (GAME_ACTIVE && !prev_game_active);

// ** 이전 GAME_ACTIVE 값 저장 **
always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        prev_game_active <= 1'b0;
    end else begin
        prev_game_active <= GAME_ACTIVE;
    end
end

// ** 버튼 리셋 플래그 업데이트 **
always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        reset_flag <= 1'b0;
    end
    else if (BUTTON_PRESSED && !GAME_ACTIVE) begin
        reset_flag <= 1'b1;
    end
    else if (GAME_ACTIVE) begin
        reset_flag <= 1'b0;
    end
end

// ** 1초 타이머 카운터 **
always @(posedge RESET or posedge CLK) begin
    if (RESET)
        cnt_time0 <= 32'd0;
    else if (timer_enable) begin
        if (cnt_time0 < 32'd23999999)   
            cnt_time0 <= cnt_time0 + 32'd1;
        else
            cnt_time0 <= 32'd0;
    end
    else begin
        cnt_time0 <= 32'd0;
    end
end

// ** 1초 신호 생성 **
always @(posedge RESET or posedge CLK) begin
    if (RESET)
        sec <= 1'b0;
    else if (timer_enable) begin
        if (cnt_time0 == 32'd23999999)
            sec <= 1'b1;
        else
            sec <= 1'b0;
    end 
    else begin
        sec <= 1'b0;
    end
end

// ** 타이머 동작 (BCD 카운터) **
always @(posedge RESET or posedge CLK) begin
    if (RESET || (game_start)) begin
        regseg <= 16'd0; // 게임 시작 시 regseg 리셋
    end
    else if (timer_enable && sec) begin
        if (regseg == 16'h9999)
            regseg <= 16'h0000;
        else if (regseg[11:0] == 12'h999)
            regseg <= {regseg[15:12] + 4'd1, 12'h000};
        else if (regseg[7:0] == 8'h99)
            regseg[11:0] <= {regseg[11:8] + 4'd1, 8'h00};
        else if (regseg[3:0] == 4'h9)
            regseg[7:0] <= {regseg[7:4] + 4'd1, 4'h0};
        else
            regseg[3:0] <= regseg[3:0] + 4'd1;
    end
end

// ** 마지막 클리어 시간 저장 **
always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        LAST_CLEAR_TIME <= 16'd0;
    end
    else if (GAME_START) begin
        LAST_CLEAR_TIME <= regseg; // 클리어 시점의 시간 저장
    end
end

// ** 64kHz 타이머 카운터 **
always @(posedge RESET or posedge CLK) begin
    if (RESET)
        cnt64k <= 16'd0;
    else if (cnt64k < 16'hFFFF) 
        cnt64k <= cnt64k + 16'd1;
    else
        cnt64k <= 16'd0;
end

// ** 4-way 카운터 (FND_COM 제어) **
always @(posedge RESET or posedge CLK) begin
    if (RESET)
        cnt4 <= 2'b00;
    else if (cnt64k == 16'hFFFF) begin
        if (cnt4 < 2'b11)
            cnt4 <= cnt4 + 2'b01;
        else
            cnt4 <= 2'b00;
    end
end

// ** 7-Segment 변환 모듈 연결 **
bin2seg u0 (.bin_data(regseg[15:12]), .seg_data(seg0));
bin2seg u1 (.bin_data(regseg[11:8]),  .seg_data(seg1));
bin2seg u2 (.bin_data(regseg[7:4]),   .seg_data(seg2));
bin2seg u3 (.bin_data(regseg[3:0]),   .seg_data(seg3));

// ** FND_COM 제어 **
always @(*) begin
    case (cnt4)
        2'b00  : FND_COM <= 4'b1000; // 첫 번째 자리 활성화
        2'b01  : FND_COM <= 4'b0100; // 두 번째 자리 활성화
        2'b10  : FND_COM <= 4'b0010; // 세 번째 자리 활성화
        default: FND_COM <= 4'b0001; // 네 번째 자리 활성화
    endcase
end

// ** 7-Segment 데이터 선택 **
always @(*) begin
    case (FND_COM)
        4'b1000: FND_DATA <= seg0; 
        4'b0100: FND_DATA <= seg1; 
        4'b0010: FND_DATA <= seg2; 
        default: FND_DATA <= seg3; 
    endcase
end

endmodule
