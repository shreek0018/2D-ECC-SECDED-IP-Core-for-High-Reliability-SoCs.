module perf_counters(
  input  wire        clk, reset,
  input  wire        valid,
  input  wire        single_error,
  input  wire        double_error,
  output reg [31:0]  total_words,
  output reg [31:0]  corrected_errors,
  output reg [31:0]  double_errors
);
  always @(posedge clk) begin
    if (reset) begin
      total_words     <= 0;
      corrected_errors<= 0;
      double_errors   <= 0;
    end else if (valid) begin
      total_words     <= total_words + 1;
      if (single_error)     corrected_errors <= corrected_errors + 1;
      if (double_error)     double_errors    <= double_errors + 1;
    end
  end
endmodule
