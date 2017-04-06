module pwm(

	input wire [7:0] duty_cycle,
	input clk,
	input resetn,
	output reg pwm
);

reg [7:0] counter;


always @ (posedge clk or negedge resetn) begin
	if(!resetn) begin
		pwm <= 0;
	end
	
	else begin
		if (counter <= duty_cycle) begin
			pwm <= 1'b1;
		end
		else begin
			pwm <= 1'b0; 
		end
	end
end


always @ (posedge clk or negedge resetn) begin
	if(!resetn) begin
		counter <= 0;
	end
	else begin
	counter <= counter + 1;
	end
end

endmodule
