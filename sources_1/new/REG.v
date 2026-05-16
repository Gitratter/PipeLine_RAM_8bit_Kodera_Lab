module REG (
	input CLK, 
	input LOAD, 
	input CNT, 
	input [3:0] IN, 
	output reg [3:0] OUT 
);

always @(posedge CLK) begin
	if (LOAD) 
		OUT <= IN;
	else 
		if (CNT) 
			if (OUT == 4'b1111)
				OUT <= 4'b0000;
			else
				OUT <= OUT + 4'b0001;
		else
			OUT <= OUT;
end

endmodule

