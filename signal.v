module signal(
    input clk,
	 input en,
    output reg signal,
    output reg led=1'b0
    );

	reg [31:0] count =0;

	always @(posedge clk)
	begin
		if(~en)
		begin
			if(count==32'd40000)
			begin
				signal <= ~signal;
				count<=32'd0;
			end
			else
			begin
				count<=count+32'd1;
			end
		end
		else
		begin
			signal<=1'b0;
		end
	end
	//
	
	always @(signal)
	begin
		led<=signal;
	end
	
endmodule
