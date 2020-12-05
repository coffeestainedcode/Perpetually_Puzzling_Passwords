`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2020 07:06:19 PM
// Design Name: 
// Module Name: Perp_Puzz_Password
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


module Perp_Puzz_Password(
    input [9:0] sw,//switches for input
    input clk, //clock
    input enter,//for entering password guesses
    input reset,//for initializing the game ONLY PRESS ONCE
    output [3:0] AN,
    output [6:0] SEG,
    output [9:0] led,
    output winState, failState
//    output bad, good //output for how many you got correct
    );
    logic [3:0] secondsLEFT, secondsRIGHT;
    logic [6:0] displayLEFT, displayRIGHT, displayLEVEL;
    logic sclk;
    
    //logic pressed;
    logic fail;
    logic [9:0] userInput;
    logic [9:0] correctPassword;
    logic [1:0] numberSuccess;
    logic [9:0] outPassword;
    logic [9:0] numberCorrect;
    logic changeLED;
    logic [3:0] nextTimeLEFT, nextTimeRIGHT, currentLevel;
    logic success;
    logic update;
//    logic resetBit;
//    logic [3:0] length;
                
    //registers for storing data        
    register #(10) userReg (.clk(clk), .clr(0), .set(0), .enable(enter), .D(sw), .Q(userInput));
    register #(10) passwordReg (.clk(clk), .clr(0), .set(0), .enable(update), .D(outPassword), .Q(correctPassword));
    register #(10) displayReg (.clk(clk), .clr(0), .set(0), .enable(changeLED | reset), .D(numberCorrect), .Q(led));
        
    //game logic
    Password_Checker PFSM (.clk(sclk), .enter(enter), .Password(correctPassword), .UserInput(userInput), 
                        .success(success), .numberCorrect(numberCorrect), .changeLED(changeLED));
    GameStateFSM GSFSM(.clk(sclk),.success(success),.fail(fail),.reset(reset),
                       .startTimeLEFT(nextTimeLEFT), .startTimeRIGHT(nextTimeRIGHT), .currentLevel(currentLevel), 
                       .update(update), .newPassword(outPassword), .winState(winState), .failState(failState));

    //all modules relating to clockcount and display
    clk_div2 clkdivmain (.clk(clk), .sclk(sclk));
    CLK_Divider clkdiv (.clk(clk), .startTimeLEFT(nextTimeLEFT), .startTimeRIGHT(nextTimeRIGHT), 
                                   .secondsLEFT(secondsLEFT), .secondsRIGHT(secondsRIGHT), 
                                   .fail(fail), .reset(reset));
    sevenSegment SSG0 (.BCD(secondsLEFT), .SEG(displayLEFT));
    sevenSegment SSG1 (.BCD(secondsRIGHT), .SEG(displayRIGHT));
    sevenSegment SSG2 (.BCD(currentLevel), .SEG(displayLEVEL));
    SEG_Driver ssgdriver (.clk(sclk), .digitLEFT(displayLEFT), 
                          .digitRIGHT(displayRIGHT), 
                          .digitLEVEL(displayLEVEL), .SEG(SEG), .AN(AN));                              
endmodule
