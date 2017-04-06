--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
--Date        : Thu Mar 30 19:17:09 2017
--Host        : RLIN-GAMING running 64-bit major release  (build 9200)
--Command     : generate_target hdmi_wrapper.bd
--Design      : hdmi_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity hdmi_wrapper is
  port (
    BCLK_O : out STD_LOGIC;
    DDR3_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR3_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR3_cas_n : out STD_LOGIC;
    DDR3_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    DDR3_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_ras_n : out STD_LOGIC;
    DDR3_reset_n : out STD_LOGIC;
    DDR3_we_n : out STD_LOGIC;
    DIR_1 : out STD_LOGIC;
    DIR_2 : out STD_LOGIC;
    ENC_1 : in STD_LOGIC;
    ENC_2 : in STD_LOGIC;
    LRCLK_O : out STD_LOGIC;
    MCLK_O : out STD_LOGIC;
    MODE : in STD_LOGIC_VECTOR ( 1 downto 0 );
    PWM : out STD_LOGIC;
    SDATA_I : in STD_LOGIC;
    SDATA_O : out STD_LOGIC;
    TMDS_IN_clk_n : in STD_LOGIC;
    TMDS_IN_clk_p : in STD_LOGIC;
    TMDS_IN_data_n : in STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_IN_data_p : in STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_OUT_clk_n : out STD_LOGIC;
    TMDS_OUT_clk_p : out STD_LOGIC;
    TMDS_OUT_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_OUT_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 );
    btn : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ddc_scl_io : inout STD_LOGIC;
    ddc_sda_io : inout STD_LOGIC;
    hdmi_hpd : out STD_LOGIC_VECTOR ( 0 to 0 );
    hdmi_rx_txen : out STD_LOGIC_VECTOR ( 0 to 0 );
    iic_rtl_scl_io : inout STD_LOGIC;
    iic_rtl_sda_io : inout STD_LOGIC;
    led : out STD_LOGIC_VECTOR ( 2 downto 0 );
    miso : in STD_LOGIC;
    mled : out STD_LOGIC_VECTOR ( 4 downto 0 );
    mosi : out STD_LOGIC;
    reset : in STD_LOGIC;
    sclk : out STD_LOGIC;
    ss : out STD_LOGIC;
    sw : in STD_LOGIC_VECTOR ( 2 downto 0 );
    sys_clk_i : in STD_LOGIC;
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC
  );
end hdmi_wrapper;

architecture STRUCTURE of hdmi_wrapper is
  component hdmi is
  port (
    DDC_scl_i : in STD_LOGIC;
    DDC_scl_o : out STD_LOGIC;
    DDC_scl_t : out STD_LOGIC;
    DDC_sda_i : in STD_LOGIC;
    DDC_sda_o : out STD_LOGIC;
    DDC_sda_t : out STD_LOGIC;
    DDR3_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    DDR3_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR3_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR3_ras_n : out STD_LOGIC;
    DDR3_cas_n : out STD_LOGIC;
    DDR3_we_n : out STD_LOGIC;
    DDR3_reset_n : out STD_LOGIC;
    DDR3_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    TMDS_IN_clk_p : in STD_LOGIC;
    TMDS_IN_clk_n : in STD_LOGIC;
    TMDS_IN_data_p : in STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_IN_data_n : in STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_OUT_clk_p : out STD_LOGIC;
    TMDS_OUT_clk_n : out STD_LOGIC;
    TMDS_OUT_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_OUT_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC;
    iic_rtl_scl_i : in STD_LOGIC;
    iic_rtl_scl_o : out STD_LOGIC;
    iic_rtl_scl_t : out STD_LOGIC;
    iic_rtl_sda_i : in STD_LOGIC;
    iic_rtl_sda_o : out STD_LOGIC;
    iic_rtl_sda_t : out STD_LOGIC;
    hdmi_hpd : out STD_LOGIC_VECTOR ( 0 to 0 );
    reset : in STD_LOGIC;
    sys_clk_i : in STD_LOGIC;
    hdmi_rx_txen : out STD_LOGIC_VECTOR ( 0 to 0 );
    DIR_1 : out STD_LOGIC;
    DIR_2 : out STD_LOGIC;
    PWM : out STD_LOGIC;
    MODE : in STD_LOGIC_VECTOR ( 1 downto 0 );
    ENC_1 : in STD_LOGIC;
    ENC_2 : in STD_LOGIC;
    ss : out STD_LOGIC;
    mosi : out STD_LOGIC;
    sclk : out STD_LOGIC;
    led : out STD_LOGIC_VECTOR ( 2 downto 0 );
    mled : out STD_LOGIC_VECTOR ( 4 downto 0 );
    miso : in STD_LOGIC;
    sw : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SDATA_O : out STD_LOGIC;
    MCLK_O : out STD_LOGIC;
    BCLK_O : out STD_LOGIC;
    LRCLK_O : out STD_LOGIC;
    SDATA_I : in STD_LOGIC;
    btn : in STD_LOGIC_VECTOR ( 4 downto 0 )
  );
  end component hdmi;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal ddc_scl_i : STD_LOGIC;
  signal ddc_scl_o : STD_LOGIC;
  signal ddc_scl_t : STD_LOGIC;
  signal ddc_sda_i : STD_LOGIC;
  signal ddc_sda_o : STD_LOGIC;
  signal ddc_sda_t : STD_LOGIC;
  signal iic_rtl_scl_i : STD_LOGIC;
  signal iic_rtl_scl_o : STD_LOGIC;
  signal iic_rtl_scl_t : STD_LOGIC;
  signal iic_rtl_sda_i : STD_LOGIC;
  signal iic_rtl_sda_o : STD_LOGIC;
  signal iic_rtl_sda_t : STD_LOGIC;
