module piezo(
    input           RESET,          // 리셋 신호
    input           CLK,            // 클럭 신호
    input   [15:0]  SCORE,          // 점수 입력
    input           GAME_ACTIVE,    // 게임 활성화 신호
    input           GAME_CLEAR,     // 게임 클리어 신호
    input           BUZZER_CTRL,    // led_ctrl에서 제어하는 BUZZER 신호
    output  wire    BUZZER          // 최종 BUZZER 출력
);

parameter   [15:0] reg_do  = 16'd11659;   // 도
parameter   [15:0] reg_re  = 16'd10388;   // 레
parameter   [15:0] reg_mi  = 16'd9253;    // 미
parameter   [15:0] reg_sol = 16'd7782;    // 솔

reg [15:0] buzzer_counter_max;    // 현재 출력할 음의 주기
reg [15:0] buzzer_counter;        // 버저 카운터
reg        regBUZZER;             // 버저 출력 상태

reg [3:0] state;                  // 상태 (0: 기본, 1: 시작 음악, 2: 클리어 음악)
reg [24:0] music_timer;           // 음악 재생 타이머
reg [1:0] music_index;            // 현재 재생 중인 음악 인덱스
reg [15:0] prev_score;            // 이전 점수 저장 (점수 변화 감지용)
reg        game_clear_done;       // 클리어 음악이 재생된 후 완료 플래그
reg        game_start_done;       // 시작 음악이 재생된 후 완료 플래그

// **상태 매핑**
localparam STATE_DEFAULT = 4'd0;
localparam STATE_START   = 4'd1;
localparam STATE_CLEAR   = 4'd2;

// **음악 패턴 설정**  
reg [15:0] start_music [0:2];    // 시작 음악 패턴: 도-레-미
reg [15:0] clear_music [0:2];    // 클리어 음악 패턴: 도-미-솔

initial begin
    // 시작 음악 (도-레-미)
    start_music[0] = reg_do;
    start_music[1] = reg_re;
    start_music[2] = reg_mi;

    // 클리어 음악 (도-미-솔)
    clear_music[0] = reg_do;
    clear_music[1] = reg_mi;
    clear_music[2] = reg_sol;
end

// **상태 및 음악 재생 제어 로직**
always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        state <= STATE_START;       // 리셋 시 시작 음악 재생
        music_timer <= 0;
        music_index <= 0;
        prev_score <= 16'd0;
        buzzer_counter_max <= 0;
        game_clear_done <= 0;
        game_start_done <= 0;
    end
    else begin
        case (state)
            // 시작 음악 재생 (도-레-미 각각 1초)
            STATE_START: begin
                if (music_timer < 25'd24000000) begin
                    buzzer_counter_max <= start_music[music_index];
                    music_timer <= music_timer + 1;
                end
                else begin
                    music_timer <= 0;
                    if (music_index < 2)
                        music_index <= music_index + 1;
                    else begin
                        state <= STATE_DEFAULT;  // 시작 음악 종료
                        music_index <= 0;
                        game_start_done <= 1;    // 시작 음악 재생 완료
                    end
                end
            end

            // 기본 상태
            STATE_DEFAULT: begin
                // 클리어 음악 재생
                if (GAME_CLEAR && !game_clear_done) begin
                    state <= STATE_CLEAR;   // 클리어 신호 활성화 시 클리어 음악 재생
                    music_timer <= 0;
                    music_index <= 0;
                end
                // 게임 재시작 시 시작 음악 재생
                else if (!GAME_ACTIVE && !game_start_done) begin
                    state <= STATE_START;   // 게임 비활성화 후 시작 음악 재생
                    music_timer <= 0;
                    music_index <= 0;
                end
                else begin
                    buzzer_counter_max <= 16'd0; // 기본 상태: 무음
                end
            end

            // 클리어 음악 재생 (도-미-솔 각각 1초)
            STATE_CLEAR: begin
                if (music_timer < 25'd24000000) begin
                    buzzer_counter_max <= clear_music[music_index];
                    music_timer <= music_timer + 1;
                end
                else begin
                    music_timer <= 0;
                    if (music_index < 2) begin
                        music_index <= music_index + 1; // 다음 음으로 이동
                    end else begin
                        state <= STATE_DEFAULT;  // 클리어 음악 종료
                        music_index <= 0;
                        game_clear_done <= 1;    // 클리어 음악 완료 플래그 설정
                    end
                end
            end
        endcase

        // 점수 변화 감지
        if (!GAME_CLEAR) begin
            game_clear_done <= 0;  // 게임 클리어 신호가 비활성화되면 플래그 초기화
        end

        // 게임 시작 플래그 초기화
        if (GAME_ACTIVE) begin
            game_start_done <= 0; // 게임이 활성화되면 시작 음악 재생 가능하도록 초기화
        end

        prev_score <= SCORE;
    end
end

// **버저 카운터 및 출력 토글**
always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        buzzer_counter <= 0;
        regBUZZER <= 1'b1;
    end
    else begin
        if (buzzer_counter >= buzzer_counter_max && buzzer_counter_max != 16'd0) begin
            buzzer_counter <= 0;
            regBUZZER <= ~regBUZZER; // 버저 토글
        end
        else begin
            buzzer_counter <= buzzer_counter + 1;
        end
    end
end

// **최종 BUZZER 출력**
assign BUZZER = regBUZZER;

endmodule