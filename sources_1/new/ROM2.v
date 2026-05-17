//ROM module 8bit 
module ROM(pcnt, command);
    input [3:0]pcnt;
	output [12:0]command;

	reg [12:0]rom[0:13];
    initial begin
		rom[0] = {5'b00000, 8'b11111111};  //ADD A, 11111111
		rom[1] = {5'b01010, 8'b00000000};  //OUT A
		rom[2] = {5'b10011, 8'b00000001};  //STORE A, [0001]
		rom[3] = {5'b01100, 8'b00000000};  //NOP
		rom[4] = {5'b01100, 8'b00000000};  //NOP
		rom[5] = {5'b01100, 8'b00000000};  //NOP
		rom[6] = {5'b00000, 8'b00000001};  //ADD A, 1
		rom[7] = {5'b01010, 8'b00000000};  //OUT A
		rom[8] = {5'b10000, 8'b00000001};  //LOAD A,
		rom[9] = {5'b01100, 8'b00000000};  //NOP
		rom[10] = {5'b01100, 8'b00000000};  //NOP
		rom[11] = {5'b01100, 8'b00000000};  //NOP
		rom[12] = {5'b01010, 8'b00000000};  //OUT A
		rom[13] = {5'b01100, 8'b00000000};  //NOP
		
    end
    assign command = rom[pcnt];
endmodule

