module led_ctrl(
    input           RESET,
    input           CLK,            // 클럭 입력
    input           Mode_Switch,    // 모드 스위치
    input   [8:0]   KEY,            // 버튼 입력
	 input           EASY,           // DIP 스위치: easy
    input           NORMAL,         // DIP 스위치: normal
    input           HARD,           // DIP 스위치: hard
    input           VHARD,          // DIP 스위치: vhard
    output  wire [7:0] LED,         // LED 출력
    output  reg [15:0] SCORE,       // 점수 출력
    output  reg BUZZER,             // 부저 출력
    output  reg BUZZER_CTRL,        // BUZZER 제어 신호 출력
    output  reg GAME_ACTIVE,        // 게임 활성화 신호
    output  reg GAME_CLEAR,         // 게임 클리어 신호
    output  reg GAME_START,         // 게임 시작 신호
    output  reg button_pressed      // 버튼 눌림 여부 출력 추가
	 
);

// Internal signals
reg [24:0] cnt;           // 1초 타이머 카운터
reg [24:0] LED_CHANGE_TIME;  // LED 변경 시간 설정
reg [2:0] random_led;     // 랜덤 LED 위치 저장
reg [7:0] regLED;         // LED 출력 레지스터
reg buzzer_active;        // 부저 활성화 플래그
reg [24:0] buzzer_timer;  // 부저 타이머

// 상태 정의
parameter STATE_START  = 2'b00;  // 게임 시작 상태 (모든 LED 켜기, 버튼 대기)
parameter STATE_ACTIVE = 2'b01;  // 게임 진행 상태
parameter STATE_CLEAR  = 2'b10;  // 게임 클리어 상태 (모든 LED 켜기, 버튼 대기)

reg [1:0] state;         // 현재 상태 저장

// 버튼 매핑: 역순으로 조정
wire [8:0] KEY_REVERSED;
assign KEY_REVERSED = {KEY[7], KEY[0], KEY[1], KEY[2], KEY[3], KEY[4], KEY[5], KEY[6], KEY[8]};

// DIP 버튼 관련 신호
reg [3:0] DIP_STATE; // DIP 상태 저장 (1000, 0100, 0010, 0001 형태)
reg [3:0] DIP_EDGE;       // DIP 버튼 상승 엣지 감지

// DIP_STATE 업데이트 (단순화)
always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        DIP_STATE <= 4'b0100; // 초기 상태: normal 활성화
    end
    else begin
        case ({EASY, NORMAL, HARD, VHARD})
            4'b1000: DIP_STATE <= 4'b1000; // easy 활성화
            4'b0100: DIP_STATE <= 4'b0100; // normal 활성화
            4'b0010: DIP_STATE <= 4'b0010; // hard 활성화
            4'b0001: DIP_STATE <= 4'b0001; // vhard 활성화
            default: DIP_STATE <= DIP_STATE; // 기존 상태 유지
        endcase
    end
end

// DIP_STATE에 따른 LED_CHANGE_TIME 설정
always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        LED_CHANGE_TIME <= 25'd23999999; // 기본값: normal
    end
    else begin
        case (DIP_STATE)
            4'b1000: LED_CHANGE_TIME <= 25'd35999999; // easy: 약 1.5초
            4'b0100: LED_CHANGE_TIME <= 25'd23999999; // normal: 약 1.0초
            4'b0010: LED_CHANGE_TIME <= 25'd19199999; // hard: 약 0.8초
            4'b0001: LED_CHANGE_TIME <= 25'd11999999; // vhard: 약 0.5초
            default: LED_CHANGE_TIME <= 25'd23999999; // 기본값: normal
        endcase
    end
end



// **타이머 카운터: 난이도에 따라 LED 변경 시간 적용**
always @(posedge CLK or posedge RESET) begin
    if (RESET)
        cnt <= 0;
    else if (cnt < LED_CHANGE_TIME) // DIP에 따라 설정된 시간까지 카운트
        cnt <= cnt + 1;
    else
        cnt <= 0;
end

// **LFSR 기반 난수 발생기 + 클럭 타이밍 결합**
reg [2:0] lfsr;
reg [24:0] clk_random;  // 클럭 타이밍을 이용한 랜덤 값 저장