begin
ddc_scl_iobuf: component IOBUF
     port map (
      I => ddc_scl_o,
      IO => ddc_scl_io,
      O => ddc_scl_i,
      T => ddc_scl_t
    );
ddc_sda_iobuf: component IOBUF
     port map (
      I => ddc_sda_o,
      IO => ddc_sda_io,
      O => ddc_sda_i,
      T => ddc_sda_t
    );
hdmi_i: component hdmi
     port map (
      BCLK_O => BCLK_O,
      DDC_scl_i => ddc_scl_i,
      DDC_scl_o => ddc_scl_o,
      DDC_scl_t => ddc_scl_t,
      DDC_sda_i => ddc_sda_i,
      DDC_sda_o => ddc_sda_o,
      DDC_sda_t => ddc_sda_t,
      DDR3_addr(14 downto 0) => DDR3_addr(14 downto 0),
      DDR3_ba(2 downto 0) => DDR3_ba(2 downto 0),
      DDR3_cas_n => DDR3_cas_n,
      DDR3_ck_n(0) => DDR3_ck_n(0),
      DDR3_ck_p(0) => DDR3_ck_p(0),
      DDR3_cke(0) => DDR3_cke(0),
      DDR3_dm(1 downto 0) => DDR3_dm(1 downto 0),
      DDR3_dq(15 downto 0) => DDR3_dq(15 downto 0),
      DDR3_dqs_n(1 downto 0) => DDR3_dqs_n(1 downto 0),
      DDR3_dqs_p(1 downto 0) => DDR3_dqs_p(1 downto 0),
      DDR3_odt(0) => DDR3_odt(0),
      DDR3_ras_n => DDR3_ras_n,
      DDR3_reset_n => DDR3_reset_n,
      DDR3_we_n => DDR3_we_n,
      DIR_1 => DIR_1,
      DIR_2 => DIR_2,
      ENC_1 => ENC_1,
      ENC_2 => ENC_2,
      LRCLK_O => LRCLK_O,
      MCLK_O => MCLK_O,
      MODE(1 downto 0) => MODE(1 downto 0),
      PWM => PWM,
      SDATA_I => SDATA_I,
      SDATA_O => SDATA_O,
      TMDS_IN_clk_n => TMDS_IN_clk_n,
      TMDS_IN_clk_p => TMDS_IN_clk_p,
      TMDS_IN_data_n(2 downto 0) => TMDS_IN_data_n(2 downto 0),
      TMDS_IN_data_p(2 downto 0) => TMDS_IN_data_p(2 downto 0),
      TMDS_OUT_clk_n => TMDS_OUT_clk_n,
      TMDS_OUT_clk_p => TMDS_OUT_clk_p,
      TMDS_OUT_data_n(2 downto 0) => TMDS_OUT_data_n(2 downto 0),
      TMDS_OUT_data_p(2 downto 0) => TMDS_OUT_data_p(2 downto 0),
      btn(4 downto 0) => btn(4 downto 0),
      hdmi_hpd(0) => hdmi_hpd(0),
      hdmi_rx_txen(0) => hdmi_rx_txen(0),
      iic_rtl_scl_i => iic_rtl_scl_i,
      iic_rtl_scl_o => iic_rtl_scl_o,
      iic_rtl_scl_t => iic_rtl_scl_t,
      iic_rtl_sda_i => iic_rtl_sda_i,
      iic_rtl_sda_o => iic_rtl_sda_o,
      iic_rtl_sda_t => iic_rtl_sda_t,
      led(2 downto 0) => led(2 downto 0),
      miso => miso,
      mled(4 downto 0) => mled(4 downto 0),
      mosi => mosi,
      reset => reset,
      sclk => sclk,
      ss => ss,
      sw(2 downto 0) => sw(2 downto 0),
      sys_clk_i => sys_clk_i,
      usb_uart_rxd => usb_uart_rxd,
      usb_uart_txd => usb_uart_txd
    );
iic_rtl_scl_iobuf: component IOBUF
     port map (
      I => iic_rtl_scl_o,
      IO => iic_rtl_scl_io,
      O => iic_rtl_scl_i,
      T => iic_rtl_scl_t
    );
iic_rtl_sda_iobuf: component IOBUF
     port map (
      I => iic_rtl_sda_o,
      IO => iic_rtl_sda_io,
      O => iic_rtl_sda_i,
      T => iic_rtl_sda_t
    );
end STRUCTURE;
