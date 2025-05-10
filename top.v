module top_ecc(
  input  wire        clk, reset,
  // AXI-Stream In
  input  wire [15:0] s_axis_tdata,
  input  wire        s_axis_tvalid,
  output wire        s_axis_tready,
  // AXI-Stream Out
  output wire [15:0] m_axis_tdata,
  output wire        m_axis_tvalid,
  input  wire        m_axis_tready,
  // Fault Inject
  input  wire        inject,
  input  wire [4:0]  fault_pos,
  input  wire        double_error,
  // Reporting
  input  wire        report_btn,
  output wire        uart_txd
);
  // Instantiate: Encoding, fault_injector, Decoding
  // Instantiate: perf_counters, uart_reporter
  // Wire up AXI handshakes
endmodule
