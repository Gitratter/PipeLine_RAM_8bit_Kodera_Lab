module TOP(
    input CLOCK_50,
    input [3:0] SW,
    output [3:0] LEDR
);

reg [25:0] cnt = 0;

always @(posedge CLOCK_50) begin
    cnt <= cnt + 1;
end

wire slow_clk = cnt[25];

TD4 td4_inst (
    .CLK(slow_clk),
    .IN(SW),
    //.OUT(LEDR)
);

assign LEDR = td4_inst.ADDR;

endmodule 

