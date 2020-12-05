`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Samuel Sehnert
// 
// Create Date: 11/14/2020 08:02:03 PM
// Design Name: 
// Module Name: SEG_Driver
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


module SEG_Driver(
    input clk,
    input logic [6:0] digitLEVEL,
    input logic [6:0] digitLEFT,
    input logic [6:0] digitRIGHT,
    output logic [6:0] SEG,
    output logic [3:0] AN
    );  
    integer counter = 0;
    integer max = 8142;
    logic go = 0;
    
    logic [2:0] NS;
    parameter [2:0] LEFTMOST = 2'b00,
                    LEFTMID  = 2'b01,
                    RIGHTMID = 2'b10,
                    RIGHTMOST = 2'b11;
    logic [2:0] currentState = LEFTMOST; 

    
    always_ff @(posedge clk)
        begin
            currentState = NS;
        end
//    always_ff @(posedge clk)
//        begin
//            go = 0;
//            if (counter == max)
//                begin
//                    counter = 0;
//                    go = 1;
//                end
//            counter += 1;
//        end
        
   // always_comb 
   always_comb
        begin
            case(currentState)
            LEFTMOST:
                begin
//                    if (go)
//                        begin
                    SEG = digitLEVEL;
                    AN = 4'b0111;
                    NS = LEFTMID; 
//                        end
//                    else
//                        NS = LEFTMOST;
                end
            LEFTMID:
                begin
                    SEG = 7'b1111111;
                    AN = 4'b1011;
                    NS = RIGHTMID;
                end
            RIGHTMID:
                begin
                    SEG = digitLEFT;
                    AN = 4'b1101;
                    NS = RIGHTMOST;
                end
            RIGHTMOST:
                begin
                    SEG = digitRIGHT;
                    AN = 4'b1110;
                    NS = LEFTMOST;
                end
            default:
                begin
                    SEG = 7'b0111111;
                    AN = 4'b1111;
                    NS = LEFTMOST;
                end
            endcase
        end
endmodule
