`timescale 1ns / 1ps

module dot(
    input RESET,                // 리셋 신호
    input CLK,                  // 클럭 신호
    input [15:0] SCORE,         // 점수 입력
    output reg [9:0] DOT_COL,   // DOT MATRIX COLUMN 출력
    output reg [13:0] DOT_RAW   // DOT MATRIX ROW 출력
);

reg [3:0] DOT_Data;             // 현재 표시할 숫자 저장
reg [3:0] COL_counter;          // 현재 선택된 COLUMN 카운터
reg [9:0] dot_col_reg;          // COLUMN 활성화 레지스터
reg [6:0] dot_raw_reg;          // ROW 데이터 레지스터

// 점수의 일의 자리만 표시 (0~9)
always @(posedge CLK or posedge RESET) begin
    if (RESET)
        DOT_Data <= 4'd0;
    else
        DOT_Data <= SCORE;
end

// COLUMN 카운터 (0~9 순차적으로 반복)
always @(posedge CLK or posedge RESET) begin
    if (RESET)
        COL_counter <= 4'd0;
    else if (COL_counter < 4'd9)
        COL_counter <= COL_counter + 1'b1;
    else
        COL_counter <= 4'd0;
end

// DOT MATRIX 데이터 패턴 설정
always @(*) begin
    case (DOT_Data)
        4'd0: begin // 숫자 0
            case (COL_counter)
                4'd0: begin dot_col_reg <= 10'b0000000001; dot_raw_reg <= ~7'b0111110; end
                4'd1: begin dot_col_reg <= 10'b0000000010; dot_raw_reg <= ~7'b1111111; end
                4'd2: begin dot_col_reg <= 10'b0000000100; dot_raw_reg <= ~7'b1100011; end
                4'd3: begin dot_col_reg <= 10'b0000001000; dot_raw_reg <= ~7'b1100011; end
                4'd4: begin dot_col_reg <= 10'b0000010000; dot_raw_reg <= ~7'b1100011; end
                4'd5: begin dot_col_reg <= 10'b0000100000; dot_raw_reg <= ~7'b1100011; end
                4'd6: begin dot_col_reg <= 10'b0001000000; dot_raw_reg <= ~7'b1100011; end
                4'd7: begin dot_col_reg <= 10'b0010000000; dot_raw_reg <= ~7'b1111111; end
                4'd8: begin dot_col_reg <= 10'b0100000000; dot_raw_reg <= ~7'b1111111; end
                4'd9: begin dot_col_reg <= 10'b1000000000; dot_raw_reg <= ~7'b0111110; end
            endcase
        end
        4'd1: begin // 숫자 1
            case (COL_counter)
                4'd0: begin dot_col_reg <= 10'b0000000001; dot_raw_reg <= ~7'b0001100; end
                4'd1: begin dot_col_reg <= 10'b0000000010; dot_raw_reg <= ~7'b0011100; end
                4'd2: begin dot_col_reg <= 10'b0000000100; dot_raw_reg <= ~7'b0111100; end
                4'd3: begin dot_col_reg <= 10'b0000001000; dot_raw_reg <= ~7'b0001100; end
                4'd4: begin dot_col_reg <= 10'b0000010000; dot_raw_reg <= ~7'b0001100; end
                4'd5: begin dot_col_reg <= 10'b0000100000; dot_raw_reg <= ~7'b0001100; end
                4'd6: begin dot_col_reg <= 10'b0001000000; dot_raw_reg <= ~7'b0001100; end
                4'd7: begin dot_col_reg <= 10'b0010000000; dot_raw_reg <= ~7'b0001100; end
                4'd8: begin dot_col_reg <= 10'b0100000000; dot_raw_reg <= ~7'b0001100; end
                4'd9: begin dot_col_reg <= 10'b1000000000; dot_raw_reg <= ~7'b1111111; end
            endcase
        end
        4'd2: begin // 숫자 2
            case (COL_counter)
                4'd0: begin dot_col_reg <= 10'b0000000001; dot_raw_reg <= ~7'b0111110; end
                4'd1: begin dot_col_reg <= 10'b0000000010; dot_raw_reg <= ~7'b1111111; end
                4'd2: begin dot_col_reg <= 10'b0000000100; dot_raw_reg <= ~7'b0000011; end
                4'd3: begin dot_col_reg <= 10'b0000001000; dot_raw_reg <= ~7'b0000110; end
                4'd4: begin dot_col_reg <= 10'b0000010000; dot_raw_reg <= ~7'b0001100; end
                4'd5: begin dot_col_reg <= 10'b0000100000; dot_raw_reg <= ~7'b0011000; end
                4'd6: begin dot_col_reg <= 10'b0001000000; dot_raw_reg <= ~7'b0110000; end
                4'd7: begin dot_col_reg <= 10'b0010000000; dot_raw_reg <= ~7'b1111111; end
                4'd8: begin dot_col_reg <= 10'b0100000000; dot_raw_reg <= ~7'b1111111; end
                4'd9: begin dot_col_reg <= 10'b1000000000; dot_raw_reg <= ~7'b1111111; end
            endcase
        end
        4'd3: begin // 숫자 3
            case (COL_counter)
                4'd0: begin dot_col_reg <= 10'b0000000001; dot_raw_reg <= ~7'b0111110; end
                4'd1: begin dot_col_reg <= 10'b0000000010; dot_raw_reg <= ~7'b1111111; end
                4'd2: begin dot_col_reg <= 10'b0000000100; dot_raw_reg <= ~7'b0000011; end
                4'd3: begin dot_col_reg <= 10'b0000001000; dot_raw_reg <= ~7'b0000110; end
                4'd4: begin dot_col_reg <= 10'b0000010000; dot_raw_reg <= ~7'b0011110; end
                4'd5: begin dot_col_reg <= 10'b0000100000; dot_raw_reg <= ~7'b0000110; end
                4'd6: begin dot_col_reg <= 10'b0001000000; dot_raw_reg <= ~7'b0000011; end
                4'd7: begin dot_col_reg <= 10'b0010000000; dot_raw_reg <= ~7'b1111111; end
                4'd8: begin dot_col_reg <= 10'b0100000000; dot_raw_reg <= ~7'b1111111; end
                4'd9: begin dot_col_reg <= 10'b1000000000; dot_raw_reg <= ~7'b0111110; end
            endcase
        end
		  4'd4: begin // 숫자 4
            case (COL_counter)
                4'd0	: begin	dot_col_reg <= 10'b0000000001; dot_raw_reg <= ~{7'h60}; end
				4'd1	: begin	dot_col_reg <= 10'b0000000010; dot_raw_reg <= ~{7'h66}; end
				4'd2	: begin	dot_col_reg <= 10'b0000000100; dot_raw_reg <= ~{7'h66}; end
				4'd3	: begin	dot_col_reg <= 10'b0000001000; dot_raw_reg <= ~{7'h66}; end
				4'd4	: begin	dot_col_reg <= 10'b0000010000; dot_raw_reg <= ~{7'h66}; end
				4'd5	: begin	dot_col_reg <= 10'b0000100000; dot_raw_reg <= ~{7'h66}; end
				4'd6	: begin	dot_col_reg <= 10'b0001000000; dot_raw_reg <= ~{7'h7f}; end
				4'd7	: begin	dot_col_reg <= 10'b0010000000; dot_raw_reg <= ~{7'h7f}; end
				4'd8	: begin	dot_col_reg <= 10'b0100000000; dot_raw_reg <= ~{7'h06}; end
				4'd9	: begin	dot_col_reg <= 10'b1000000000; dot_raw_reg <= ~{7'h06}; end
			endcase
        end
		  4'd5: begin // 숫자 5
            case (COL_counter)
                4'd0	: begin	dot_col_reg <= 10'b0000000001; dot_raw_reg <= ~{7'h7f}; end
				4'd1	: begin	dot_col_reg <= 10'b0000000010; dot_raw_reg <= ~{7'h7f}; end
				4'd2	: begin	dot_col_reg <= 10'b0000000100; dot_raw_reg <= ~{7'h60}; end
				4'd3	: begin	dot_col_reg <= 10'b0000001000; dot_raw_reg <= ~{7'h60}; end
				4'd4	: begin	dot_col_reg <= 10'b0000010000; dot_raw_reg <= ~{7'h7e}; end
				4'd5	: begin	dot_col_reg <= 10'b0000100000; dot_raw_reg <= ~{7'h7f}; end
				4'd6	: begin	dot_col_reg <= 10'b0001000000; dot_raw_reg <= ~{7'h03}; end
				4'd7	: begin	dot_col_reg <= 10'b0010000000; dot_raw_reg <= ~{7'h03}; end
				4'd8	: begin	dot_col_reg <= 10'b0100000000; dot_raw_reg <= ~{7'h7f}; end
				4'd9	: begin	dot_col_reg <= 10'b1000000000; dot_raw_reg <= ~{7'h7e}; end
			endcase
        end
		  4'd6: begin // 숫자 6
            case(COL_counter)
				4'd0	: begin	dot_col_reg <= 10'b0000000001; dot_raw_reg <= ~{7'h60}; end
				4'd1	: begin	dot_col_reg <= 10'b0000000010; dot_raw_reg <= ~{7'h60}; end
				4'd2	: begin	dot_col_reg <= 10'b0000000100; dot_raw_reg <= ~{7'h60}; end
				4'd3	: begin	dot_col_reg <= 10'b0000001000; dot_raw_reg <= ~{7'h60}; end
				4'd4	: begin	dot_col_reg <= 10'b0000010000; dot_raw_reg <= ~{7'h7e}; end
				4'd5	: begin	dot_col_reg <= 10'b0000100000; dot_raw_reg <= ~{7'h7f}; end
				4'd6	: begin	dot_col_reg <= 10'b0001000000; dot_raw_reg <= ~{7'h63}; end
				4'd7	: begin	dot_col_reg <= 10'b0010000000; dot_raw_reg <= ~{7'h63}; end
				4'd8	: begin	dot_col_reg <= 10'b0100000000; dot_raw_reg <= ~{7'h7f}; end
				4'd9	: begin	dot_col_reg <= 10'b1000000000; dot_raw_reg <= ~{7'h3e}; end
			endcase
        end
		  4'd7: begin // 숫자 7
            case (COL_counter)
                4'd0	: begin	dot_col_reg <= 10'b0000000001; dot_raw_reg <= ~{7'h7f}; end
				4'd1	: begin	dot_col_reg <= 10'b0000000010; dot_raw_reg <= ~{7'h7f}; end
				4'd2	: begin	dot_col_reg <= 10'b0000000100; dot_raw_reg <= ~{7'h63}; end
				4'd3	: begin	dot_col_reg <= 10'b0000001000; dot_raw_reg <= ~{7'h63}; end
				4'd4	: begin	dot_col_reg <= 10'b0000010000; dot_raw_reg <= ~{7'h03}; end
				4'd5	: begin	dot_col_reg <= 10'b0000100000; dot_raw_reg <= ~{7'h03}; end
				4'd6	: begin	dot_col_reg <= 10'b0001000000; dot_raw_reg <= ~{7'h03}; end
				4'd7	: begin	dot_col_reg <= 10'b0010000000; dot_raw_reg <= ~{7'h03}; end
				4'd8	: begin	dot_col_reg <= 10'b0100000000; dot_raw_reg <= ~{7'h03}; end
				4'd9	: begin	dot_col_reg <= 10'b1000000000; dot_raw_reg <= ~{7'h03}; end
			endcase
        end
		  4'd8: begin // 숫자 8
            case (COL_counter)
                4'd0	: begin	dot_col_reg <= 10'b0000000001; dot_raw_reg <= ~{7'h3e}; end
				4'd1	: begin	dot_col_reg <= 10'b0000000010; dot_raw_reg <= ~{7'h7f}; end
				4'd2	: begin	dot_col_reg <= 10'b0000000100; dot_raw_reg <= ~{7'h63}; end
				4'd3	: begin	dot_col_reg <= 10'b0000001000; dot_raw_reg <= ~{7'h63}; end
				4'd4	: begin	dot_col_reg <= 10'b0000010000; dot_raw_reg <= ~{7'h7f}; end
				4'd5	: begin	dot_col_reg <= 10'b0000100000; dot_raw_reg <= ~{7'h7f}; end
				4'd6	: begin	dot_col_reg <= 10'b0001000000; dot_raw_reg <= ~{7'h63}; end
				4'd7	: begin	dot_col_reg <= 10'b0010000000; dot_raw_reg <= ~{7'h63}; end
				4'd8	: begin	dot_col_reg <= 10'b0100000000; dot_raw_reg <= ~{7'h7f}; end
				4'd9	: begin	dot_col_reg <= 10'b1000000000; dot_raw_reg <= ~{7'h3e}; end
			endcase
        end
		  4'd9: begin // 숫자 9
            case (COL_counter)
                4'd0	: begin	dot_col_reg <= 10'b0000000001; dot_raw_reg <= ~{7'h3e}; end
				4'd1	: begin	dot_col_reg <= 10'b0000000010; dot_raw_reg <= ~{7'h7f}; end
				4'd2	: begin	dot_col_reg <= 10'b0000000100; dot_raw_reg <= ~{7'h63}; end
				4'd3	: begin	dot_col_reg <= 10'b0000001000; dot_raw_reg <= ~{7'h63}; end
				4'd4	: begin	dot_col_reg <= 10'b0000010000; dot_raw_reg <= ~{7'h7f}; end
				4'd5	: begin	dot_col_reg <= 10'b0000100000; dot_raw_reg <= ~{7'h3f}; end
				4'd6	: begin	dot_col_reg <= 10'b0001000000; dot_raw_reg <= ~{7'h03}; end
				4'd7	: begin	dot_col_reg <= 10'b0010000000; dot_raw_reg <= ~{7'h03}; end
				4'd8	: begin	dot_col_reg <= 10'b0100000000; dot_raw_reg <= ~{7'h03}; end
				4'd9	: begin	dot_col_reg <= 10'b1000000000; dot_raw_reg <= ~{7'h03}; end
			endcase
        end
    endcase
end

// 출력
always @(*) begin
    DOT_COL = dot_col_reg;            // 활성화된 컬럼 출력
    DOT_RAW = {dot_raw_reg, dot_raw_reg}; // ROW 데이터 설정
end

endmodule
