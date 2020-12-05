`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2020 02:13:45 PM
// Design Name: 
// Module Name: Password_FSM
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


module Password_FSM(
    input clk,
    input enter,
//    input [3:0] length,
    input [9:0] Password,
    input [9:0] UserInput,
//    input resetBit,
    output logic success,
    output logic changeLED,
    output logic [9:0] numberCorrect
//    output logic [1:0] numberSuccess = 0
    );
    logic [3:0] correctCounter = 4'b0000;

    always_ff @(posedge clk)
    begin
    success = 0;
    changeLED = 0;
    correctCounter = 0;
    numberCorrect = 0;
    if (enter == 1)
    begin
        for (int i = 0; i < 11; i++)
            begin
                if (UserInput[i] == Password[i])
                    begin
                        correctCounter += 1;
                        numberCorrect[correctCounter - 1] = 1;
                    end
            end
            if (correctCounter >= 11)
                success = 1;
            changeLED = 1;
      end
    end
endmodule