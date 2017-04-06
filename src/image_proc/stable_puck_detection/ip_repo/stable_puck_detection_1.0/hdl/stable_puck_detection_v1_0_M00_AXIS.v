
`timescale 1 ns / 1 ps

	module stable_puck_detection_v1_0_M00_AXIS #
	(
		// Users to add parameters here
		 //parameter integer horizontal_pixels = 1280, // based on 1280x720 resolution
         //parameter integer vertical_pixels = 720, //based on 1280x720 resolution
         parameter integer FIFO_DEPTH_MS = 1280, //matches horizontal line length
		 parameter integer NUMBER_OF_OUTPUT_WORDS = 1280,
		

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		// Start count is the numeber of clock cycles the master will wait before initiating/issuing any transaction.
		parameter integer C_M_START_COUNT	= 32
	)
	(
		// Users to add ports here
		
		
		//tells us the slave image processing core's writing status
		//FIFO values to be outputted 
		input wire [23:0] FIFO_OUT,
		//indicates current state of the slave
		input wire [2:0] SLV_CURR_STATE,
		//indicates the start of a new frame (single bit indicator should remain high for 10 cycles)
		output wire M_AXIS_TUSER,
		//acts as a bit qualifier for each RGB packet as valid (set all to 1)
		output wire [2:0] M_AXIS_TKEEP, 
		//signal used to tell the slave to stop accepting new data
		output wire M_TVALID_WAIT,
		//controls the fifo read state from the top level module of the project
		output wire [10:0]  READ_POINTER_MS,
		
		output wire [2:0] MS_CURR_STATE,
		
		output wire FIFO_RDEN,
		
		input wire [31:0] VIDEO_LINES,

		// User ports ends
		// Do not modify the ports beyond this line

		// Global ports
		input wire  M_AXIS_ACLK,
		// 
		input wire  M_AXIS_ARESETN,
		// Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
		output wire  M_AXIS_TVALID,
		// TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
		output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] M_AXIS_TDATA,
		// TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
		//output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] M_AXIS_TSTRB,
		// TLAST indicates the boundary of a packet.
		output wire  M_AXIS_TLAST,
		// TREADY indicates that the slave can accept a transfer in the current cycle.
		input wire  M_AXIS_TREADY // this is going to be the input from the SLAVE TPG/AXI4-STREAM to VIDEO OUT/ or VDMA 
	);
	                              
	parameter [2:0] IDLE = 3'b000,        // This is the initial/idle state               
	                                                                                     
	                WRITE_FIFO  = 3'b001, // This state initializes the counter, ones   
	                                    
	                READ_FIFO   = 3'b010; // In this state the                          
	                                     // stream data is output through M_AXIS_TDATA             
	                
	//internal wires and registers                                                                     
	reg [2:0] mst_exec_state; //indicates which state the FSM is in                                                                                                       
    wire fifo_rden; //enables FIFO read_pointer to increment
	reg [10:0] read_pointer; //indicates the position to read from the FIFO
	reg reads_done; //indicates that the read transaction is complete
	
    //**********************************MASTER STREAM CONTROL FSM*******************************************//
	always @(posedge M_AXIS_ACLK)                                             
	begin                                                                     
	  if (!M_AXIS_ARESETN)                                                    
	  // Synchronous reset (active low)                                       
	    begin                                                                 
	      mst_exec_state <= IDLE;                                                                                                  
	    end                                                                   
	  else
        begin	  
			case (mst_exec_state)                                                 
			  IDLE:
					if(SLV_CURR_STATE == WRITE_FIFO) //this indicates the write state for the slave side
						mst_exec_state  <= READ_FIFO;
					else
						mst_exec_state <= IDLE;
			  
			  READ_FIFO:
				 if(reads_done && SLV_CURR_STATE == IDLE) //the receiving slave has de-asserted the ready signal
					mst_exec_state <= IDLE; //we need to tell the slave image processing core to halt data collection
				 else
					mst_exec_state <= READ_FIFO;                                                                                    
			endcase
        end			
	end        
	//**********************************MASTER STREAM CONTROL FSM*******************************************//
	
	//*********CODE FOR COUNTING NUMBER OF VERTICAL LINES and asserting TLAST*******************************//
        
    reg [4:0] tlast_count;
    
    initial
    begin
       tlast_count <= 0;
    end
    
    always@(posedge M_AXIS_ACLK)
    begin
       if(!M_AXIS_ARESETN)
           tlast_count <= 0;
       else if(read_pointer == NUMBER_OF_OUTPUT_WORDS-1) // this occurs every 128 stream transactions
           tlast_count <= tlast_count + 1;
	   else if(tlast_count > 0 && tlast_count < 4)
			tlast_count <= tlast_count + 1;
       else if(tlast_count >= 4)
           tlast_count <= 0;
       else
           tlast_count <= tlast_count;
    end
        
    //*********CODE FOR COUNTING NUMBER OF VERTICAL LINES and asserting TLAST*******************************//
        
    //*****************************CODE FOR INITIATING TUSER UPON NEW FRAME********************************//
        
        reg tuser;
        initial
        begin
           tuser <= 0;
        end
        
        assign M_AXIS_TUSER = tuser;
        
        always@(posedge M_AXIS_ACLK)
        begin
            if(!M_AXIS_ARESETN)                                                                         
                tuser = 0;
            else if(mst_exec_state == IDLE && VIDEO_LINES == 0) //we are on the first line of a new frame 
                tuser <= 1;
            else
                tuser <= 0; //de-asserted at all times except when in the new frame state
        end
   
   //**********************************************ASSIGNMENT STATEMENTS******************************************************************//      
    assign M_AXIS_TVALID = tvalid_reg /*tvalid_reg/*(SLV_CURR_STATE == WRITE_FIFO)*/;                      
    assign M_AXIS_TLAST =  (read_pointer == NUMBER_OF_OUTPUT_WORDS -1) || ((tlast_count > 0)  && (tlast_count < 4)); //held high for 4 clock cycles
    assign M_AXIS_TUSER = tuser;
    assign M_AXIS_TKEEP = 3'b111;
	assign fifo_rden = (mst_exec_state == READ_FIFO) && M_AXIS_TREADY && ~reads_done;
    assign FIFO_RDEN = fifo_rden;
    assign READ_POINTER_MS = read_pointer;
    assign M_TVALID_WAIT = ~M_AXIS_TREADY && (mst_exec_state == READ_FIFO);
    assign M_AXIS_TDATA  = FIFO_OUT; 
   //**********************************************ASSIGNMENT STATEMENTS******************************************************************// 
   
   //**********delay valid signal by 1 clock cycle to line up with data****************//
   wire tvalid;
   assign tvalid = (SLV_CURR_STATE == WRITE_FIFO || M_TVALID_WAIT) && (~M_AXIS_TLAST || M_TVALID_WAIT);
   reg tvalid_reg;
   always@(posedge M_AXIS_ACLK)
   begin
        tvalid_reg <= tvalid;
   end
   //**********delay valid signal by 1 clock cycle to line up with data****************//
   
   
   //******************************logic to control the read pointer of the FIFO**********************************************************//
   
   always@(posedge M_AXIS_ACLK)
   begin
       if(!M_AXIS_ARESETN)                                                                                                                                
          read_pointer <= 0; 
           
       else if(read_pointer <= (NUMBER_OF_OUTPUT_WORDS-1))
       begin
       		  
		   if( fifo_rden && (read_pointer < (NUMBER_OF_OUTPUT_WORDS -1) ))
		   begin
			  read_pointer <= read_pointer + 1;
			  reads_done <= 1'b0;
		   end
		   
		   else if((read_pointer == (NUMBER_OF_OUTPUT_WORDS -1)) &&  ~M_TVALID_WAIT && reads_done == 1'b0)
           begin
              /*
               if(reads_done == 1'b0 && tvalid && M_AXIS_TLAST)
                    reads_done = 1'b1;
               else
                    reads_done <= 1'b0;
                    
               if(M_AXIS_TLAST || ~tvalid)
                    read_pointer <= read_pointer;
               else
                    read_pointer <= 0; 
              */
              reads_done <= 1'b1;
              read_pointer <= 0;
              
                  
           end
		   
		   else
		   begin
			  read_pointer <= read_pointer; 
			  reads_done <= 1'b0;
		   end
		   
       end
       
	   else
	   begin
	       read_pointer <= 0;
           reads_done  <= 1'b0;
	   end
   end
   
   //******************************logic to control the read pointer of the FIFO**********************************************************//                                                                                                                            
                              
endmodule

