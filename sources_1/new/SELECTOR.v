module SELECTOR(select, reg_A, reg_B, in, select_data);
    input [1:0]select;
	input [7:0]reg_A;
	input [7:0]reg_B;
	input [7:0]in;
	output reg [7:0]select_data;

    always @(*)begin
        case(select)
            2'b00 : select_data = reg_A;
            2'b01 : select_data = reg_B;
            2'b10 : select_data = in;
            2'b11 : select_data = 8'b00000000;
        endcase
    end
endmodule

