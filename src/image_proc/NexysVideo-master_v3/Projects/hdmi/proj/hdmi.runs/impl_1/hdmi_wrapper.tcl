proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  create_project -in_memory -part xc7a200tsbg484-1
  set_property board_part digilentinc.com:nexys_video:part0:1.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir D:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.cache/wt [current_project]
  set_property parent.project_path D:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.xpr [current_project]
  set_property ip_repo_paths {
  d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.cache/ip
  D:/Xilinx/Projects/image_proc
} [current_project]
  set_property ip_output_repo d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.cache/ip [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet D:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.runs/synth_1/hdmi_wrapper.dcp
  add_files D:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/hdmi.bmm
  set_property SCOPED_TO_REF hdmi [get_files -all D:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/hdmi.bmm]
  add_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_microblaze_0_0/data/mb_bootloop_le.elf
  set_property SCOPED_TO_REF hdmi [get_files -all d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_microblaze_0_0/data/mb_bootloop_le.elf]
  set_property SCOPED_TO_CELLS microblaze_0 [get_files -all d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_microblaze_0_0/data/mb_bootloop_le.elf]
  read_xdc -prop_thru_buffers -ref hdmi_axi_gpio_video_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_gpio_video_0/hdmi_axi_gpio_video_0_board.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_gpio_video_0/hdmi_axi_gpio_video_0_board.xdc]
  read_xdc -ref hdmi_axi_gpio_video_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_gpio_video_0/hdmi_axi_gpio_video_0.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_gpio_video_0/hdmi_axi_gpio_video_0.xdc]
  read_xdc -ref hdmi_axi_timer_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_timer_0_0/hdmi_axi_timer_0_0.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_timer_0_0/hdmi_axi_timer_0_0.xdc]
  read_xdc -prop_thru_buffers -ref hdmi_axi_uartlite_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_uartlite_0_0/hdmi_axi_uartlite_0_0_board.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_uartlite_0_0/hdmi_axi_uartlite_0_0_board.xdc]
  read_xdc -ref hdmi_axi_uartlite_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_uartlite_0_0/hdmi_axi_uartlite_0_0.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_uartlite_0_0/hdmi_axi_uartlite_0_0.xdc]
  read_xdc -ref hdmi_axi_vdma_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_vdma_0_0/hdmi_axi_vdma_0_0.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_vdma_0_0/hdmi_axi_vdma_0_0.xdc]
  read_xdc -ref hdmi_dvi2rgb_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_dvi2rgb_0_0/src/dvi2rgb.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_dvi2rgb_0_0/src/dvi2rgb.xdc]
  read_xdc -ref hdmi_mdm_1_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_mdm_1_0/hdmi_mdm_1_0.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_mdm_1_0/hdmi_mdm_1_0.xdc]
  read_xdc -ref hdmi_microblaze_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_microblaze_0_0/hdmi_microblaze_0_0.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_microblaze_0_0/hdmi_microblaze_0_0.xdc]
  read_xdc -ref hdmi_dlmb_v10_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_dlmb_v10_0/hdmi_dlmb_v10_0.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_dlmb_v10_0/hdmi_dlmb_v10_0.xdc]
  read_xdc -ref hdmi_ilmb_v10_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_ilmb_v10_0/hdmi_ilmb_v10_0.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_ilmb_v10_0/hdmi_ilmb_v10_0.xdc]
  read_xdc -ref hdmi_mig_7series_0_0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_mig_7series_0_0/hdmi_mig_7series_0_0/user_design/constraints/hdmi_mig_7series_0_0.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_mig_7series_0_0/hdmi_mig_7series_0_0/user_design/constraints/hdmi_mig_7series_0_0.xdc]
  read_xdc -prop_thru_buffers -ref hdmi_mig_7series_0_0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_mig_7series_0_0/hdmi_mig_7series_0_0_board.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_mig_7series_0_0/hdmi_mig_7series_0_0_board.xdc]
  read_xdc -ref hdmi_rgb2dvi_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_rgb2dvi_0_0/src/rgb2dvi.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_rgb2dvi_0_0/src/rgb2dvi.xdc]
  read_xdc -prop_thru_buffers -ref hdmi_rst_mig_7series_0_100M_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_rst_mig_7series_0_100M_0/hdmi_rst_mig_7series_0_100M_0_board.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_rst_mig_7series_0_100M_0/hdmi_rst_mig_7series_0_100M_0_board.xdc]
  read_xdc -ref hdmi_rst_mig_7series_0_100M_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_rst_mig_7series_0_100M_0/hdmi_rst_mig_7series_0_100M_0.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_rst_mig_7series_0_100M_0/hdmi_rst_mig_7series_0_100M_0.xdc]
  read_xdc -prop_thru_buffers -ref hdmi_rst_mig_7series_0_pxl_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_rst_mig_7series_0_pxl_0/hdmi_rst_mig_7series_0_pxl_0_board.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_rst_mig_7series_0_pxl_0/hdmi_rst_mig_7series_0_pxl_0_board.xdc]
  read_xdc -ref hdmi_rst_mig_7series_0_pxl_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_rst_mig_7series_0_pxl_0/hdmi_rst_mig_7series_0_pxl_0.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_rst_mig_7series_0_pxl_0/hdmi_rst_mig_7series_0_pxl_0.xdc]
  read_xdc -ref hdmi_ila_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_ila_0_0/ila_v6_1/constraints/ila.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_ila_0_0/ila_v6_1/constraints/ila.xdc]
  read_xdc -ref fifo_32 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_d_axi_i2s_audio_0_0/src/fifo_32/fifo_32/fifo_32.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_d_axi_i2s_audio_0_0/src/fifo_32/fifo_32/fifo_32.xdc]
  read_xdc -ref fifo_4 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_d_axi_i2s_audio_0_0/src/fifo_4/fifo_4/fifo_4.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_d_axi_i2s_audio_0_0/src/fifo_4/fifo_4/fifo_4.xdc]
  read_xdc -ref hdmi_d_axi_i2s_audio_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_d_axi_i2s_audio_0_0/src/d_axi_i2s_audio.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_d_axi_i2s_audio_0_0/src/d_axi_i2s_audio.xdc]
  read_xdc -prop_thru_buffers -ref hdmi_axi_iic_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_iic_0_0/hdmi_axi_iic_0_0_board.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_iic_0_0/hdmi_axi_iic_0_0_board.xdc]
  read_xdc -ref hdmi_axi_dma_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_dma_0_0/hdmi_axi_dma_0_0.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_dma_0_0/hdmi_axi_dma_0_0.xdc]
  read_xdc -prop_thru_buffers -ref hdmi_axi_gpio_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_gpio_0_0/hdmi_axi_gpio_0_0_board.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_gpio_0_0/hdmi_axi_gpio_0_0_board.xdc]
  read_xdc -ref hdmi_axi_gpio_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_gpio_0_0/hdmi_axi_gpio_0_0.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_gpio_0_0/hdmi_axi_gpio_0_0.xdc]
  read_xdc -ref hdmi_axi_intc_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_intc_0_0/hdmi_axi_intc_0_0.xdc
  set_property processing_order EARLY [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_intc_0_0/hdmi_axi_intc_0_0.xdc]
  read_xdc D:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/src/constraints/NexysVideo_Master.xdc
  read_xdc -ref hdmi_axi_vdma_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_vdma_0_0/hdmi_axi_vdma_0_0_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_vdma_0_0/hdmi_axi_vdma_0_0_clocks.xdc]
  read_xdc -ref hdmi_rgb2dvi_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_rgb2dvi_0_0/src/rgb2dvi_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_rgb2dvi_0_0/src/rgb2dvi_clocks.xdc]
  read_xdc -ref hdmi_v_axi4s_vid_out_0_0 -cells inst d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_v_axi4s_vid_out_0_0/hdmi_v_axi4s_vid_out_0_0_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_v_axi4s_vid_out_0_0/hdmi_v_axi4s_vid_out_0_0_clocks.xdc]
  read_xdc -ref hdmi_v_tc_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_v_tc_0_0/hdmi_v_tc_0_0_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_v_tc_0_0/hdmi_v_tc_0_0_clocks.xdc]
  read_xdc -ref hdmi_v_tc_1_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_v_tc_1_0/hdmi_v_tc_1_0_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_v_tc_1_0/hdmi_v_tc_1_0_clocks.xdc]
  read_xdc -ref hdmi_v_vid_in_axi4s_0_0 -cells inst d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_v_vid_in_axi4s_0_0/hdmi_v_vid_in_axi4s_0_0_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_v_vid_in_axi4s_0_0/hdmi_v_vid_in_axi4s_0_0_clocks.xdc]
  read_xdc -ref fifo_32 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_d_axi_i2s_audio_0_0/src/fifo_32/fifo_32/fifo_32_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_d_axi_i2s_audio_0_0/src/fifo_32/fifo_32/fifo_32_clocks.xdc]
  read_xdc -ref fifo_4 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_d_axi_i2s_audio_0_0/src/fifo_4/fifo_4/fifo_4_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_d_axi_i2s_audio_0_0/src/fifo_4/fifo_4/fifo_4_clocks.xdc]
  read_xdc -ref hdmi_axi_dma_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_dma_0_0/hdmi_axi_dma_0_0_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_dma_0_0/hdmi_axi_dma_0_0_clocks.xdc]
  read_xdc -ref hdmi_axi_intc_0_0 -cells U0 d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_intc_0_0/hdmi_axi_intc_0_0_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_axi_intc_0_0/hdmi_axi_intc_0_0_clocks.xdc]
  read_xdc -ref hdmi_auto_ds_0 -cells inst d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_auto_ds_0/hdmi_auto_ds_0_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_auto_ds_0/hdmi_auto_ds_0_clocks.xdc]
  read_xdc -ref hdmi_auto_ds_1 -cells inst d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_auto_ds_1/hdmi_auto_ds_1_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_auto_ds_1/hdmi_auto_ds_1_clocks.xdc]
  read_xdc -ref hdmi_auto_us_0 -cells inst d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_auto_us_0/hdmi_auto_us_0_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_auto_us_0/hdmi_auto_us_0_clocks.xdc]
  read_xdc -ref hdmi_auto_us_1 -cells inst d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_auto_us_1/hdmi_auto_us_1_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_auto_us_1/hdmi_auto_us_1_clocks.xdc]
  read_xdc -ref hdmi_auto_us_2 -cells inst d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_auto_us_2/hdmi_auto_us_2_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_auto_us_2/hdmi_auto_us_2_clocks.xdc]
  read_xdc -ref hdmi_auto_us_3 -cells inst d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_auto_us_3/hdmi_auto_us_3_clocks.xdc
  set_property processing_order LATE [get_files d:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.srcs/sources_1/bd/hdmi/ip/hdmi_auto_us_3/hdmi_auto_us_3_clocks.xdc]
  link_design -top hdmi_wrapper -part xc7a200tsbg484-1
  write_hwdef -file hdmi_wrapper.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force hdmi_wrapper_opt.dcp
  report_drc -file hdmi_wrapper_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force hdmi_wrapper_placed.dcp
  report_io -file hdmi_wrapper_io_placed.rpt
  report_utilization -file hdmi_wrapper_utilization_placed.rpt -pb hdmi_wrapper_utilization_placed.pb
  report_control_sets -verbose -file hdmi_wrapper_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force hdmi_wrapper_routed.dcp
  report_drc -file hdmi_wrapper_drc_routed.rpt -pb hdmi_wrapper_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file hdmi_wrapper_timing_summary_routed.rpt -rpx hdmi_wrapper_timing_summary_routed.rpx
  report_power -file hdmi_wrapper_power_routed.rpt -pb hdmi_wrapper_power_summary_routed.pb -rpx hdmi_wrapper_power_routed.rpx
  report_route_status -file hdmi_wrapper_route_status.rpt -pb hdmi_wrapper_route_status.pb
  report_clock_utilization -file hdmi_wrapper_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force hdmi_wrapper.mmi }
  catch { write_bmm -force hdmi_wrapper_bd.bmm }
  write_bitstream -force hdmi_wrapper.bit -bin_file
  catch { write_sysdef -hwdef hdmi_wrapper.hwdef -bitfile hdmi_wrapper.bit -meminfo hdmi_wrapper.mmi -file hdmi_wrapper.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

