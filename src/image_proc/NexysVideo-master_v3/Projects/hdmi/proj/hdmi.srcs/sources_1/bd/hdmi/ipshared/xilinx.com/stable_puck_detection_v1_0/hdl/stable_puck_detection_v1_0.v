
`timescale 1 ns / 1 ps

	module stable_puck_detection_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


    
            // Parameters of Axi Slave Bus Interface S00_AXIS
            parameter integer FIFO_DEPTH_SLV           = 1280, //CUSTOM
            parameter integer NUMBER_OF_INPUT_WORDS    = 1280, //CUSTOM
            parameter integer C_S00_AXIS_TDATA_WIDTH    = 32,
    
            // Parameters of Axi Slave Bus Interface S00_AXI
            parameter integer C_S00_AXI_DATA_WIDTH    = 32,
            parameter integer C_S00_AXI_ADDR_WIDTH    = 6,
    
            // Parameters of Axi Master Bus Interface M00_AXIS
            parameter integer FIFO_DEPTH_MS            = 1280, //CUSTOM
            parameter integer NUMBER_OF_OUTPUT_WORDS   = 1280, //CUSTOM
            parameter integer C_M00_AXIS_TDATA_WIDTH    = 32,
            parameter integer C_M00_AXIS_START_COUNT    = 32
        )
        (
            // Users to add ports here
    
            // User ports ends
            // Do not modify the ports beyond this line
    
    
            // Ports of Axi Slave Bus Interface S00_AXIS
            input wire  s00_axis_aclk,
            input wire  s00_axis_aresetn,
            output wire  s00_axis_tready,
            input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
            //input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1 : 0] s00_axis_tstrb,
            input wire  s00_axis_tlast,
            input wire  s00_axis_tvalid,
    
            // Ports of Axi Slave Bus Interface S00_AXI
            input wire  s00_axi_aclk,
            input wire  s00_axi_aresetn,
            input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
            input wire [2 : 0] s00_axi_awprot,
            input wire  s00_axi_awvalid,
            output wire  s00_axi_awready,
            input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
            input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
            input wire  s00_axi_wvalid,
            output wire  s00_axi_wready,
            output wire [1 : 0] s00_axi_bresp,
            output wire  s00_axi_bvalid,
            input wire  s00_axi_bready,
            input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
            input wire [2 : 0] s00_axi_arprot,
            input wire  s00_axi_arvalid,
            output wire  s00_axi_arready,
            output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
            output wire [1 : 0] s00_axi_rresp,
            output wire  s00_axi_rvalid,
            input wire  s00_axi_rready,
    
            // Ports of Axi Master Bus Interface M00_AXIS
            input wire  m00_axis_aclk,
            input wire  m00_axis_aresetn,
            output wire  m00_axis_tvalid,
            output wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
            //output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1 : 0] m00_axis_tstrb,
            output wire  m00_axis_tlast,
            input wire  m00_axis_tready,
            output wire m00_axis_tuser,             //CUSTOM
            output wire [2:0] m00_axis_tkeep,       //CUSTOM
            //output wire pause_data_collection_ms, //CUSTOM
            //output wire [6:0] read_pointer_ms,    //CUSTOM
            output wire [31:0] threshold_pos1,
            output wire [31:0] threshold_pos2,
            output wire [31:0] video_lines,
            output wire [31:0] pixel_count_target,
            output wire [31:0] threshold_level,
            output wire [31:0] new_color,
            output wire [31:0] h_start_value,
            output wire [31:0] h_stop_value,
            output wire [31:0] v_start_value,
            output wire [31:0] v_stop_value,
            output wire [31:0] motor_update_rate,
            output wire [31:0] x_pos_per_frame,
            output wire [31:0] y_pos_per_frame,
            output wire valid_data,
            output wire [31:0] motor_offset_x,
            output wire [31:0] motor_offset_y,
            output wire [31:0] use_default,
            output wire [31:0] bottom_y_edge_case,
            output wire [31:0] top_y_edge_case
        );
        
        //internal wires
        wire [10:0] write_pointer;   //transfers the fifo write count from slave to master side
        wire [10:0] read_pointer;              //acts as a pointer to fifo data for output on MS side
        wire m_tvalid_wait; //transfers the pause data collection from master to slave side
        wire [2:0] slv_curr_state;
        wire [23:0] fifo_out_ms;              //transfers data from fifo to  MS side
        wire [23:0] fifo_in_slv;               //transfers data from slv to fifo side
        wire fifo_rden;
        wire fifo_wren;
        wire [2:0] ms_curr_state;
        //wire [31:0] pixel_count;
        //wire [31:0] threshold_level;    
        //wire [31:0] new_color;
        //wire [31:0] start_value;
        
        
        
    // Instantiation of Axi Bus Interface S00_AXIS
        stable_puck_detection_v1_0_S00_AXIS # (
            .FIFO_DEPTH_SLV(FIFO_DEPTH_SLV),
            .NUMBER_OF_INPUT_WORDS(NUMBER_OF_INPUT_WORDS),
            .C_S_AXIS_TDATA_WIDTH(C_S00_AXIS_TDATA_WIDTH)
        ) stable_puck_detection_v1_0_S00_AXIS_inst (
            .WRITE_POINTER_SLV(write_pointer), //output
            .M_TVALID_WAIT(m_tvalid_wait), //input
            .MS_CURR_STATE(ms_curr_state),
            .FIFO_IN(fifo_in_slv),  //output 
            .SLV_CURR_STATE(slv_curr_state),
            .S_AXIS_ACLK(s00_axis_aclk),
            .S_AXIS_ARESETN(s00_axis_aresetn),
            .S_AXIS_TREADY(s00_axis_tready),
            .S_AXIS_TDATA(s00_axis_tdata),
            //.S_AXIS_TSTRB(s00_axis_tstrb),
            .S_AXIS_TLAST(s00_axis_tlast),
            .S_AXIS_TVALID(s00_axis_tvalid),
            .FIFO_WREN(fifo_wren),
            .THRESHOLD_POS1(threshold_pos1),
            .THRESHOLD_POS2(threshold_pos2),
            .VIDEO_LINES(video_lines),
            .VALID_DATA(valid_data),
            .THRESHOLD_LEVEL(threshold_level),
            .PIXEL_COUNT_TARGET(pixel_count_target),
            .H_START_VALUE(h_start_value),
            .H_STOP_VALUE(h_stop_value),
            .V_START_VALUE(v_start_value),
            .V_STOP_VALUE(v_stop_value),
            .X_POS_PER_FRAME(x_pos_per_frame),
            .Y_POS_PER_FRAME(y_pos_per_frame),
            .MOTOR_OFFSET_X(motor_offset_x),
            .MOTOR_OFFSET_Y(motor_offset_y),
            .USE_DEFAULT(use_default),
            .BOTTOM_Y_EDGE_CASE(bottom_y_edge_case),
            .TOP_Y_EDGE_CASE(top_y_edge_case)
        );
    
    // Instantiation of Axi Bus Interface S00_AXI
    stable_puck_detection_v1_0_S00_AXI # ( 
        .C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
    ) stable_puck_detection_v1_0_S00_AXI_inst (
        .S_AXI_ACLK(s00_axi_aclk),
        .S_AXI_ARESETN(s00_axi_aresetn),
        .S_AXI_AWADDR(s00_axi_awaddr),
        .S_AXI_AWPROT(s00_axi_awprot),
        .S_AXI_AWVALID(s00_axi_awvalid),
        .S_AXI_AWREADY(s00_axi_awready),
        .S_AXI_WDATA(s00_axi_wdata),
        .S_AXI_WSTRB(s00_axi_wstrb),
        .S_AXI_WVALID(s00_axi_wvalid),
        .S_AXI_WREADY(s00_axi_wready),
        .S_AXI_BRESP(s00_axi_bresp),
        .S_AXI_BVALID(s00_axi_bvalid),
        .S_AXI_BREADY(s00_axi_bready),
        .S_AXI_ARADDR(s00_axi_araddr),
        .S_AXI_ARPROT(s00_axi_arprot),
        .S_AXI_ARVALID(s00_axi_arvalid),
        .S_AXI_ARREADY(s00_axi_arready),
        .S_AXI_RDATA(s00_axi_rdata),
        .S_AXI_RRESP(s00_axi_rresp),
        .S_AXI_RVALID(s00_axi_rvalid),
        .S_AXI_RREADY(s00_axi_rready),
        .THRESHOLD_LEVEL(threshold_level),
        .PIXEL_COUNT_TARGET(pixel_count_target),
        .NEW_COLOR(new_color),
        .H_START_VALUE(h_start_value),
        .H_STOP_VALUE(h_stop_value),
        .V_START_VALUE(v_start_value),
        .V_STOP_VALUE(v_stop_value),
        .MOTOR_UPDATE_RATE(motor_update_rate),
        .X_POS_PER_FRAME(x_pos_per_frame),
        .Y_POS_PER_FRAME(y_pos_per_frame),
        .MOTOR_OFFSET_Y(motor_offset_y),
        .MOTOR_OFFSET_X(motor_offset_x),
        .USE_DEFAULT(use_default),
        .BOTTOM_Y_EDGE_CASE(bottom_y_edge_case),
        .TOP_Y_EDGE_CASE(top_y_edge_case)
        
    );
    
    // Instantiation of Axi Bus Interface M00_AXIS
    stable_puck_detection_v1_0_M00_AXIS # ( 
        .FIFO_DEPTH_MS(FIFO_DEPTH_MS),
        .NUMBER_OF_OUTPUT_WORDS(NUMBER_OF_OUTPUT_WORDS),
        .C_M_AXIS_TDATA_WIDTH(C_M00_AXIS_TDATA_WIDTH),
        .C_M_START_COUNT(C_M00_AXIS_START_COUNT)
    ) stable_puck_detection_v1_0_M00_AXIS_inst (
        .FIFO_OUT(RGB_data_fifo[read_pointer]),
        .M_AXIS_TUSER(m00_axis_tuser),
        .M_AXIS_TKEEP(m00_axis_tkeep),
        .MS_CURR_STATE(ms_curr_state),
        .SLV_CURR_STATE(slv_curr_state),
        .M_TVALID_WAIT(m_tvalid_wait),
        .READ_POINTER_MS(read_pointer),
        .M_AXIS_ACLK(m00_axis_aclk),
        .M_AXIS_ARESETN(m00_axis_aresetn),
        .M_AXIS_TVALID(m00_axis_tvalid),
        .M_AXIS_TDATA(m00_axis_tdata),
        //.M_AXIS_TSTRB(m00_axis_tstrb),
        .M_AXIS_TLAST(m00_axis_tlast),
        .M_AXIS_TREADY(m00_axis_tready),
        .VIDEO_LINES(video_lines),
        .FIFO_RDEN(fifo_rden)
    );
    
        // Add user logic here
        
        //FIFO Implementation occruing outside SLAVE_STREAM & MASTER_STREAM to allow both to access the data fifo
        
        //FIFO DECLARATION
        reg [23:0] RGB_data_fifo [0:FIFO_DEPTH_SLV-1];
        
        //****************************SLAVE_STREAM WRITING TO FIFO***************************//
        //******************SLAVE gets S_AXIS_TDATA and outputs FIFO_IN*********************//
        
        reg [23:0] c;
        
        initial
        begin
            c <= 0;
        end
        
        always@(posedge s00_axis_aclk)
        begin
            if(s00_axis_tready)
            begin
                if(c[7:0] < 150)
                    c[7:0] <= c[7:0] + 1;
                else
                    c[7:0] <= 0;
                    
                if(c[15:8] <150)
                    c[15:8] <= c[15:8] + 1;
                else
                    c[15:8] <= 0;
                    
                if(c[23:16] < 150)
                    c[23:16] <= c[23:16] + 1;
                else
                    c[23:16] <= 0;
             end
                
            else
                c <= c;
        end
        
        always@(posedge s00_axis_aclk)
        begin
           if(fifo_wren)
           begin 
              
               if(write_pointer  < h_start_value || write_pointer > h_stop_value || video_lines < v_start_value || video_lines > v_stop_value)
                   RGB_data_fifo[write_pointer] <= /*fifo_in_slv[23:0]*/ 24'hffffff;
                
             
               else if((fifo_in_slv[7:0] < threshold_level && fifo_in_slv[15:8] < threshold_level && fifo_in_slv[23:16] < threshold_level) && write_pointer > h_start_value && write_pointer < h_stop_value && video_lines > v_start_value && video_lines < v_stop_value) //checks for low threshold and writes a RED pixel in place of  it
               begin   
                   if((threshold_pos2 - threshold_pos1) < pixel_count_target)
                        RGB_data_fifo[write_pointer] <= 0;
                   else
                        RGB_data_fifo[write_pointer] <= new_color[23:0];
               end   
               
               else
               begin
                  RGB_data_fifo[write_pointer] <= /*fifo_in_slv[23:0]*/ 24'hffffff;
               end 
           end
           
           else
               RGB_data_fifo[write_pointer] <=  RGB_data_fifo[write_pointer];
        end
        
        
        reg [23:0] fifo_out_ms_r;
        assign fifo_out_ms = fifo_out_ms_r;
        always@(posedge m00_axis_aclk)
        begin
            if(1||fifo_rden)
                fifo_out_ms_r[23:0] <= RGB_data_fifo[read_pointer];
            else
                fifo_out_ms_r[23:0] <= fifo_out_ms_r[23:0];
        end
        
        //**************************MASTER STREAM READING FROM FIFO*************************//
        
        // User logic ends
        
     endmodule 
