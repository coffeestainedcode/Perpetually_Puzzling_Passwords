`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Samuel Sehnert
// 
// Create Date: 10/08/2020 12:47:02 PM
// Design Name: 
// Module Name: sevenSegment
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sevenSegment(
    input [3:0] BCD,
    output logic [6:0] SEG
    );
    always @ (*)
    begin
        case (BCD)
            0: SEG <= 7'b1000000;
            1: SEG <= 7'b1111001;
            2: SEG <= 7'b0100100;
            3: SEG <= 7'b0110000;
            4: SEG <= 7'b0011001;
            5: SEG <= 7'b0010010;
            6: SEG <= 7'b0000010;
            7: SEG <= 7'b1111000;
            8: SEG <= 7'b0000000;
            9: SEG <= 7'b0010000;
            10: SEG <= 7'b0001000;
            11: SEG <= 7'b0000011;
            12: SEG <= 7'b1000110;
            13: SEG <= 7'b0100001;
            14: SEG <= 7'b0000110;
            15: SEG <= 7'b0001110;
            default: SEG <= 7'b1111111;
        endcase  
    end
endmodule
