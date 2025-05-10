`timescale 1ns/1ps
module tb_top_ecc;
  // Clock & Reset
  reg         clk = 0;
  reg         reset;

  // AXI-Stream master driving DUT
  reg  [15:0] tdata;
  reg         tvalid;
  wire        tready;

  // AXI-Stream slave receiving from DUT
  wire [15:0] rdata;
  wire        rvalid;
  reg         m_axis_tready;

  // Fault injection controls
  reg         inject;
  reg  [4:0]  fault_pos;
  reg         double_error;

  // Error flags from DUT
  wire        single_error_flag;
  wire        double_error_flag;

  // Generate 100 MHz clock
  always #5 clk = ~clk;

  // Instantiate DUT
  top_ecc uut (
    .clk                (clk),
    .reset              (reset),
    .s_axis_tdata       (tdata),
    .s_axis_tvalid      (tvalid),
    .s_axis_tready      (tready),
    .m_axis_tdata       (rdata),
    .m_axis_tvalid      (rvalid),
    .m_axis_tready      (m_axis_tready),
    .inject             (inject),
    .fault_pos          (fault_pos),
    .double_error       (double_error),
    .single_error_flag  (single_error_flag),
    .double_error_flag  (double_error_flag)
  );

 initial begin
  // Initialize
  reset         = 1;
  tvalid        = 0;
  m_axis_tready = 1;
  inject        = 0;
  double_error  = 0;
  fault_pos     = 0;
  #20 reset = 0;

  // --- No-error for 5 cycles ---
  tdata  = 16'hA5A5;
  tvalid = 1;
  repeat (5) @(posedge clk);    // hold for 5 clocks
  $display("[No-error] in=%h out=%h", tdata, rdata);
  tvalid = 0;
  #200;                          // wait 200 ns

  // --- Single-bit error (@5) for 5 cycles ---
  tdata       = 16'h5A5A;
  inject      = 1; fault_pos = 5; double_error = 0;
  tvalid      = 1;
  repeat (5) @(posedge clk);
  $display("[1-bit]    in=%h out=%h single_flag=%b",
           tdata, rdata, single_error_flag);
  tvalid = 0; inject = 0;
  #200;

  // --- Double-bit error (@7,8) for 5 cycles ---
  tdata       = 16'hF0F0;
  inject      = 1; fault_pos = 7; double_error = 1;
  tvalid      = 1;
  repeat (5) @(posedge clk);
  $display("[2-bit]    in=%h out=%h double_flag=%b",
           tdata, rdata, double_error_flag);
  tvalid = 0; inject = 0;
  #200;
