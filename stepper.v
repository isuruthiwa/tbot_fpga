module stepper(clock, en, reset,dir, led, stepperPins);
 
/////////// 3 bit/LED counter ///////////////
localparam SECOND_DIVIDER = 50000000;
 
input clock, reset, dir,en;
output [2:0] led;
reg [2:0] secondsCounter;
reg [31:0] clockCount1;
 
always @ (posedge clock)
begin
    if(secondsCounter == 3'b111 || reset == 0)
        secondsCounter <= 1'b0;
    clockCount1 <= clockCount1 + 1'b1;
	 
    if(clockCount1 == SECOND_DIVIDER)
        begin
            clockCount1 <= 1'b0;
            secondsCounter <= secondsCounter + 1'b1;
        end
end

assign led = ~secondsCounter;
 

/////////// Stepper Motor - half step method (using 28BYJ-48) ///////////////
 
parameter STEPPER_DIVIDER = 50000; // every 1ms
 
output [3:0] stepperPins;
reg [3:0] stepperPins;
 
reg [31:0] clockCount3;
reg [2:0] step; // 8 positions for half steps
 
always @ (posedge clock)
begin
    if((clockCount3 >= STEPPER_DIVIDER) & (en==1))
        begin
			if(dir==1'b1)
				begin
					step <= step + 1'b1;
					clockCount3 <= 1'b0;
				end
			else
				begin
					step <= step - 1'b1;
					clockCount3 <= 1'b0;
				end
			end
    else
        clockCount3 <= clockCount3 + 1'b1;
end
 
always @ (step)
begin
    case(step)
        0: stepperPins <= 4'b1000;
        1: stepperPins <= 4'b1100;
        2: stepperPins <= 4'b0100;
        3: stepperPins <= 4'b0110;
        4: stepperPins <= 4'b0010;
        5: stepperPins <= 4'b0011;
        6: stepperPins <= 4'b0001;
        7: stepperPins <= 4'b1001;
    endcase
end
 
endmodule