always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        lfsr <= 3'b101; // 초기 LFSR 값
        clk_random <= 0;
    end
    else begin
        // 클럭 타이밍을 이용해 clk_random 값 증가
        clk_random <= clk_random + 1;
        
        // 1초마다 or 버튼 입력 시 LED 위치 변경
        if (cnt == LED_CHANGE_TIME || (KEY_REVERSED[random_led] && !button_pressed)) begin
            // LFSR 값과 clk_random 값의 일부 비트를 XOR하여 완전한 랜덤 구현
            lfsr <= {lfsr[1:0], lfsr[2] ^ lfsr[1] ^ clk_random[0] ^ clk_random[3] ^ clk_random[7]};
        end
    end
end

// **게임 상태 전환 및 동작**
always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        state <= STATE_START;       // 초기 상태: 게임 시작
        random_led <= 0;
        button_pressed <= 0;
        SCORE <= 0;
        GAME_ACTIVE <= 0;
        GAME_CLEAR <= 0;
        GAME_START <= 0;
        buzzer_active <= 0;
        buzzer_timer <= 0;
    end
    else begin
        case (state)
            // 게임 시작 상태: 모든 LED 켜기, 버튼 입력 대기
            STATE_START: begin
                regLED <= 8'b00000000; // 모든 LED 켜기
                GAME_ACTIVE <= 0;      // 게임 비활성화
                GAME_CLEAR <= 0;       // 클리어 신호 비활성화
                GAME_START <= 1;       // 게임 시작 신호 활성화
                if (|KEY_REVERSED) begin
                    state <= STATE_ACTIVE; // 버튼 입력 시 게임 시작
                    random_led <= lfsr;    // LED 초기화
                    buzzer_active <= 1;    // 시작 부저음 활성화
                    GAME_ACTIVE <= 1;      // 게임 활성화
                    GAME_START <= 0;       // 게임 시작 신호 비활성화
                end
            end

            // 게임 진행 상태s
            STATE_ACTIVE: begin
                regLED <= ~(8'b00000001 << random_led); // 랜덤 LED 한 개만 켜기
                if (cnt == LED_CHANGE_TIME) begin
                    random_led <= lfsr; // 난이도에 따라 LED 위치 갱신
                end
                else if (KEY_REVERSED[random_led] && !button_pressed) begin
                    button_pressed <= 1; // 버튼 눌림 플래그 설정

                    if (SCORE == 9) begin
                        buzzer_active <= 1; // 클리어 부저음 활성화
                        SCORE <= 0;         // 점수가 9에서 다시 0으로 돌아감
                        state <= STATE_CLEAR; // 클리어 상태로 전환
                        GAME_ACTIVE <= 0;    // 게임 비활성화
                        GAME_CLEAR <= 1;     // 클리어 신호 활성화
                        buzzer_timer <= 0;   // 부저 타이머 초기화
                    end
                    else
                        SCORE <= SCORE + 1; // 점수 증가

                    random_led <= lfsr;   // 즉시 다음 LED 위치로 변경
                end
                else if (!KEY_REVERSED[random_led]) begin
                    button_pressed <= 0;  // 버튼 플래그 초기화
                end
            end

            // 게임 클리어 상태: 모든 LED 켜기, 버튼 입력 대기
            STATE_CLEAR: begin
                regLED <= 8'b00000000; // 모든 LED 켜기
                if (buzzer_timer < 25'd24000000) begin // 1초간 부저음
                    buzzer_active <= 1;  // 부저 활성화
                    buzzer_timer <= buzzer_timer + 1;
                end
                else begin
                    buzzer_active <= 0;  // 부저 비활성화
                    if (|KEY_REVERSED) begin
                        state <= STATE_START; // 버튼 입력 시 초기 상태로 전환
                        random_led <= lfsr;   // LED 초기화
                        GAME_CLEAR <= 0;      // 클리어 신호 비활성화
                    end
                end
            end
        endcase
    end
end

// **부저 출력 제어 및 BUZZER_CTRL 신호**
always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        BUZZER <= 0;
        BUZZER_CTRL <= 0;
    end
    else begin
        BUZZER <= buzzer_active;        // 부저 출력
        BUZZER_CTRL <= buzzer_active;  // BUZZER_CTRL 신호 동기화
    end
end

// **LED 출력 제어**
assign LED = (!Mode_Switch) ? regLED : 8'b0;

endmodule
