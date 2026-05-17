module RAM (
  input clk,
  input we, //write enable
  input [7:0] addr, //addres
  input [7:0] din, //data in
  output reg [7:0] dout //data out
);
  reg [7:0] mem [0:255];

  always @(posedge clk)begin
    if(we)begin
      mem[addr] <= din;
    end
    dout <= mem[addr];
  end
endmodule

