module motor_controller 
( 
    CLK100MHZ,                        //    On Board 100 Mhz
    SPEED_MB,
    CURR_POS,
    SET_POS_MB, // microBlaze
    SET_POS_PD, // Puck Detection
    TOL,
    GO,
    RESETN,
    DIR_1,
    DIR_2,
    PWM,
    ENC_1,
    ENC_2,
    MODE,
    DIR_JS,   // JoyStick
    SPEED_JS  
);

input CLK100MHZ;                //    On Board 27 MHz
output[31:0]CURR_POS;
input [31:0] SET_POS_MB;
input [31:0] SET_POS_PD;
input [7:0] SPEED_MB;
input GO;
input RESETN;
output reg DIR_1;
output reg DIR_2;
output PWM;
input ENC_1, ENC_2;
input [31:0] TOL;
input [1:0] MODE;
input DIR_JS;
input [7:0] SPEED_JS;

wire resetn = RESETN;
wire dir1, dir2;
wire clk_motor;
wire quadA, quadB;
wire [31:0] enc_count;

reg DIR;
wire pwm_raw;
reg PWM_EN;
wire neg;

// timeout counter
reg [31:0]timeout_counter;
reg toggling_enc;

//assign DIR_1 = dir1;
//assign DIR_2 = dir2;
assign quadB = ENC_2;
assign quadA = ENC_1;
assign CURR_POS = enc_count;
assign PWM = PWM_EN & pwm_raw;

reg [7:0] SPEED_INT;
reg [31:0] SET_POS;
reg [31:0] SET_POS_INT;
always @(*) begin
    if (MODE == 2'h0) begin // from image block. set_pos from image
        DIR_1 <= dir1;
        DIR_2 <= dir2;
        SPEED_INT <= SPEED_MB;
        SET_POS <= SET_POS_PD;
    end
    else if (MODE == 2'h1) begin // Joystick mode. // speed from Joystick, dir from Joystick
        DIR_1 <= DIR_JS;
        DIR_2 <= !DIR_JS;
        SPEED_INT <= SPEED_JS;
        SET_POS <= SET_POS_MB;
    end
    else if (MODE == 2'h2) begin // axilite mode. // everything from axilite
        DIR_1 <= dir1;
        DIR_2 <= dir2;
        SPEED_INT <= SPEED_MB;
        SET_POS <= SET_POS_MB;
    end
    
    else begin // from image block
        DIR_1 <= dir1;
        DIR_2 <= dir2;
        SPEED_INT <= SPEED_MB;
        SET_POS <= SET_POS_PD;
    end
end


always @ (posedge CLK100MHZ or negedge resetn) begin // this resets the counter whenm 
    if (!resetn) begin
        if(PWM_EN & toggling_enc) begin // reset counter  
            timeout_counter <= 0;
        end
        else if (PWM_EN & !toggling_enc) begin // increment counter  
            timeout_counter <= timeout_counter+1;
        end
    end
    else begin
        timeout_counter <= 0;
    end
    
end

always @(posedge CLK100MHZ or negedge resetn)begin // do this to for case when going high from low
    if (!resetn) begin
        SET_POS_INT <= SET_POS;
    end
    else begin
        if (SET_POS < TOL)begin // this avoids -ve number in comparison in the next always block
            SET_POS_INT <= TOL;
        end
        else begin
            SET_POS_INT <= SET_POS;
        end
    end
end

always @ (posedge CLK100MHZ or negedge resetn) begin
    if (!resetn) begin
        DIR <= 1'b0;
        PWM_EN <= 1'b0;
    end
    else if (GO)begin
        if (neg)begin // currently negative
             DIR <= 1'b1;
             PWM_EN <= 1'b1;
        end
        
        else if (enc_count > (SET_POS + TOL)) begin // currently higher
            DIR <= 1'b0;
            PWM_EN <= 1'b1;
        end
        else if (enc_count < (SET_POS_INT - TOL)) begin // currently lower
            DIR <= 1'b1;
            PWM_EN <= 1'b1;
        end
        else begin // within the tolerance.
            PWM_EN <= 1'b0;
        end
    end
    else begin
        DIR <= 1'b0;
        PWM_EN <= 1'b0;
    end
end

    assign dir2 = !DIR;
    assign dir1 = DIR;
    fredivider f1(.clk(CLK100MHZ),.rst_n(RESETN), .clk_out(clk_motor));
    pwm pwm1(.duty_cycle(SPEED_INT), .clk(clk_motor), .resetn(resetn), .pwm(pwm_raw));
    optical_quad_enc enc(.clk(CLK100MHZ), .quadA(quadA), .quadB(quadB), .count(enc_count), .rst_n(RESETN), .negative(neg));

endmodule
