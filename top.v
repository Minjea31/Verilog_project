`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:13:23 10/13/2022 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(
	input			clock_12MHz,
	input			RESET,
	
	
	input			Mode_Switch,
	
	input			[8:0]	KEY,
	
	//LED
	output	wire	[7:0]	LED,
	
	//DOT
	output	wire	[9:0]		DOT_COL,
	output	wire	[13:0]	DOT_RAW,
	
	//FND
	output	wire	[3:0]		FND_COM,
	output	wire	[7:0]		FND_DATA,
	
	//LCD
	output wire			LCD_RS,
	output wire			LCD_RW,
	output wire			LCD_EN,
	output wire	[7:0]		LCD_DATA,
	
	
	//BUZZER
	output	wire	BUZZER,
	
	//MOTOR
	output	wire	[3:0]		MOTOR_OUT,
	
	
	// DIP 스위치 입력 추가
   input           EASY,       // 난이도 버튼: easy
   input           NORMAL,     // 난이도 버튼: normal
   input           HARD,       // 난이도 버튼: hard
   input           VHARD       // 난이도 버튼: vhard
    );
	 
	wire clock_24MHz;
	wire PLL_locked;
	
	wire [15:0] score;
	
	// DIP 스위치 난이도 신호 생성
   wire [1:0] DIP; // 난이도를 표현할 2비트 신호
	
PLL24X2	PLL24X2(
	.RESET(RESET),
	.CLK_IN1(clock_12MHz),
	.CLK_OUT1(clock_24MHz)
);

led_ctrl led_ctrl(
    .RESET(RESET),
    .CLK(clock_24MHz),
    .Mode_Switch(Mode_Switch),
    .KEY(KEY),
    .LED(LED),
    .SCORE(score),
    .BUZZER_CTRL(BUZZER_CTRL), // BUZZER 제어 신호 출력
	 .GAME_START(game_start),
    .GAME_ACTIVE(game_active), 
    .GAME_CLEAR(game_clear),
    .button_pressed(button_pressed), // 추가: 버튼 눌림 신호 출력
	 .EASY(easy),            // DIP 스위치: easy
    .NORMAL(normal),         // DIP 스위치: normal
    .HARD(hard),           // DIP 스위치: hard
    .VHARD(vhard)          // DIP 스위치: vhard
);
	
dot dot(
    .RESET(RESET),
    .CLK(clock_24MHz),
    .SCORE(score),
    .DOT_COL(DOT_COL),
    .DOT_RAW(DOT_RAW)
);

segment segment (
    .CLK(clock_24MHz),           // 입력: 클럭 신호
    .RESET(RESET),               // 입력: 리셋 신호
    .GAME_ACTIVE(game_active),   // 입력: 게임 활성화 신호
    .GAME_CLEAR(game_clear),     // 입력: 게임 클리어 신호
    .BUTTON_PRESSED(button_pressed), // 입력: 버튼 입력 신호
    .FND_COM(FND_COM),           // 출력: FND COM 신호
    .FND_DATA(FND_DATA),         // 출력: FND DATA 신호
    .LAST_CLEAR_TIME(last_clear_time) // 출력: 마지막 클리어 시간
);

  
textlcd textlcd(
    .RESET(RESET),
    .CLK(clock_24MHz),
    .LCD_RS(LCD_RS),
    .LCD_RW(LCD_RW),
    .LCD_EN(LCD_EN),
    .LCD_DATA(LCD_DATA),
    .LAST_CLEAR_TIME(last_clear_time) // segment 모듈의 마지막 클리어 시간 전달
);

piezo piezo(
    .RESET(RESET),
    .CLK(clock_24MHz),
    .SCORE(score),
    .GAME_ACTIVE(game_active),
    .GAME_CLEAR(game_clear),
    .BUZZER_CTRL(BUZZER_CTRL), // led_ctrl에서 BUZZER_CTRL 입력
    .BUZZER(BUZZER)           // 최종 BUZZER 출력
);


motor motor(
    .RESET(RESET),
    .CLK(clock_24MHz),
    .GAME_ACTIVE(game_active), // GAME_ACTIVE 신호로 모터 제어
    .MOTOR_OUT(MOTOR_OUT)
);

endmodule
