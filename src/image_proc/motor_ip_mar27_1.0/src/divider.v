module fredivider(clk,rst_n,clk_out);

input clk,rst_n;
output reg clk_out;
reg [15:0] counter;

always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)begin
			counter<=16'd0;
			clk_out <= 1'b0;
		end
	else
	if(counter==16'd1000) begin  // output freq = (clk/(2*1000))
		counter<=16'd0;
		clk_out <= ~clk_out;
	end
	else begin
		counter<=counter+1;
	end
end

endmodule
