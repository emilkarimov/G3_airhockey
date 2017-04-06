`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineer: Josh Sackos
// 
// Create Date:    07/11/2012
// Module Name:    PmodJSTK_Demo 
// Project Name: 	 PmodJSTK_Demo
// Target Devices: Nexys3
// Tool versions:  ISE 14.1
// Description: This is a demo for the Digilent PmodJSTK. Data is sent and received
//					 to and from the PmodJSTK at a frequency of 5Hz, and positional 
//					 data is displayed on the seven segment display (SSD). The positional
//					 data of the joystick ranges from 0 to 1023 in both the X and Y
//					 directions. Only one coordinate can be displayed on the SSD at a
//					 time, therefore switch SW0 is used to select which coordinate's data
//	   			 to display. The status of the buttons on the PmodJSTK are
//					 displayed on LD2, LD1, and LD0 on the Nexys3. The LEDs will
//					 illuminate when a button is pressed. Switches SW2 and SW1 on the
//					 Nexys3 will turn on LD1 and LD2 on the PmodJSTK respectively. Button
//					 BTND on the Nexys3 is used for resetting the demo. The PmodJSTK
//					 connects to pins [4:1] on port JA on the Nexys3. SPI mode 0 is used
//					 for communication between the PmodJSTK and the Nexys3.
//
//					 NOTE: The digits on the SSD may at times appear to flicker, this
//						    is due to small pertebations in the positional data being read
//							 by the PmodJSTK's ADC. To reduce the flicker simply reduce
//							 the rate at which the data being displayed is updated.
//
// Revision History: 
// 						Revision 0.01 - File Created (Josh Sackos)
//////////////////////////////////////////////////////////////////////////////////


// ============================================================================== 
// 										  Define Module
// ==============================================================================
module PmodJSTK_Demo(
    CLK,
    RST,
    MISO,
	 SW,
    SS,
    MOSI,
    SCLK,
    LED,
	mLED,
	 MOTOR_SPEED,
	 MOTOR_POSITION,
	 AN,
	 SEG
    );

	// ===========================================================================
	// 										Port Declarations
	// ===========================================================================
			input wire CLK;					// 100Mhz onboard clock
			input wire RST;					// Button D
			input wire MISO;					// Master In Slave Out, Pin 3, Port JA
			input wire [2:0] SW;			// Switches 2, 1, and 0
			output wire SS;					// Slave Select, Pin 1, Port JA
			output wire MOSI;				// Master Out Slave In, Pin 2, Port JA
			output wire SCLK;				// Serial Clock, Pin 4, Port JA
			output wire [2:0] LED;			// LEDs 2, 1, and 0
			output wire [3:0] AN;			// Anodes for Seven Segment Display
			output wire [6:0] SEG;			// Cathodes for Seven Segment Display
			output [4:0] mLED;
			output wire [31:0] MOTOR_SPEED;
			output  wire MOTOR_POSITION;

	// ===========================================================================
	// 							  Parameters, Regsiters, and Wires
	// ===========================================================================
			wire SS;						// Active low
			wire MOSI;					// Data transfer from master to slave
			wire SCLK;					// Serial clock that controls communication
			reg [2:0] LED;				// Status of PmodJSTK buttons displayed on LEDs
			//wire [3:0] AN;				// Anodes for Seven Segment Display
			//wire [6:0] SEG;			// Cathodes for Seven Segment Display

			// Holds data to be sent to PmodJSTK
			wire [7:0] sndData;

			// Signal to send/receive data to/from PmodJSTK
			wire sndRec;

			// Data read from PmodJSTK
			wire [39:0] jstkData;

			// Signal carrying output data that user selected
			wire [9:0] posData;
			
			wire [9:0] joystk_pos_data;
			
			assign joystk_pos_data = posData;
			

	// ===========================================================================
	// 										Implementation
	// ===========================================================================


			//-----------------------------------------------
			//  	  			PmodJSTK Interface
			//-----------------------------------------------
			PmodJSTK PmodJSTK_Int(
					.CLK(CLK),
					.RST(RST),
					.sndRec(sndRec),
					.DIN(sndData),
					.MISO(MISO),
					.SS(SS),
					.SCLK(SCLK),
					.MOSI(MOSI),
					.DOUT(jstkData)
			);
			


			//-----------------------------------------------
			//  		Seven Segment Display Controller
			//-----------------------------------------------
			ssdCtrl DispCtrl(
					.CLK(CLK),
					.RST(RST),
					.DIN(posData),
					.AN(AN),
					.SEG(SEG)
			);
			
			

			//-----------------------------------------------
			//  			 Send Receive Generator
			//-----------------------------------------------
			ClkDiv_5Hz genSndRec(
					.CLK(CLK),
					.RST(RST),
					.CLKOUT(sndRec)
			);
			

			// Use state of switch 0 to select output of X position or Y position data to SSD
			assign posData = (SW[0] == 1'b1) ? {jstkData[9:8], jstkData[23:16]} : {jstkData[25:24], jstkData[39:32]};

			// Data to be sent to PmodJSTK, lower two bits will turn on leds on PmodJSTK
			assign sndData = {8'b100000, {SW[1], SW[2]}};

			// Assign PmodJSTK button status to LED[2:0]
			always @(sndRec or RST or jstkData) begin
					if(RST == 1'b1) begin
							LED <= 3'b000;
					end
					else begin
							LED <= {jstkData[1], {jstkData[2], jstkData[0]}};
					end
			end
			
			
			//**extra code to display speed control assuming only X data**//
			reg  motor_position;
			reg [31:0] speed; // mimic's motor speed control
			reg [31:0] motor_speed;
			reg [9:0] joystk_pos;
			reg [4:0] rLED;
			//assign mLED = rLED;
			
			//make another register as an intermediate
			always@(posedge CLK)
			begin
			     joystk_pos <= joystk_pos_data;
			end
			
			initial
			begin
			     speed <= 0; //0 LED speed
			     motor_speed <= 0; // 0 speed
			     motor_position <= 1; //center of board
			end
			
			wire no_motion = (joystk_pos < 550) && (joystk_pos > 500);
			always @(posedge CLK) 
			begin
			     if(~no_motion)
			     begin
			          if((joystk_pos >= 550 && joystk_pos < 600) || (joystk_pos <= 500 && joystk_pos > 450))
			          begin
			             speed <= 100000000;  //2s count
			             motor_speed <= 50;
			          end
			          
			          else if((joystk_pos >=600 && joystk_pos < 650) || (joystk_pos <= 450 && joystk_pos > 400))
                      begin
                         speed <= 50000000; //1s count 
                         motor_speed <= 75; 
                      end
                      
                      else if((joystk_pos >=650 && joystk_pos < 700) || (joystk_pos <= 400 && joystk_pos > 350))
                      begin
                         speed <= 25000000; //0.5s count 
                         motor_speed <= 100;  
                      end
                      
                      else if((joystk_pos >=700 && joystk_pos < 750) || (joystk_pos <= 350 && joystk_pos > 300))
                      begin
                         speed <= 12500000; //0.25s count
                         motor_speed <= 125;      
                      end
                      
                      else if((joystk_pos >=750 && joystk_pos < 800) || (joystk_pos <= 300 && joystk_pos > 250))
                      begin
                         speed <= 6250000;  //0.125s count
                         motor_speed <= 150;           
                      end
                      
                      else if((joystk_pos >=800 && joystk_pos < 850) || (joystk_pos <= 250 && joystk_pos > 200))
                      begin
                         speed <= 3125000; //0.0625s count  
                         motor_speed <= 175;        
                      end
                      
                      else if(joystk_pos >=850 || joystk_pos <= 200)
                      begin
                         speed <= 1562500; //0.03125s count    
                         motor_speed <= 250;         
                      end 
			     end
			     
			     else
			     begin
			        speed <= 0; // user let's go of joystick we should decelerate
			        motor_speed <= 0;
			     end
			end
			
			reg shift;
			reg [31:0] counter;
			
			initial
			begin
			   counter <= 0;
			   shift <= 0;
			end
			
			always@(posedge CLK) //100MHz microblaze clk
			begin
			     if(counter == speed &&  counter!= 0)
			     begin
			         counter <= 0;
			         shift <= 1'b1;
			     end
			     
			     else if(counter < speed) // we are increasing the speed
			     begin
			         shift <= 1'b0;
			         counter <= counter + 1;
			     end
			     
			     else if(counter > speed) // speed is set lower, reset counter if it was counting higher
			     begin                   
			         counter <= 0;
			         shift <= 1'b0;
			     end
			     
			     else
			     begin
			         counter <= counter;
			         shift <= shift;
			     end
			end
			
			
			
			always@(posedge CLK)
			begin
			     if(~no_motion)
			     begin
			         if(joystk_pos >= 550)
			             motor_position <= 1; //right
			         else
			             motor_position <= 0; //left
			     end
			     
			     else
			         motor_position <= 1; // center
			end
			
			assign MOTOR_SPEED = motor_speed; //ranging between 0 and 255
            assign MOTOR_POSITION = motor_position; // ranging from 0 to 2000
			assign mLED = rLED;
			
			initial
			begin
			     rLED = 5'b00100;
			end
			
			always @(posedge CLK) //LED shift reg
			begin
			    if(joystk_pos <= 500 && shift) // we shift LEDs to the left
			    begin
			         rLED[0] <= rLED[4];
			         rLED[1] <= rLED[0];
			         rLED[2] <= rLED[1];
			         rLED[3] <= rLED[2];
			         rLED[4] <= rLED[3];
			    end
			    
			    
			    else if(joystk_pos >= 550 && shift) // we shift to the right
			    begin
                     rLED[0] <= rLED[1];
                     rLED[1] <= rLED[2];
                     rLED[2] <= rLED[3];
                     rLED[3] <= rLED[4];
                     rLED[4] <= rLED[0];
			    end
			    
			    else 
			    begin
			      rLED <= rLED;
			    end// maintain current position still (motor decelerates to a standstill
			end
					
		
endmodule
