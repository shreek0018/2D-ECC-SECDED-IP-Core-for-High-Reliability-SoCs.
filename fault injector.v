module fault_injector #(parameter WIDTH=32)(
  input  wire                   clk,
  input  wire [WIDTH-1:0]       data_in,
  input  wire                   inject,
  input  wire [$clog2(WIDTH)-1:0] fault_pos,
  input  wire                   double_error,
  output reg  [WIDTH-1:0]       data_out
);
  always @(posedge clk) begin
    if (inject)
      data_out <= data_in ^ (1 << fault_pos) ^ (double_error ? (1 << (fault_pos+1)) : 0);
    else
      data_out <= data_in;
  end
endmodule
