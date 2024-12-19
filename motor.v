module motor(
    input           RESET,         // 리셋 신호
    input           CLK,           // 클럭 신호
    input           GAME_ACTIVE,   // 게임 활성화 신호
    output reg [3:0] MOTOR_OUT     // 모터 출력 신호
);

// 내부 신호 선언
reg [31:0] cnt_motor;              // 모터 속도 제어 카운터
reg sw_dir;                        // 모터 방향 제어
reg sw_on;                         // 모터 활성화 제어

// 모터 속도 설정 (값이 작을수록 빠름)
wire [31:0] motor_speed;
assign motor_speed = 32'd960000;

// 모터 방향 및 활성화 상태 설정 (EDGE DETECTOR와 유사한 구조)
always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        sw_dir <= 1'b0;
        sw_on <= 1'b0;
    end else begin
        sw_dir <= sw_dir;          // 필요 시 방향 전환 로직 추가 가능
        sw_on <= GAME_ACTIVE;      // 게임 활성화 신호에 따라 모터 활성화
    end
end

// 모터 동작 구현 및 속도 제어
always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        cnt_motor <= 32'd0;
        MOTOR_OUT <= 4'b1001;      // 초기 출력 상태
    end
    else if (sw_on) begin          // 모터 활성화 상태
        if (cnt_motor < motor_speed - 1)
            cnt_motor <= cnt_motor + 1;
        else
            cnt_motor <= 32'd0;

        // 모터 출력 상태 변경 (사진의 로직과 유사한 순환)
        case (cnt_motor)
            0:
                if (sw_dir)
                    MOTOR_OUT <= 4'b0101;
                else
                    MOTOR_OUT <= 4'b1001;
            (motor_speed / 4):
                if (sw_dir)
                    MOTOR_OUT <= 4'b0110;
                else
                    MOTOR_OUT <= 4'b1010;
            (motor_speed / 4) * 2:
                if (sw_dir)
                    MOTOR_OUT <= 4'b1010;
                else
                    MOTOR_OUT <= 4'b0110;
            (motor_speed / 4) * 3:
                if (sw_dir)
                    MOTOR_OUT <= 4'b1001;
                else
                    MOTOR_OUT <= 4'b0101;
        endcase
    end
    else begin
        cnt_motor <= 32'd0;        // 모터 비활성화 시 카운터 초기화
        MOTOR_OUT <= 4'b0000;      // 모터 출력 비활성화
    end
end

endmodule
