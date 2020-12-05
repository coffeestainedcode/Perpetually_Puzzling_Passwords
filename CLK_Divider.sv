`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2020 03:03:25 PM
// Design Name: 
// Module Name: CLK_Divider
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


module CLK_Divider(
    input clk,
    input reg [3:0] startTimeLEFT, startTimeRIGHT,
    input reset,
    output reg [3:0] secondsLEFT, secondsRIGHT,
    output logic fail = 0
    );
    localparam max = 100000000 - 1;//one second
    integer counter = 0;
    logic init = 1;
    logic [3:0] oldTimeLEFT, oldTimeRIGHT;
   
    
    always_ff @ (posedge clk)
        begin
            fail = 0;
            if (init == 1 || (oldTimeLEFT != startTimeLEFT) || reset == 1)
                begin
                oldTimeLEFT = startTimeLEFT;
                secondsLEFT = startTimeLEFT;
                secondsRIGHT = startTimeRIGHT;
                init = 0;
                end
            if (counter == max)
                begin
                    counter = 0;
                    if (secondsRIGHT == 0 && secondsLEFT == 0)
                    begin
                        secondsRIGHT = 0;
                        secondsLEFT = 0;
                    end
                    else if (secondsRIGHT == 4'b0000)
                        begin
                            secondsRIGHT = 4'b1001;
                            secondsLEFT -= 1;
                        end
                    else
                        secondsRIGHT -= 1;
                end
            else
                counter += 1'd1;
            if(secondsLEFT == 4'b0000 &&
               secondsRIGHT == 4'b0000 /*&&
               startTimeLEFT != 0 && 
               startTimeRIGHT != 0*/)
               begin
                    fail = 1;
               end
        end
endmodule
