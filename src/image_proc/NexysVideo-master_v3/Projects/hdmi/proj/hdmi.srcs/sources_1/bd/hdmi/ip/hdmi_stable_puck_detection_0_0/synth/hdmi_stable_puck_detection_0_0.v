// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:user:stable_puck_detection:1.0
// IP Revision: 5

(* X_CORE_INFO = "stable_puck_detection_v1_0,Vivado 2016.2" *)
(* CHECK_LICENSE_TYPE = "hdmi_stable_puck_detection_0_0,stable_puck_detection_v1_0,{}" *)
(* CORE_GENERATION_INFO = "hdmi_stable_puck_detection_0_0,stable_puck_detection_v1_0,{x_ipProduct=Vivado 2016.2,x_ipVendor=xilinx.com,x_ipLibrary=user,x_ipName=stable_puck_detection,x_ipVersion=1.0,x_ipCoreRevision=5,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,C_S00_AXI_DATA_WIDTH=32,C_S00_AXI_ADDR_WIDTH=6,C_M00_AXIS_TDATA_WIDTH=32,C_M00_AXIS_START_COUNT=32,C_S00_AXIS_TDATA_WIDTH=32,FIFO_DEPTH_SLV=1280,NUMBER_OF_INPUT_WORDS=1280,FIFO_DEPTH_MS=1280,NUMBER_OF_OUTPUT_WORDS=1280}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module hdmi_stable_puck_detection_0_0 (
  s00_axi_awaddr,
  s00_axi_awprot,
  s00_axi_awvalid,
  s00_axi_awready,
  s00_axi_wdata,
  s00_axi_wstrb,
  s00_axi_wvalid,
  s00_axi_wready,
  s00_axi_bresp,
  s00_axi_bvalid,
  s00_axi_bready,
  s00_axi_araddr,
  s00_axi_arprot,
  s00_axi_arvalid,
  s00_axi_arready,
  s00_axi_rdata,
  s00_axi_rresp,
  s00_axi_rvalid,
  s00_axi_rready,
  s00_axi_aclk,
  s00_axi_aresetn,
  m00_axis_tdata,
  m00_axis_tlast,
  m00_axis_tvalid,
  m00_axis_tready,
  m00_axis_tuser,
  m00_axis_tkeep,
  threshold_pos1,
  threshold_pos2,
  video_lines,
  pixel_count_target,
  threshold_level,
  new_color,
  h_start_value,
  h_stop_value,
  v_start_value,
  v_stop_value,
  motor_update_rate,
  x_pos_per_frame,
  y_pos_per_frame,
  valid_data,
  motor_offset_x,
  motor_offset_y,
  use_default,
  bottom_y_edge_case,
  top_y_edge_case,
  m00_axis_aclk,
  m00_axis_aresetn,
  s00_axis_tdata,
  s00_axis_tlast,
  s00_axis_tvalid,
  s00_axis_tready,
  s00_axis_aclk,
  s00_axis_aresetn
);

