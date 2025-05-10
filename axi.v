module axi_stream_wrapper(
  input  wire        clk, reset,
  // AXI-Stream Slave
  input  wire [15:0] s_axis_tdata,
  input  wire        s_axis_tvalid,
  output wire        s_axis_tready,
  // AXI-Stream Master
  output wire [15:0] m_axis_tdata,
  output wire        m_axis_tvalid,
  input  wire        m_axis_tready,
  // Fault Injection
  input  wire        inject,
  input  wire [4:0]  fault_pos,
  input  wire        double_error,
  // Perf flags
  output wire        single_error_flag,
  output wire        double_error_flag
);
  // instantiate encoder, fault_injector, decoder, connect tvalid/ready
endmodule
