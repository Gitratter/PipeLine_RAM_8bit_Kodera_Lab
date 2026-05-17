//Decoder
module DECODER(opcode, carry, instr);
	input [4:0]opcode;
    input carry;
	output reg [10:0]instr;
    //instr = selectB, selectA, LOAD0, LOAD1, LOAD2, LOAD3, ALUsel

    always@(*)begin
        case(opcode)
			5'b00011 : instr = 11'b110111x_0_0_00;  //MOV A,Im (Mem bits 0)
            5'b00111 : instr = 11'b111011x_0_0_00;  //MOV B,Im
            5'b00001 : instr = 11'b010111x_0_0_00;  //MOV A,B
            5'b00100 : instr = 11'b001011x_0_0_00;  //MOV B,A
            5'b00000 : instr = 11'b0001110_0_0_00;  //ADD A,Im
            5'b00101 : instr = 11'b0110110_0_0_00;  //ADD B,Im
            5'b01000 : instr = 11'b0001111_0_0_00;  //SUB A,Im 追加
            5'b01101 : instr = 11'b0110111_0_0_00;  //SUB B,Im 追加
            5'b00010 : instr = 11'b100111x_0_0_00;  //IN A
            5'b00110 : instr = 11'b101011x_0_0_00;  //IN B
            5'b01011 : instr = 11'b111101x_0_0_00;  //OUT Im
            5'b01010 : instr = 11'b001101x_0_0_00;  //OUT A 追加
            5'b01001 : instr = 11'b011101x_0_0_00;  //OUT B
            5'b01111 : instr = 11'b111110x_0_0_00;  //JMP Im
			5'b01110 : instr = Carry? 11'bxx1111x_0_0_00 : 11'b111110x_0_0_00;  //JNC Im
            5'b01100 : instr = 11'b111111x_0_0_00;  //NOP
			5'b10000 : instr = 11'b001111x_1_0_00;  //LOAD A,[Im]
			5'b10001 : instr = 11'b011111x_1_0_01;  //LOAD B,[Im]
			5'b10010 : instr = 11'bxx1111x_1_0_10;  //LOAD OUT,[Im]
			5'b10011 : instr = 11'b001111x_0_1_00;  //STORE A,[Im]
			5'b10100 : instr = 11'b011111x_0_1_01;  //STORE B,[Im]
			5'b10101 : instr = 11'bxx1111x_0_1_10;  //STORE OUT,[Im]
            default : instr = 11'b11111111111;
        endcase
    end
endmodule

