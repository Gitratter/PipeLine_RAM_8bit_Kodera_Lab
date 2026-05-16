module SELECTOR (
	input [3:0] REGA, 
	input [3:0] REGB, 
	input [3:0] IN, 
	input [1:0] SEL,
	output reg [3:0] OUT 
);

always @* begin
	case (SEL)
		2'b00: OUT <= REGA;
		2'b01: OUT <= REGB;
		2'b10: OUT <= IN;
		2'b11 : OUT <= 4'b0000;
		default: OUT = 4'b0000;
	endcase
end

endmodule

