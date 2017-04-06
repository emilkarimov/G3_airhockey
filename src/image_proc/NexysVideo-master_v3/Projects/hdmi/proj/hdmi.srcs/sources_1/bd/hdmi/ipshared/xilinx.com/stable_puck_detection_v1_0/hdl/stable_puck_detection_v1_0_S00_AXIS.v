
`timescale 1 ns / 1 ps

	module stable_puck_detection_v1_0_S00_AXIS #
	(
		// Users to add parameters here
                //parameter integer horizontal_pixels = 1280, // based on 1280x720 resolution
                //parameter integer vertical_pixels = 720, //based on 1280x720 resolution
                parameter integer FIFO_DEPTH_SLV = 1280, //matches horizontal line length
                parameter integer NUMBER_OF_INPUT_WORDS = 1280, //maches the amount of line data (1280 pixels per line)
                // User parameters ends
                // Do not modify the parameters beyond this line
        
                // AXI4Stream sink: Data Width
                parameter integer C_S_AXIS_TDATA_WIDTH    = 32
         )
         
         (
            // Users to add ports here
            
            //outputs the status of the write_pointer (in writing the fifo)
            output wire [10:0] WRITE_POINTER_SLV,
            //incoming signal from the master to slave to pause data collection
            input wire M_TVALID_WAIT,
            //sends incoming packets to the FIFO
            input wire [2:0] MS_CURR_STATE,
            
            output wire [23:0] FIFO_IN,
            
            output wire [2:0] SLV_CURR_STATE,
            
            output wire FIFO_WREN,
            
            output wire [31:0] THRESHOLD_POS1,
            
            output wire [31:0] THRESHOLD_POS2,
            
            output wire [31:0] VIDEO_LINES,
            
            output wire VALID_DATA,
            
            input wire [31:0] THRESHOLD_LEVEL,
            
            input wire [31:0] PIXEL_COUNT_TARGET,
            
            input wire [31:0] H_START_VALUE,
            
            input wire [31:0] H_STOP_VALUE,
            
            input wire [31:0] V_START_VALUE,
            
            input wire [31:0] V_STOP_VALUE,
            
            output wire [31:0] X_POS_PER_FRAME,
            
            output wire [31:0] Y_POS_PER_FRAME,
            
            input  wire [31:0] MOTOR_OFFSET_X,
            
            input wire [31:0] MOTOR_OFFSET_Y,
            
            input wire [31:0] USE_DEFAULT,
            
            input wire [31:0] BOTTOM_Y_EDGE_CASE,
            
            input wire [31:0] TOP_Y_EDGE_CASE,
            
            // User ports ends
            // Do not modify the ports beyond this line
           
            // AXI4Stream sink: Clock
            input wire  S_AXIS_ACLK,
            // AXI4Stream sink: Reset
            input wire  S_AXIS_ARESETN,
            // Ready to accept data in
            output wire  S_AXIS_TREADY,
            // Data in
            input wire [C_S_AXIS_TDATA_WIDTH-1 : 0] S_AXIS_TDATA,
            // Byte qualifier
            //input wire [(C_S_AXIS_TDATA_WIDTH/8)-1 : 0] S_AXIS_TSTRB,
            // Indicates boundary of last packet
            input wire  S_AXIS_TLAST,
            // Data is in valid
            input wire  S_AXIS_TVALID
        );
       
        parameter [2:0] IDLE = 3'b000,        // This is the initial/idle state 
    
                        WRITE_FIFO  = 3'b001; // In this state FIFO is written with the
                           
        
        //internal wires and registers     
        reg [2:0] mst_exec_state;  //indicates which state the FSM is in
        wire fifo_wren; //enables FIFO write_pointer to increment 
        reg [10:0] write_pointer; //indicates the position to write into the FIFO
        reg writes_done; //indicates that the write transaction is complete 
        
    
        //***********************************Control state machine implementation******************************//
        always @(posedge S_AXIS_ACLK) 
        begin  
          if (!S_AXIS_ARESETN) 
          // Synchronous reset (active low)
            begin
              mst_exec_state <= IDLE;
            end  
          else
            case (mst_exec_state)
              IDLE:
                  if (S_AXIS_TVALID && ~M_TVALID_WAIT) //if we see a TVALID signal, we move to the write FIFO state 
                    begin
                      mst_exec_state <= WRITE_FIFO;
                    end
                  else
                    begin
                      mst_exec_state <= IDLE;
                    end
              WRITE_FIFO: 
                if (writes_done) //when writes are complete we go back to the IDLE state (writes done occurs when slave side master is done issuing packets
                  begin
                    mst_exec_state <= IDLE;
                  end
                else
                  begin
                    mst_exec_state <= WRITE_FIFO;
                  end
            endcase
        end
        
        //***********************************Control state machine implementation******************************//
    
        //******************************************WRITE POINTER LOGIC******************************************************//
        
        always@(posedge S_AXIS_ACLK)
        begin
            if(!S_AXIS_ARESETN)
            begin
                write_pointer <= 0;
                writes_done <= 1'b0;
            end 
            
            else if ( (write_pointer <= (NUMBER_OF_INPUT_WORDS-1) ))
            begin
                if (fifo_wren && write_pointer < (NUMBER_OF_INPUT_WORDS -1))
                begin
                 write_pointer <= write_pointer + 1;
                 writes_done <= 1'b0;
                end
                
                else if (((write_pointer == NUMBER_OF_INPUT_WORDS-1) && S_AXIS_TLAST) && writes_done == 1'b0 && ~M_TVALID_WAIT)
                begin
                  writes_done <= 1'b1;
                  write_pointer <= 0;
                end
                
                else
                begin
                  writes_done <= 1'b0;
                  write_pointer <= write_pointer;
                end
            end
            
            else
            begin
               write_pointer <= 0;
               writes_done  <= 1'b0; 
            end 
        end
        //******************************************WRITE POINTER LOGIC******************************************************//
        
        
        /**************************************************ASSIGNMENT STATEMENTS**********************************************/
        assign S_AXIS_TREADY = (mst_exec_state == WRITE_FIFO) && ~M_TVALID_WAIT; //INTERNAL
        assign fifo_wren     = S_AXIS_TREADY && S_AXIS_TVALID && ~writes_done; //INTERNAL
        assign FIFO_WREN = fifo_wren;
        assign WRITE_POINTER_SLV = write_pointer; //OUTPUT
        assign FIFO_IN = S_AXIS_TDATA[23:0];  //OUTPUT
        assign SLV_CURR_STATE = mst_exec_state; //OUTPUT
        assign THRESHOLD_POS1 = threshold_pos1;
        assign THRESHOLD_POS2 = threshold_pos2;
        assign X_POS_PER_FRAME = x_pos;
        assign Y_POS_PER_FRAME = y_pos;
        assign VIDEO_LINES = video_lines;
        assign VALID_DATA = valid_data;
        /**************************************************ASSIGNMENT STATEMENTS***********************************************/
       
        
        // Add user logic here
        reg [31:0] video_lines;
        
        initial
        begin
           video_lines <= 0;
        end
        
        always@(posedge S_AXIS_TLAST)
        begin
           if(!S_AXIS_ARESETN)
               video_lines <= 0;
           else if(video_lines < 719)
               video_lines <= video_lines + 1;
           else
               video_lines <= 0;
        end
        
        //this counter will be used to count the # of pixels per line
        reg [31:0] pixel_count;
        initial
        begin
           pixel_count <= 0;
        end
        always@(posedge S_AXIS_ACLK)
        begin
            if(S_AXIS_TVALID && S_AXIS_TREADY && fifo_wren)
                pixel_count <= pixel_count + 1;
            
            else if(pixel_count > 1278 || S_AXIS_TLAST == 1'b1)
                pixel_count <= 0;
            
            else
                pixel_count <= pixel_count;
        end
        
        //this counter will be used to count # of pixels below certain threshold (black) and 
        //this counter will be used to count # of pixels below certain threshold (black) and 
        reg [31:0] threshold_counter;
        reg [31:0] threshold_pos1; // will indicate if pixel in position 1 was black
        reg [31:0] threshold_pos2; // will indicate if pixel in position 2 was black
        reg [31:0] puck_line_depth_found;
        reg [31:0] x_pos_per_frame_reg1;
        reg [31:0] y_pos_per_frame_reg1;
        reg [31:0] x_pos_per_frame_reg2;
        reg [31:0] y_pos_per_frame_reg2;
        reg [31:0] x_pos;
        reg [31:0] y_pos;
        
        
        initial
        begin
            threshold_pos1 <= 0;
            threshold_pos2 <= 0;
            puck_line_depth_found <= 0;
            threshold_counter <= 0;
            x_pos_per_frame_reg1 <= 0;
            y_pos_per_frame_reg1 <= 0;
            x_pos_per_frame_reg2 <= 0;
            y_pos_per_frame_reg2 <= 0;
            x_pos <= 0;
            y_pos <= 0;
        end
        
        always@(posedge S_AXIS_ACLK)
        begin
            if(VALID_DATA)
            begin
                if( (x_pos_per_frame_reg1 == 0 && y_pos_per_frame_reg1 == 0) || (x_pos_per_frame_reg1 == MOTOR_OFFSET_X && y_pos_per_frame_reg1 == MOTOR_OFFSET_Y) ) //on the first valid data, we store in both registers
                begin
                     x_pos_per_frame_reg1 <= threshold_pos1; 
                     y_pos_per_frame_reg1 <= 3*video_lines;
                     x_pos_per_frame_reg2 <= threshold_pos1;
                     y_pos_per_frame_reg2 <= 3*video_lines;
                end
                
                else //otherwise we only update the second set of registers
                begin
                    x_pos_per_frame_reg1 <= x_pos_per_frame_reg1;
                    y_pos_per_frame_reg1 <= y_pos_per_frame_reg1;
                    x_pos_per_frame_reg2 <= threshold_pos1;
                    y_pos_per_frame_reg2 <= 3*video_lines; 
                end
            end
            
            else
            begin
                if(video_lines == 719)
                begin
                    x_pos_per_frame_reg1 <= MOTOR_OFFSET_X;
                    y_pos_per_frame_reg1 <= MOTOR_OFFSET_Y;
                    x_pos_per_frame_reg2 <= MOTOR_OFFSET_X;
                    y_pos_per_frame_reg2 <= MOTOR_OFFSET_Y;
                end
                
                else
                begin
                    x_pos_per_frame_reg1 <= x_pos_per_frame_reg1;
                    y_pos_per_frame_reg1 <= y_pos_per_frame_reg1;
                    x_pos_per_frame_reg2 <= x_pos_per_frame_reg2;
                    y_pos_per_frame_reg2 <= y_pos_per_frame_reg2;
                end
            end
        end
        
        always@(posedge S_AXIS_ACLK)
        begin
            if(video_lines > 716 && video_lines < 719)
            begin
                if(USE_DEFAULT == 0)
                begin
                    x_pos <= (x_pos_per_frame_reg1 + x_pos_per_frame_reg2)/2;
                    y_pos <= (y_pos_per_frame_reg1 + y_pos_per_frame_reg2)/2;
                end
                
                else
                begin
                    if(((y_pos_per_frame_reg1 + y_pos_per_frame_reg2)/2) > BOTTOM_Y_EDGE_CASE)
                    begin
                        x_pos <= (x_pos_per_frame_reg1 + x_pos_per_frame_reg2)/2;
                        y_pos <= 2100;
                    end
                        
                    else if(((y_pos_per_frame_reg1 + y_pos_per_frame_reg2)/2) < TOP_Y_EDGE_CASE)
                    begin
                        x_pos <= (x_pos_per_frame_reg1 + x_pos_per_frame_reg2)/2;
                        y_pos <= 50;
                    end
                    
                    else
                    begin
                        x_pos <= (x_pos_per_frame_reg1 + x_pos_per_frame_reg2)/2;
                        y_pos <= (y_pos_per_frame_reg1 + y_pos_per_frame_reg2)/2;
                    end   
                end   
            end
            
            else
            begin
                x_pos <= x_pos;
                y_pos <= y_pos;
            end
        end
        
        always@(posedge S_AXIS_ACLK)
        begin
            //first conditional
            if(S_AXIS_TVALID && S_AXIS_TREADY && fifo_wren)
            begin
                //second conditional
                if(S_AXIS_TDATA[7:0] < THRESHOLD_LEVEL && S_AXIS_TDATA[15:8] < THRESHOLD_LEVEL && S_AXIS_TDATA[23:16] < THRESHOLD_LEVEL && write_pointer > H_START_VALUE && write_pointer < H_STOP_VALUE && video_lines > V_START_VALUE && video_lines < V_STOP_VALUE) //we encounter a black pixel
                begin
                    if(threshold_pos1 == 0) // initial setting we encountered our first pixel
                    begin
                        threshold_pos1 <= pixel_count;
                        threshold_pos2 <= pixel_count;
                        threshold_counter <= threshold_counter + 1;
                    end
                    
                    else
                    begin
                        threshold_pos2 <=pixel_count;
                        threshold_pos1 <= threshold_pos1;
                        threshold_counter <= threshold_counter + 1;
                        puck_line_depth_found <= (threshold_pos2 - threshold_pos1);
                    end
                end
                
                else
                begin
                    if( (threshold_pos2 - threshold_pos1) < PIXEL_COUNT_TARGET ) //assuming 100 pixels is the ideal puck width
                    begin
                        threshold_pos1 <= 0;
                        threshold_pos2 <= 0;
                        puck_line_depth_found <= 0;
                        threshold_counter <= threshold_counter;
                    end
                    
                    else
                    begin
                        puck_line_depth_found <= puck_line_depth_found;
                        threshold_counter <= threshold_counter;
                        threshold_pos1 <= threshold_pos1; //retain positions
                        threshold_pos2 <= threshold_pos2; //retain positions
                    end 
                end //end of else statement
             end // end of TVALID & TREADY logic
             
             else if(S_AXIS_TLAST == 1'b1) //we start a new line of the frame reset all values
             begin
                threshold_counter <= 0;
                threshold_pos1 <= 0;
                threshold_pos2 <= 0;
                puck_line_depth_found <= 0;
             end
             
             else
             begin
                 threshold_counter <= threshold_counter;
                 threshold_pos1 <= threshold_pos1;
                 threshold_pos2 <= threshold_pos2;
                 puck_line_depth_found <= puck_line_depth_found;
             end
         end //end of always block
         
         reg valid_data;
         reg [5:0] valid_count;
         
         initial
         begin
            valid_data <= 0;
            valid_count <= 0;
         end
         
         always@(posedge S_AXIS_ACLK)
         begin
            if((threshold_pos2 - threshold_pos1) > PIXEL_COUNT_TARGET && valid_count < 5)
                valid_data <= 1'b1;
            else
                valid_data <= 1'b0;
         end
         
         always@(posedge S_AXIS_ACLK)
         begin
            if(valid_data == 1'b1 && valid_count < 5)
                valid_count <= valid_count + 1;
            else if(valid_count == 5 && SLV_CURR_STATE == IDLE)
                valid_count <= 0;
            else
                valid_count <= valid_count;
         end
    
    endmodule
        // User logic ends
