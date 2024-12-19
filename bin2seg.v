`timescale 1ns / 1ps

// bin2seg 모듈을 선언하고, 각 입/출력 pin 할당
module bin2seg(
	input		    	[3:0]		bin_data,   //입력 값 -> 입력 숫자 
	output	wire	[7:0]		seg_data    //출력 값 -> 7 세그먼트 표시
);

// 입력된 데이터를 7-segment에 맞게 변환
assign  seg_data = (bin_data==0)?8'b00000011:   //숫자 0
						 (bin_data==1)?8'b10011111:   //숫자 1
						 (bin_data==2)?8'b00100101:   //숫자 2
						 (bin_data==3)?8'b00001101:   //숫자 3
						 (bin_data==4)?8'b10011001:   //숫자 4
						 (bin_data==5)?8'b01001001:   //숫자 5
						 (bin_data==6)?8'b01000001:   //숫자 6
						 (bin_data==7)?8'b00011011:   //숫자 7
						 (bin_data==8)?8'b00000001:   //숫자 8
						 8'b00001001;				      //숫자 9

endmodule