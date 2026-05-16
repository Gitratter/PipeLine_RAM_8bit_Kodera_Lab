module TOP(
    input        CLOCK_50,
    output [3:0] LEDR;
);

reg [25:0] cnt = 0;

always @(posedge CLOCK_50) begin
    cnt <= cnt + 1;
end

assign LEDR[3:0] = cnt[25:22];

endmodule
