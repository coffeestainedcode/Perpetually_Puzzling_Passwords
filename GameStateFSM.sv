`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2020 04:11:41 PM
// Design Name: 
// Module Name: GameStateFSM
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


module GameStateFSM(
    input clk,
    input success,
    input fail,
    input reset,
    output logic [3:0] startTimeLEFT, startTimeRIGHT, currentLevel,
    output logic update,
    //output logic resetBit,
    output logic [9:0] newPassword,
    output logic failState, winState
    );
 
    //declare present state (PS) and next state (NS) variables to
    //be the size of log2(number of states)
    //initialize PS to the beginning state
    logic [2:0] NS;
    logic [2:0] PS = START;
 
    //assign bit values to your states
    //again the size should be log2(number of states)
    parameter [2:0] START = 3'b000, ST1 = 3'b001, ST2= 3'b010, ST3 = 3'b011, Win = 3'b100, Fail= 3'b101;
 
    //sequential logic to change states
    always_ff @ (posedge clk)
    begin
             PS = NS;
    end
 
    //combinatorial logic 
    always_comb 
    begin
    case (PS)
        START:
            begin  
                failState = 0; winState = 0;
                newPassword = 10'b1100110011; 
//                 newPassword = 10'b0;              
//                 startTimeLEFT = 0;
//                 startTimeRIGHT = 0;
//                 currentLevel=0;     
                update = 1;
                NS = ST1;
             end         
         ST1:
             begin
//                newPassword = 10'b1100110011;              
                startTimeLEFT = 9;
                 startTimeRIGHT = 0;
                 currentLevel=1;
                 update = 0;
                  NS = ST1;
                  if (success == 1)
                    begin
                        newPassword = 10'b1011001101;
                        update = 1;
                        NS = ST2;
                    end                    
                   if (fail == 1)
                        begin
                            NS = Fail;
                        end
                   if ( reset == 1)
                        begin
                             newPassword = 10'b0;              
                 startTimeLEFT = 0;
                 startTimeRIGHT = 0;
                 currentLevel=0;  
                            NS = START;
                        end
 
             end         
         ST2:
             begin
//                newPassword = 10'b1011001101;
                startTimeLEFT = 6;
                startTimeRIGHT = 0;
                currentLevel = 2;
                update = 0;
                NS = ST2;
                if (success == 1)
                begin
//                    newPassword = 10'b1110010100;
                    newPassword = 10'b1110010100;
                    update = 1;
                    NS = ST3;
                end
                 if(fail == 1)
                    begin
                        NS = Fail;
                    end
                if ( reset == 1)
                    begin
                         newPassword = 10'b0;              
                 startTimeLEFT = 0;
                 startTimeRIGHT = 0;
                 currentLevel=0;  
                        NS = START;
                    end
 
              end
          ST3:
              begin
//                

                startTimeLEFT = 3;
                startTimeRIGHT = 0;
                update = 0;
                currentLevel = 3;
                //resetBit = 0;
                    NS = ST3;
                if (success == 1)
                    begin
                        update = 1;
                       NS = Win;
                    end
                 if( fail == 1)
                    begin
                        NS = Fail;            
                    end
                 if ( reset == 1)
                    begin
                     newPassword = 10'b0;              
                 startTimeLEFT = 0;
                 startTimeRIGHT = 0;
                 currentLevel=0;  
                        NS = START;
                    end
             end
 
         Fail:
             begin
                 failState=1;
                 NS = Fail;
                 if ( reset == 1)
                    begin
                     newPassword = 10'b0;              
                     startTimeLEFT = 0;
                     startTimeRIGHT = 0;
                     currentLevel=0;  
                     NS = START;
                    end
             end
         Win:
            begin
                winState = 1;
                NS = Win;  
                if ( reset == 1)
                    begin
                     newPassword = 10'b0;              
                     startTimeLEFT = 0;
                     startTimeRIGHT = 0;
                     currentLevel=0;  
                     NS = START;
                    end       
            end
         default:
            NS = START;
      endcase      
      end       
endmodule