module ALU (
    input  [3:0] INPUT,
    input  [3:0] IM,
    output [3:0] OUTPUT,
    output       CFLAG
);

    wire [4:0] tmp;

    assign tmp = INPUT + IM;
    assign OUTPUT = tmp[3:0];
    assign CFLAG = tmp[4];

endmodule