(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR" *)
input wire [5 : 0] s00_axi_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWPROT" *)
input wire [2 : 0] s00_axi_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWVALID" *)
input wire s00_axi_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWREADY" *)
output wire s00_axi_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WDATA" *)
input wire [31 : 0] s00_axi_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WSTRB" *)
input wire [3 : 0] s00_axi_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WVALID" *)
input wire s00_axi_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WREADY" *)
output wire s00_axi_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BRESP" *)
output wire [1 : 0] s00_axi_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BVALID" *)
output wire s00_axi_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BREADY" *)
input wire s00_axi_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR" *)
input wire [5 : 0] s00_axi_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT" *)
input wire [2 : 0] s00_axi_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID" *)
input wire s00_axi_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY" *)
output wire s00_axi_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RDATA" *)
output wire [31 : 0] s00_axi_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RRESP" *)
output wire [1 : 0] s00_axi_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RVALID" *)
output wire s00_axi_rvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RREADY" *)
input wire s00_axi_rready;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S00_AXI_CLK CLK, xilinx.com:signal:clock:1.0 s00_axi_aclk CLK" *)
input wire s00_axi_aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S00_AXI_RST RST, xilinx.com:signal:reset:1.0 s00_axi_aresetn RST" *)
input wire s00_axi_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TDATA" *)
output wire [31 : 0] m00_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TLAST" *)
output wire m00_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TVALID" *)
output wire m00_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TREADY" *)
input wire m00_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TUSER" *)
output wire m00_axis_tuser;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TKEEP" *)
output wire [2 : 0] m00_axis_tkeep;
output wire [31 : 0] threshold_pos1;
output wire [31 : 0] threshold_pos2;
output wire [31 : 0] video_lines;
output wire [31 : 0] pixel_count_target;
output wire [31 : 0] threshold_level;
output wire [31 : 0] new_color;
output wire [31 : 0] h_start_value;
output wire [31 : 0] h_stop_value;
output wire [31 : 0] v_start_value;
output wire [31 : 0] v_stop_value;
output wire [31 : 0] motor_update_rate;
output wire [31 : 0] x_pos_per_frame;
output wire [31 : 0] y_pos_per_frame;
output wire valid_data;
output wire [31 : 0] motor_offset_x;
output wire [31 : 0] motor_offset_y;
output wire [31 : 0] use_default;
output wire [31 : 0] bottom_y_edge_case;
output wire [31 : 0] top_y_edge_case;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 M00_AXIS_CLK CLK, xilinx.com:signal:clock:1.0 m00_axis_aclk CLK" *)
input wire m00_axis_aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 M00_AXIS_RST RST, xilinx.com:signal:reset:1.0 m00_axis_aresetn RST" *)
input wire m00_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TDATA" *)
input wire [31 : 0] s00_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TLAST" *)
input wire s00_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TVALID" *)
input wire s00_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TREADY" *)
output wire s00_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S00_AXIS_CLK CLK, xilinx.com:signal:clock:1.0 s00_axis_aclk CLK" *)
input wire s00_axis_aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S00_AXIS_RST RST, xilinx.com:signal:reset:1.0 s00_axis_aresetn RST" *)
input wire s00_axis_aresetn;

  stable_puck_detection_v1_0 #(
    .C_S00_AXI_DATA_WIDTH(32),  // Width of S_AXI data bus
    .C_S00_AXI_ADDR_WIDTH(6),  // Width of S_AXI address bus
    .C_M00_AXIS_TDATA_WIDTH(32),  // Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
    .C_M00_AXIS_START_COUNT(32),  // Start count is the numeber of clock cycles the master will wait before initiating/issuing any transaction.
    .C_S00_AXIS_TDATA_WIDTH(32),  // AXI4Stream sink: Data Width
    .FIFO_DEPTH_SLV(1280),
    .NUMBER_OF_INPUT_WORDS(1280),
    .FIFO_DEPTH_MS(1280),
    .NUMBER_OF_OUTPUT_WORDS(1280)
  ) inst (
    .s00_axi_awaddr(s00_axi_awaddr),
    .s00_axi_awprot(s00_axi_awprot),
    .s00_axi_awvalid(s00_axi_awvalid),
    .s00_axi_awready(s00_axi_awready),
    .s00_axi_wdata(s00_axi_wdata),
    .s00_axi_wstrb(s00_axi_wstrb),
    .s00_axi_wvalid(s00_axi_wvalid),
    .s00_axi_wready(s00_axi_wready),
    .s00_axi_bresp(s00_axi_bresp),
    .s00_axi_bvalid(s00_axi_bvalid),
    .s00_axi_bready(s00_axi_bready),
    .s00_axi_araddr(s00_axi_araddr),
    .s00_axi_arprot(s00_axi_arprot),
    .s00_axi_arvalid(s00_axi_arvalid),
    .s00_axi_arready(s00_axi_arready),
    .s00_axi_rdata(s00_axi_rdata),
    .s00_axi_rresp(s00_axi_rresp),
    .s00_axi_rvalid(s00_axi_rvalid),
    .s00_axi_rready(s00_axi_rready),
    .s00_axi_aclk(s00_axi_aclk),
    .s00_axi_aresetn(s00_axi_aresetn),
    .m00_axis_tdata(m00_axis_tdata),
    .m00_axis_tlast(m00_axis_tlast),
    .m00_axis_tvalid(m00_axis_tvalid),
    .m00_axis_tready(m00_axis_tready),
    .m00_axis_tuser(m00_axis_tuser),
    .m00_axis_tkeep(m00_axis_tkeep),
    .threshold_pos1(threshold_pos1),
    .threshold_pos2(threshold_pos2),
    .video_lines(video_lines),
    .pixel_count_target(pixel_count_target),
    .threshold_level(threshold_level),
    .new_color(new_color),
    .h_start_value(h_start_value),
    .h_stop_value(h_stop_value),
    .v_start_value(v_start_value),
    .v_stop_value(v_stop_value),
    .motor_update_rate(motor_update_rate),
    .x_pos_per_frame(x_pos_per_frame),
    .y_pos_per_frame(y_pos_per_frame),
    .valid_data(valid_data),
    .motor_offset_x(motor_offset_x),
    .motor_offset_y(motor_offset_y),
    .use_default(use_default),
    .bottom_y_edge_case(bottom_y_edge_case),
    .top_y_edge_case(top_y_edge_case),
    .m00_axis_aclk(m00_axis_aclk),
    .m00_axis_aresetn(m00_axis_aresetn),
    .s00_axis_tdata(s00_axis_tdata),
    .s00_axis_tlast(s00_axis_tlast),
    .s00_axis_tvalid(s00_axis_tvalid),
    .s00_axis_tready(s00_axis_tready),
    .s00_axis_aclk(s00_axis_aclk),
    .s00_axis_aresetn(s00_axis_aresetn)
  );
endmodule
