module optical_quad_enc(clk, quadA, quadB, count, rst_n, negative);
input clk, quadA, quadB, rst_n;
output reg [31:0] count;
output reg negative;
reg [2:0] quadA_delayed, quadB_delayed;

always @(posedge clk) quadA_delayed <= {quadA_delayed[1:0], quadA};
always @(posedge clk) quadB_delayed <= {quadB_delayed[1:0], quadB};

wire count_enable = quadA_delayed[1] ^ quadA_delayed[2] ^ quadB_delayed[1] ^ quadB_delayed[2];
wire count_direction = quadA_delayed[1] ^ quadB_delayed[2];

reg [31:0] count_int;
always @(posedge clk or negedge rst_n) begin
	if (!rst_n)begin
		count_int <= 32'd8000;
	end
	else begin
		if(count_enable) begin
			if(count_direction) count_int<=count_int + 1; else count_int<=count_int -1;
		end
	end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)begin
		count <= 32'd0;
		negative <= 1'b0;
	end
	else begin
	   if(count_int < 32'd8000) begin// -ve 
	       count <= 32'd8000-count_int;
	       negative <= 1'b1;
	   end
	   else if(count_int >= 32'd8000) begin // non negative
	       count <= count_int - 32'd8000;
           negative <= 1'b0;
	   end
	end
end
endmodule
