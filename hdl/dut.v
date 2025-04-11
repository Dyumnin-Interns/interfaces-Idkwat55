//
// Generated by Bluespec Compiler (build d05342e3)
//
// On Tue Oct 11 09:42:23 IST 2022
//
//
// Ports:
// Name                         I/O  size props
// write_rdy                      O     1 const
// read_data                      O     1
// read_rdy                       O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// write_address                  I     3
// write_data                     I     1 reg
// read_address                   I     3
// write_en                       I     1
// read_en                        I     1
//
// Combinational paths from inputs to outputs:
//   read_address -> read_data
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
`define BSV_ASSIGNMENT_DELAY 
`endif

`ifdef BSV_POSITIVE_RESET
`define BSV_RESET_VALUE 1'b1
`define BSV_RESET_EDGE posedge
`else
`define BSV_RESET_VALUE 1'b0
`define BSV_RESET_EDGE negedge
`endif

module dut (
    CLK,
    RST_N,

    write_address,
    write_data,
    write_en,
    write_rdy,

    read_address,
    read_en,
    read_data,
    read_rdy
);
  input CLK;
  input RST_N;

  // action method write
  input [2 : 0] write_address;
  input write_data;
  input write_en;
  output write_rdy;

  // actionvalue method read
  input [2 : 0] read_address;
  input read_en;
  output read_data;
  output read_rdy;

  // signals for module outputs
  reg read_data;
  wire read_rdy, write_rdy;

  // inlined wires
  wire a_data$whas, b_data$whas, pwyff_deq$whas;

  // ports of submodule a_ff
  wire a_ff$CLR, a_ff$DEQ, a_ff$D_IN, a_ff$D_OUT, a_ff$EMPTY_N, a_ff$ENQ, a_ff$FULL_N;

  // ports of submodule b_ff
  wire b_ff$CLR, b_ff$DEQ, b_ff$D_IN, b_ff$D_OUT, b_ff$EMPTY_N, b_ff$ENQ, b_ff$FULL_N;

  // ports of submodule y_ff
  wire y_ff$CLR, y_ff$DEQ, y_ff$D_IN, y_ff$D_OUT, y_ff$EMPTY_N, y_ff$ENQ, y_ff$FULL_N;

  // action method write
  assign write_rdy = 1'd1;

  // actionvalue method read
  always @(read_address or y_ff$EMPTY_N or y_ff$D_OUT or a_ff$FULL_N or b_ff$FULL_N) begin
    case (read_address)
      3'd0: read_data = a_ff$FULL_N;
      3'd1: read_data = b_ff$FULL_N;
      3'd2: read_data = y_ff$EMPTY_N;
      default: read_data = read_address == 3'd3 && y_ff$EMPTY_N && y_ff$D_OUT;
    endcase
  end
  assign read_rdy = 1'd1;

  // submodule a_ff
  FIFO2 #(
      .width  (32'd1),
      .guarded(1'd1)
  ) a_ff (
      .RST(RST_N),
      .CLK(CLK),
      .D_IN(a_ff$D_IN),
      .ENQ(a_ff$ENQ),
      .DEQ(a_ff$DEQ),
      .CLR(a_ff$CLR),
      .D_OUT(a_ff$D_OUT),
      .FULL_N(a_ff$FULL_N),
      .EMPTY_N(a_ff$EMPTY_N)
  );

  // submodule b_ff
  FIFO1 #(
      .width  (32'd1),
      .guarded(1'd1)
  ) b_ff (
      .RST(RST_N),
      .CLK(CLK),
      .D_IN(b_ff$D_IN),
      .ENQ(b_ff$ENQ),
      .DEQ(b_ff$DEQ),
      .CLR(b_ff$CLR),
      .D_OUT(b_ff$D_OUT),
      .FULL_N(b_ff$FULL_N),
      .EMPTY_N(b_ff$EMPTY_N)
  );

  // submodule y_ff
  FIFO2 #(
      .width  (32'd1),
      .guarded(1'd1)
  ) y_ff (
      .RST(RST_N),
      .CLK(CLK),
      .D_IN(y_ff$D_IN),
      .ENQ(y_ff$ENQ),
      .DEQ(y_ff$DEQ),
      .CLR(y_ff$CLR),
      .D_OUT(y_ff$D_OUT),
      .FULL_N(y_ff$FULL_N),
      .EMPTY_N(y_ff$EMPTY_N)
  );

  // inlined wires
  assign a_data$whas = write_en && write_address == 3'd4;
  assign b_data$whas = write_en && write_address == 3'd5;
  assign pwyff_deq$whas = read_en && read_address == 3'd3;

  // submodule a_ff
  assign a_ff$D_IN = write_data;
  assign a_ff$ENQ = a_ff$FULL_N && a_data$whas;
  assign a_ff$DEQ = y_ff$FULL_N && a_ff$EMPTY_N && b_ff$EMPTY_N;
  assign a_ff$CLR = 1'b0;

  // submodule b_ff
  assign b_ff$D_IN = write_data;
  assign b_ff$ENQ = b_ff$FULL_N && b_data$whas;
  assign b_ff$DEQ = y_ff$FULL_N && a_ff$EMPTY_N && b_ff$EMPTY_N;
  assign b_ff$CLR = 1'b0;

  // submodule y_ff
  assign y_ff$D_IN = a_ff$D_OUT || b_ff$D_OUT;
  assign y_ff$ENQ = y_ff$FULL_N && a_ff$EMPTY_N && b_ff$EMPTY_N;
  assign y_ff$DEQ = y_ff$EMPTY_N && pwyff_deq$whas;
  assign y_ff$CLR = 1'b0;
endmodule  // dut

