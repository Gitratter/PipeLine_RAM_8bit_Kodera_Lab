//Decoder
module DECODER(opcode, carry, instr);
    input [3:0]opcode;
    input carry;
    output reg [6:0]instr;
    //instr = selectB, selectA, LOAD0, LOAD1, LOAD2, LOAD3, ALUsel

    always@(*)begin
        case(opcode)
			4'b0011 : instr = 7'b110111x;  //MOV A,Im (Mem bits 0)
            4'b0111 : instr = 7'b111011x;  //MOV B,Im
            4'b0001 : instr = 7'b010111x;  //MOV A,B
            4'b0100 : instr = 7'b001011x;  //MOV B,A
            4'b0000 : instr = 7'b0001110;  //ADD A,Im
            4'b0101 : instr = 7'b0110110;  //ADD B,Im
            4'b1000 : instr = 7'b0001111;  //SUB A,Im 追加
            4'b1101 : instr = 7'b0110111;  //SUB B,Im 追加
            4'b0010 : instr = 7'b100111x;  //IN A
            4'b0110 : instr = 7'b101011x;  //IN B
            4'b1011 : instr = 7'b111101x;  //OUT Im
            4'b1010 : instr = 7'b001101x;  //OUT A 追加
            4'b1001 : instr = 7'b011101x;  //OUT B
            4'b1111 : instr = 7'b111110x;  //JMP Im
			4'b1101 : instr = 7'b0110111;  //JNC Im
            4'b0010 : instr = 7'b100111x;  //NOP
			4'b0110 : instr = 7'b101011x;  //LOAD A,[Im]
			4'b1011 : instr = 7'b111101x;  //LOAD B,[Im]
			4'b1010 : instr = 7'b001101x;  //LOAD OUT,[Im]
			4'b1001 : instr = 7'b011101x;  //STORE A,[Im]
			4'b1111 : instr = 7'b111110x;  //STORE B,[Im]
			4'b1110 : instr = Carry? 7bxx1111x : 7'b111110x;  //STORE OUT,[Im]
            default : instr = 11'b11111111111;
        endcase
    end
endmodule

