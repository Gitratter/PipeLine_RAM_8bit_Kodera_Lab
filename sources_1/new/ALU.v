module ALU(ALUsel, select_data, im, ALU_data, carry);
    input ALUsel;
    input [7:0]select_data;
    input [7:0]im;
    output [7:0]ALU_data;
    output carry;

    assign {carry, ALU_data} = ALUsel ? (select_data-im):(select_data+im);
endmodule
